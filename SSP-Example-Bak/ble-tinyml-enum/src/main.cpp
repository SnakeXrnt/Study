#include <Arduino.h>

// IMMEDIATELY undefine Arduino macros that conflict with C++ std library
#undef abs
#undef min
#undef max
#undef round

#include <Arduino_BMI270_BMM150.h>
#include <Wire.h>

#include "log/arduino/log.hpp"
#include "swipe_model.h"
#include "tflite_compat.h"
#include "BleConnectionEnum.h"

/* --- Configuration --- */
#define SAMPLE_RATE_HZ          100
#define WINDOW_SAMPLES          300
#define MIN_SAMPLES             50
#define MAX_RECORD_TIME_S       4.0f

#define START_ENERGY_THRESHOLD  0.10f
#define END_ENERGY_THRESHOLD    0.06f
#define ENERGY_WINDOW           20

#define BASE_POSITION_WINDOW    50
#define BASE_POSITION_TOLERANCE 0.3f  // in g's

#define COOLDOWN_DURATION_S     0.3f
#define N_FEATURES              3  // Accelerometer only (accX, accY, accZ)

// Pre-buffer: stores 200ms of data before motion detection
#define PRE_BUFFER_MS           300
#define PRE_BUFFER_SAMPLES      ((SAMPLE_RATE_HZ * PRE_BUFFER_MS) / 1000)  // 20 samples at 100Hz

/* TensorFlow Lite globals */
namespace {
const tflite::Model *model            = nullptr;
tflite::MicroInterpreter *interpreter = nullptr;
TfLiteTensor *input                   = nullptr;
TfLiteTensor *output                  = nullptr;

constexpr int kTensorArenaSize = 64 * 1024;
uint8_t tensor_arena[kTensorArenaSize];
}  // namespace

/* --- State Machine --- */
enum class GestureState : uint8_t { IDLE = 0, RECORDING = 1, COOLDOWN = 2 };

/* --- Command/Gesture Enum --- */
enum class CommandName : uint8_t {
    COBRA = 0,
    UP    = 1,
    DOWN  = 2,
    LEFT  = 3,
    RIGHT = 4,
    STILL = 5,
    UNKNOWN = 255
};

const char *CommandNames[] = {"COBRA", "UP", "DOWN", "LEFT", "RIGHT", "STILL"};

// Mapping from model output indices (alphabetical order) to CommandName enum
// Model outputs: ["cobra", "down", "left", "right", "still", "up"] (indices 0-5)
const CommandName ModelToCommandMap[] = {
    CommandName::COBRA,  // Model index 0 (cobra)
    CommandName::DOWN,   // Model index 1 (down)
    CommandName::LEFT,   // Model index 2 (left)
    CommandName::RIGHT,  // Model index 3 (right)
    CommandName::STILL,  // Model index 4 (still)
    CommandName::UP      // Model index 5 (up)
};

/* --- Sample Structure (Accelerometer Only) --- */
struct Sample {
    float ax;
    float ay;
    float az;
};

/* --- Global State --- */
BleConnectionEnum ble;
static GestureState g_state = GestureState::IDLE;
static Sample g_recording_buffer[WINDOW_SAMPLES];
static int g_buffer_size                 = 0;
static unsigned long g_record_start_us   = 0;
static unsigned long g_cooldown_until_us = 0;

/* --- Energy Tracking --- */
static float g_energy_buffer[ENERGY_WINDOW];
static int g_energy_head         = 0;
static int g_energy_size         = 0;
static float g_prev_ax           = 0.0f;
static float g_prev_ay           = 0.0f;
static float g_prev_az           = 0.0f;
static bool g_energy_initialized = false;

/* --- Base Position Tracking --- */
static Sample g_base_buffer[BASE_POSITION_WINDOW];
static int g_base_head        = 0;
static int g_base_size        = 0;
static Sample g_base_position = {0.0f, 0.0f, 0.0f};
static bool g_calibrating     = true;

/* --- Pre-Buffer: Circular buffer for 200ms before motion detection --- */
static Sample g_pre_buffer[PRE_BUFFER_SAMPLES];
static int g_pre_buffer_head = 0;
static int g_pre_buffer_size = 0;

static int g_gestures_detected   = 0;
static int g_gestures_classified = 0;

static logger::arduino::Logger *g_logger = nullptr;

/* --- Timing --- */
static unsigned long g_last_sample_us = 0;

/* --- Helper Functions --- */

static inline void energy_push(float e) {
    g_energy_buffer[g_energy_head] = e;
    g_energy_head                  = (g_energy_head + 1) % ENERGY_WINDOW;
    if (g_energy_size < ENERGY_WINDOW) g_energy_size++;
}

