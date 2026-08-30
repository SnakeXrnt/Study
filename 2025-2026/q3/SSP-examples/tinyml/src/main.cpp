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
    UNKNOWN = 255
};

const char *CommandNames[] = {"COBRA", "UP", "DOWN", "LEFT", "RIGHT"};

// Mapping from model output indices (alphabetical order) to CommandName enum
// Model outputs: ["down", "left", "right", "still", "up"] (indices 0-4)
const CommandName ModelToCommandMap[] = {
    CommandName::DOWN,   // Model index 0 (down)
    CommandName::LEFT,   // Model index 1 (left)
    CommandName::RIGHT,  // Model index 2 (right)
    CommandName::STILL,  // Model index 3 (still)
    CommandName::UP      // Model index 4 (up)
};

/* --- Sample Structure (Accelerometer Only) --- */
struct Sample {
    float ax;
    float ay;
    float az;
};

/* --- Global State --- */
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
    // Copy samples from pre-buffer to recording buffer in chronological order
    // Start from the oldest sample (which is at g_pre_buffer_head in a full buffer)
    int start_idx = (g_pre_buffer_size < PRE_BUFFER_SAMPLES) ? 0 : g_pre_buffer_head;

    for (int i = 0; i < g_pre_buffer_size; i++) {
        int idx                             = (start_idx + i) % PRE_BUFFER_SAMPLES;
        g_recording_buffer[g_buffer_size++] = g_pre_buffer[idx];
    }

    g_logger->info(
        "  Added {} pre-buffer samples ({} ms before detection)", g_pre_buffer_size, PRE_BUFFER_MS
    );
}