static inline float energy_avg() {
    if (g_energy_size == 0) return 0.0f;
    float sum = 0.0f;
    for (int i = 0; i < g_energy_size; i++) {
        sum += g_energy_buffer[i];
    }
    return sum / static_cast<float>(g_energy_size);
}

static inline float calculate_energy(const Sample &s) {
    if (!g_energy_initialized) {
        g_prev_ax            = s.ax;
        g_prev_ay            = s.ay;
        g_prev_az            = s.az;
        g_energy_initialized = true;
        return 0.0f;
    }

    // Jerk: sum of absolute changes
    float jerk = fabsf(s.ax - g_prev_ax) + fabsf(s.ay - g_prev_ay) + fabsf(s.az - g_prev_az);

    g_prev_ax = s.ax;
    g_prev_ay = s.ay;
    g_prev_az = s.az;

    return jerk;
}

static inline void base_position_push(const Sample &s) {
    g_base_buffer[g_base_head] = s;
    g_base_head                = (g_base_head + 1) % BASE_POSITION_WINDOW;
    if (g_base_size < BASE_POSITION_WINDOW) g_base_size++;
}

static void update_base_position(const Sample &s) {
    base_position_push(s);

    if (g_base_size >= BASE_POSITION_WINDOW && g_calibrating) {
        float sum_x = 0.0f, sum_y = 0.0f, sum_z = 0.0f;
        for (int i = 0; i < g_base_size; i++) {
            sum_x += g_base_buffer[i].ax;
            sum_y += g_base_buffer[i].ay;
            sum_z += g_base_buffer[i].az;
        }

        g_base_position.ax = sum_x / g_base_size;
        g_base_position.ay = sum_y / g_base_size;
        g_base_position.az = sum_z / g_base_size;

        g_calibrating = false;

        if (Serial && g_logger) {
            g_logger->info(
                "Base position calibrated: [{:.2f}, {:.2f}, {:.2f}] g",
                g_base_position.ax,
                g_base_position.ay,
                g_base_position.az
            );
            g_logger->info("System ready! Waiting for gestures...");
            g_logger->info("------------------------------------------------------------");
        }
    }
}

static inline bool is_at_base_position(const Sample &s) {
    if (g_calibrating) return false;

    float diff_x = fabsf(s.ax - g_base_position.ax);
    float diff_y = fabsf(s.ay - g_base_position.ay);
    float diff_z = fabsf(s.az - g_base_position.az);

    return (diff_x < BASE_POSITION_TOLERANCE) && (diff_y < BASE_POSITION_TOLERANCE)
        && (diff_z < BASE_POSITION_TOLERANCE);
}

static inline void pre_buffer_push(const Sample &s) {
    g_pre_buffer[g_pre_buffer_head] = s;
    g_pre_buffer_head               = (g_pre_buffer_head + 1) % PRE_BUFFER_SAMPLES;
    if (g_pre_buffer_size < PRE_BUFFER_SAMPLES) g_pre_buffer_size++;
}

static void copy_pre_buffer_to_recording() {
    int start_idx = (g_pre_buffer_size < PRE_BUFFER_SAMPLES) ? 0 : g_pre_buffer_head;

    for (int i = 0; i < g_pre_buffer_size; i++) {
        int idx                             = (start_idx + i) % PRE_BUFFER_SAMPLES;
        g_recording_buffer[g_buffer_size++] = g_pre_buffer[idx];
    }

    if (Serial && g_logger) {
        g_logger->info(
            "  Added {} pre-buffer samples ({} ms before detection)", g_pre_buffer_size, PRE_BUFFER_MS
        );
    }
}