static CommandName classify_gesture() {
    if (input == nullptr || output == nullptr || interpreter == nullptr) {
        g_logger->error("TFLite not initialized");
        return CommandName::UNKNOWN;
    }

    const int num_samples = g_buffer_size;

    float min_x = g_recording_buffer[0].ax, max_x = g_recording_buffer[0].ax, sum_x = 0.0f;
    float min_y = g_recording_buffer[0].ay, max_y = g_recording_buffer[0].ay, sum_y = 0.0f;
    float min_z = g_recording_buffer[0].az, max_z = g_recording_buffer[0].az, sum_z = 0.0f;

    for (int i = 0; i < num_samples; i++) {
        const Sample &s = g_recording_buffer[i];

        min_x  = fminf(min_x, s.ax);
        max_x  = fmaxf(max_x, s.ax);
        sum_x += s.ax;
        min_y  = fminf(min_y, s.ay);
        max_y  = fmaxf(max_y, s.ay);
        sum_y += s.ay;
        min_z  = fminf(min_z, s.az);
        max_z  = fmaxf(max_z, s.az);
        sum_z += s.az;
    }

    float mean_x = sum_x / num_samples;
    float mean_y = sum_y / num_samples;
    float mean_z = sum_z / num_samples;

    g_logger->info("  Sample statistics (in g):");
    g_logger->info("    Samples: {}", num_samples);
    g_logger->info("    AccX: [{:.2f}, {:.2f}]  mean: {:.2f}", min_x, max_x, mean_x);
    g_logger->info("    AccY: [{:.2f}, {:.2f}]  mean: {:.2f}", min_y, max_y, mean_y);
    g_logger->info("    AccZ: [{:.2f}, {:.2f}]  mean: {:.2f}", min_z, max_z, mean_z);

    // NOTE:  Convert from g to m/s² (multiply by 9.8)
    const float G_TO_MS2 = 9.8f;

    // Fill input tensor: pad or truncate to WINDOW_SAMPLES
    for (int i = 0; i < WINDOW_SAMPLES; i++) {
        if (i < num_samples) {
            input->data.f[i * 3 + 0] = g_recording_buffer[i].ax * G_TO_MS2;
            input->data.f[i * 3 + 1] = g_recording_buffer[i].ay * G_TO_MS2;
            input->data.f[i * 3 + 2] = g_recording_buffer[i].az * G_TO_MS2;
        } else {
            // Pad with zeros
            input->data.f[i * 3 + 0] = 0.0f;
            input->data.f[i * 3 + 1] = 0.0f;
            input->data.f[i * 3 + 2] = 0.0f;
        }
    }

    TfLiteStatus invoke_status = interpreter->Invoke();
    if (invoke_status != kTfLiteOk) {
        g_logger->error("Inference failed!");
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

    // Map from model output index to CommandName enum
    CommandName predicted_command = (predicted_idx >= 0 && predicted_idx < NUM_GESTURES)
                                      ? ModelToCommandMap[predicted_idx]
                                      : CommandName::UNKNOWN;

    const char *predicted_gesture = (predicted_command != CommandName::UNKNOWN)
                                      ? CommandNames[static_cast<uint8_t>(predicted_command)]
                                      : "UNKNOWN";

    g_logger->info(
        "  Classified as: {} (confidence: {:.1f}%)", predicted_gesture, max_confidence * 100.0f
    );
    g_logger->info("     All probabilities:");

    for (int i = 0; i < NUM_GESTURES; i++) {
        float prob     = output->data.f[i];
        int bar_length = static_cast<int>(prob * 30);

        char bar[32] = {0};
        for (int j = 0; j < bar_length && j < 30; j++) {
            bar[j] = '#';
        }

        // Map model index to CommandName for display
        CommandName cmd = ModelToCommandMap[i];
        g_logger->info("       {:>8s}: {:5.1f}% {}", CommandNames[static_cast<uint8_t>(cmd)], prob * 100.0f, bar);
    }

    g_gestures_classified++;

    return predicted_command;
}

static void process_sample(const Sample &s) {
    unsigned long now_us = micros();

    float energy = calculate_energy(s);
    energy_push(energy);
    float smoothed_energy = energy_avg();

    // NOTE: Update base position during idle
    if (g_state == GestureState::IDLE) { update_base_position(s); }

    // Continuously store samples in pre-buffer during IDLE state
    if (g_state == GestureState::IDLE) { pre_buffer_push(s); }

    if (g_state == GestureState::IDLE) {
        if (!g_calibrating && now_us > g_cooldown_until_us) {
            if (smoothed_energy > START_ENERGY_THRESHOLD) {
                // Start recording
                g_state       = GestureState::RECORDING;
                g_buffer_size = 0;

                // Copy pre-buffer data to capture what happened before detection
                copy_pre_buffer_to_recording();

                // Add current sample
                g_recording_buffer[g_buffer_size++] = s;
                g_record_start_us                   = now_us;
                g_gestures_detected++;

                g_logger->info("");
                g_logger->info(
                    "[{}] Gesture detected! Recording... (Energy: {:.3f})",
                    g_gestures_detected,
                    smoothed_energy
                );
            }
        }
    } else if (g_state == GestureState::RECORDING) {
        // Add sample to buffer
        if (g_buffer_size < WINDOW_SAMPLES) { g_recording_buffer[g_buffer_size++] = s; }

        float record_duration_s = (now_us - g_record_start_us) / 1000000.0f;

        bool should_end        = false;
        const char *end_reason = "";

        bool at_base = is_at_base_position(s);

        // Check end conditions
        if (smoothed_energy < END_ENERGY_THRESHOLD) {
            if (at_base && g_buffer_size >= MIN_SAMPLES) {
                should_end = true;
                end_reason = "returned to base";
            } else if (g_buffer_size >= MIN_SAMPLES * 2) {
                should_end = true;
                end_reason = "low energy";
            }
        }

        if (record_duration_s > MAX_RECORD_TIME_S) {
            should_end = true;
            end_reason = "max time";
        }

        if (should_end) {
            g_logger->info(
                "  Recording ended ({}): {} samples, {:.2f}s",
                end_reason,
                g_buffer_size,
                record_duration_s
            );

            if (g_buffer_size >= MIN_SAMPLES) {
                CommandName detected_command = classify_gesture();
                // You can now use detected_command for further processing
                // For example: execute actions based on the detected command
            } else {
                g_logger->info("  Too short, skipped classification");
            }

            g_state             = GestureState::IDLE;
            g_cooldown_until_us = now_us
                                + static_cast<unsigned long>(COOLDOWN_DURATION_S * 1000000.0f);
            g_buffer_size = 0;
            g_logger->info("------------------------------------------------------------");
        }
    } else if (g_state == GestureState::COOLDOWN) {
        // Handled by cooldown_until_us check in IDLE state
        if (now_us > g_cooldown_until_us) { g_state = GestureState::IDLE; }
    }
}

/* --- Setup --- */

void setup() {
    Serial.begin(115200);
    while (!Serial) {
        delay(10);
    }
    delay(1000);

    g_logger = new logger::arduino::Logger();
    g_logger->info("=============================================================");
    g_logger->info("REAL-TIME GESTURE CLASSIFICATION (Accelerometer Only)");
    g_logger->info("=============================================================");
    g_logger->info("");
    g_logger->info("Initializing IMU sensor...");

    if (!IMU.begin()) {
        g_logger->error("Failed to initialize IMU!");
        while (true) {
            delay(1000);
        }
    }

    g_logger->info("IMU sensor initialized");
    delay(200);

    // NOTE: Test sensor readings (accelerometer only)
    float ax, ay, az;
    int test_count = 0;
    for (int i = 0; i < 10; i++) {
        if (IMU.readAcceleration(ax, ay, az) == 1) { test_count++; }
        delay(10);
    }

    g_logger->info("Sensor test: {}/10 successful reads", test_count);

    if (test_count == 0) {
        g_logger->error("Sensor not responding!");
        while (true) {
            delay(1000);
        }
    }

    g_logger->info("Test read - Acc:[{:.3f},{:.3f},{:.3f}] g", ax, ay, az);

    g_logger->info("Initializing TensorFlow Lite...");

    model = tflite::GetModel(gesture_model);
    if (model->version() != TFLITE_SCHEMA_VERSION) {
        g_logger->error("Model schema version mismatch!");
        while (true) {
            delay(1000);
        }
    }

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

    TfLiteStatus allocate_status = interpreter->AllocateTensors();
    if (allocate_status != kTfLiteOk) {
        g_logger->error("AllocateTensors() failed");
        while (true) {
            delay(1000);
        }
    }

    input  = interpreter->input(0);
    output = interpreter->output(0);

    g_logger->info("TensorFlow Lite initialized successfully!");
    g_logger->info(
        "  Input shape: [{}, {}, {}]",
        input->dims->data[0],
        input->dims->data[1],
        input->dims->data[2]
    );
    g_logger->info("  Output shape: [{}]", output->dims->data[1]);
    g_logger->info("  Features: {} (accelerometer only)", N_FEATURES);
    g_logger->info("  Classes: {}", NUM_GESTURES);

    g_logger->info("");
    g_logger->info("Calibrating base position...");
    g_logger->info("Keep device still for 1 second...");
    g_logger->info("");

    g_last_sample_us = micros();
}

void loop() {
    unsigned long now_us = micros();

    // Sample at fixed rate
    const unsigned long sample_interval_us = 1000000UL / SAMPLE_RATE_HZ;
    if (now_us - g_last_sample_us < sample_interval_us) { return; }
    g_last_sample_us = now_us;

    float ax, ay, az;
    int accel_result = IMU.readAcceleration(ax, ay, az);

    if (accel_result != 1) { return; }

    // Process sample (accelerometer only, in g units)
    Sample s = {ax, ay, az};
    process_sample(s);
}