static CommandName classify_gesture() {
    if (input == nullptr || output == nullptr || interpreter == nullptr) {
        if (Serial && g_logger) g_logger->error("TFLite not initialized");
        return CommandName::UNKNOWN;
    }

    const int num_samples = g_buffer_size;

    float min_x = g_recording_buffer[0].ax, max_x = g_recording_buffer[0].ax, sum_x = 0.0f;
    float min_y = g_recording_buffer[0].ay, max_y = g_recording_buffer[0].ay, sum_y = 0.0f;
    float min_z = g_recording_buffer[0].az, max_z = g_recording_buffer[0].az, sum_z = 0.0f;

    for (int i = 0; i < num_samples; i++) {
        const Sample &s = g_recording_buffer[i];
        min_x  = fminf(min_x, s.ax); max_x  = fmaxf(max_x, s.ax); sum_x += s.ax;
        min_y  = fminf(min_y, s.ay); max_y  = fmaxf(max_y, s.ay); sum_y += s.ay;
        min_z  = fminf(min_z, s.az); max_z  = fmaxf(max_z, s.az); sum_z += s.az;
    }

    float mean_x = sum_x / num_samples;
    float mean_y = sum_y / num_samples;
    float mean_z = sum_z / num_samples;

    if (Serial && g_logger) {
        g_logger->info("  Sample statistics (in g):");
        g_logger->info("    Samples: {}", num_samples);
        g_logger->info("    AccX: [{:.2f}, {:.2f}]  mean: {:.2f}", min_x, max_x, mean_x);
        g_logger->info("    AccY: [{:.2f}, {:.2f}]  mean: {:.2f}", min_y, max_y, mean_y);
        g_logger->info("    AccZ: [{:.2f}, {:.2f}]  mean: {:.2f}", min_z, max_z, mean_z);
    }

    const float G_TO_MS2 = 9.8f;
    for (int i = 0; i < WINDOW_SAMPLES; i++) {
        if (i < num_samples) {
            input->data.f[i * 3 + 0] = g_recording_buffer[i].ax * G_TO_MS2;
            input->data.f[i * 3 + 1] = g_recording_buffer[i].ay * G_TO_MS2;
            input->data.f[i * 3 + 2] = g_recording_buffer[i].az * G_TO_MS2;
        } else {
            input->data.f[i * 3 + 0] = 0.0f;
            input->data.f[i * 3 + 1] = 0.0f;
            input->data.f[i * 3 + 2] = 0.0f;
        }
    }

    if (interpreter->Invoke() != kTfLiteOk) {
        if (Serial && g_logger) g_logger->error("Inference failed!");
        return CommandName::UNKNOWN;
    }

    float max_confidence = 0.0f;
    int predicted_idx    = 0;

    for (int i = 0; i < NUM_GESTURES; i++) {
        float confidence = output->data.f[i];
        if (confidence > max_confidence) {
            max_confidence = confidence;
            predicted_idx  = i;
        }
    }

    CommandName predicted_command = (predicted_idx >= 0 && predicted_idx < NUM_GESTURES)
                                      ? ModelToCommandMap[predicted_idx]
                                      : CommandName::UNKNOWN;

    if (Serial && g_logger) {
        const char *predicted_gesture = (predicted_command != CommandName::UNKNOWN)
                                        ? CommandNames[static_cast<uint8_t>(predicted_command)]
                                        : "UNKNOWN";
        g_logger->info("  Classified as: {} (confidence: {:.1f}%)", predicted_gesture, max_confidence * 100.0f);
        g_logger->info("     All probabilities:");
        for (int i = 0; i < NUM_GESTURES; i++) {
            float prob     = output->data.f[i];
            int bar_length = static_cast<int>(prob * 30);
            char bar[32] = {0};
            for (int j = 0; j < bar_length && j < 30; j++) bar[j] = '#';
            CommandName cmd = ModelToCommandMap[i];
            g_logger->info("       {:>8s}: {:5.1f}% {}", CommandNames[static_cast<uint8_t>(cmd)], prob * 100.0f, bar);
        }
    }

    g_gestures_classified++;
    return predicted_command;
}

static void process_sample(const Sample &s) {
    unsigned long now_us = micros();
    float energy = calculate_energy(s);
    energy_push(energy);
    float smoothed_energy = energy_avg();

    if (g_state == GestureState::IDLE) { update_base_position(s); pre_buffer_push(s); }

    if (g_state == GestureState::IDLE) {
        if (!g_calibrating && now_us > g_cooldown_until_us) {
            if (smoothed_energy > START_ENERGY_THRESHOLD) {
                g_state       = GestureState::RECORDING;
                g_buffer_size = 0;
                copy_pre_buffer_to_recording();
                g_recording_buffer[g_buffer_size++] = s;
                g_record_start_us                   = now_us;
                g_gestures_detected++;

                if (Serial && g_logger) {
                    g_logger->info("");
                    g_logger->info("[{}] Gesture detected! Recording... (Energy: {:.3f})", g_gestures_detected, smoothed_energy);
                }
            }
        }
    } else if (g_state == GestureState::RECORDING) {
        if (g_buffer_size < WINDOW_SAMPLES) { g_recording_buffer[g_buffer_size++] = s; }
        float record_duration_s = (now_us - g_record_start_us) / 1000000.0f;
        bool should_end        = false;
        const char *end_reason = "";
        bool at_base = is_at_base_position(s);

        if (smoothed_energy < END_ENERGY_THRESHOLD) {
            if (at_base && g_buffer_size >= MIN_SAMPLES) { should_end = true; end_reason = "returned to base"; }
            else if (g_buffer_size >= MIN_SAMPLES * 2) { should_end = true; end_reason = "low energy"; }
        }
        if (record_duration_s > MAX_RECORD_TIME_S) { should_end = true; end_reason = "max time"; }

        if (should_end) {
            if (Serial && g_logger) g_logger->info("  Recording ended ({}): {} samples, {:.2f}s", end_reason, g_buffer_size, record_duration_s);

            if (g_buffer_size >= MIN_SAMPLES) {
                CommandName detected_command = classify_gesture();
                if (detected_command != CommandName::UNKNOWN && ble.isConnected()) {
                    const char* cmd_name = CommandNames[static_cast<uint8_t>(detected_command)];
                    ble.sendCommand(cmd_name);
                    if (Serial && g_logger) g_logger->info("  BLE Sent: {}", cmd_name);
                }
            } else {
                if (Serial && g_logger) g_logger->info("  Too short, skipped classification");
            }

            g_state             = GestureState::IDLE;
            g_cooldown_until_us = now_us + static_cast<unsigned long>(COOLDOWN_DURATION_S * 1000000.0f);
            g_buffer_size = 0;
            if (Serial && g_logger) g_logger->info("------------------------------------------------------------");
        }
    } else if (g_state == GestureState::COOLDOWN) {
        if (now_us > g_cooldown_until_us) { g_state = GestureState::IDLE; }
    }
}

/* --- Setup --- */

void setup() {
    pinMode(LED_BUILTIN, OUTPUT);
    digitalWrite(LED_BUILTIN, LOW); 

    // 1. Wait for Serial or timeout (with heartbeat)
    Serial.begin(115200);
    unsigned long start_time = millis();
    while (!Serial && (millis() - start_time < 3000)) {
        digitalWrite(LED_BUILTIN, !digitalRead(LED_BUILTIN));
        delay(50);
    }
    digitalWrite(LED_BUILTIN, LOW);
    delay(500);

    g_logger = new logger::arduino::Logger();
    if (Serial) {
        g_logger->info("=============================================================");
        g_logger->info("SYSTEM STARTING...");
    }

    // 2. IMU
    if (!IMU.begin()) {
        while (true) {
            digitalWrite(LED_BUILTIN, !digitalRead(LED_BUILTIN));
            delay(100); // Rapid blink = IMU Error
        }
    }
    if (Serial) g_logger->info("IMU OK");

    // 3. BLE - This is often where it hangs if it fails
    if (!ble.initServer("NanoCmd")) {
        while (true) {
            digitalWrite(LED_BUILTIN, !digitalRead(LED_BUILTIN));
            delay(1000); // Very slow blink = BLE Error
        }
    }
    if (Serial) g_logger->info("BLE OK: NanoCmd");

    // 4. TFLite
    model = tflite::GetModel(gesture_model);
    static tflite::MicroMutableOpResolver<12> micro_op_resolver;
    micro_op_resolver.AddConv2D();
    micro_op_resolver.AddMaxPool2D();
    micro_op_resolver.AddRelu();
    micro_op_resolver.AddFullyConnected();
    micro_op_resolver.AddSoftmax();
    micro_op_resolver.AddReshape();
    micro_op_resolver.AddExpandDims();
    micro_op_resolver.AddMean();
    micro_op_resolver.AddQuantize();
    micro_op_resolver.AddDequantize();

    static tflite::MicroInterpreter static_interpreter(
        model, micro_op_resolver, tensor_arena, kTensorArenaSize
    );
    interpreter = &static_interpreter;
    if (interpreter->AllocateTensors() != kTfLiteOk) {
        while (true) { digitalWrite(LED_BUILTIN, HIGH); delay(50); digitalWrite(LED_BUILTIN, LOW); delay(450); }
    }
    input  = interpreter->input(0);
    output = interpreter->output(0);
    if (Serial) g_logger->info("TFLite OK");

    // Success Signal: Solid for 2 seconds then off
    digitalWrite(LED_BUILTIN, HIGH);
    delay(2000);
    digitalWrite(LED_BUILTIN, LOW);

    g_last_sample_us = micros();
}

void loop() {
    // HEARTBEAT: Short blink every 1 second to show we are alive
    static unsigned long last_heartbeat = 0;
    if (millis() - last_heartbeat > 1000) {
        digitalWrite(LED_BUILTIN, HIGH);
        delay(10); // Very short flash
        digitalWrite(LED_BUILTIN, LOW);
        last_heartbeat = millis();
    }

    unsigned long now_us = micros();
    ble.updateServer();

    // Sample at fixed rate
    const unsigned long sample_interval_us = 1000000UL / SAMPLE_RATE_HZ;
    if (now_us - g_last_sample_us < sample_interval_us) { return; }
    g_last_sample_us = now_us;

    float ax, ay, az;
    if (IMU.readAcceleration(ax, ay, az) != 1) { return; }

    Sample s = {ax, ay, az};
    process_sample(s);
}
