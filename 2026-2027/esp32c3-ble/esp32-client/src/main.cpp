#include <Arduino.h>

#include "ble_sensor_server.h"

// The SuperMini's on-board LED sits on GPIO8 and is wired active-low.
#define LED_PIN 8
#define LED_ON  LOW
#define LED_OFF HIGH

// How often a sample is produced. 50 Hz fits comfortably inside a 15-30 ms
// connection interval; push much past 100 Hz and notify() starts refusing.
static constexpr uint32_t SAMPLE_RATE_HZ   = 50;
static constexpr uint32_t SAMPLE_PERIOD_US = 1000000UL / SAMPLE_RATE_HZ;

BleSensorServer g_ble;

static uint32_t idx        = 0;
static uint32_t nextSample = 0;
static uint32_t nextReport = 0;

void setup() {
    Serial.begin(115200);
    pinMode(LED_PIN, OUTPUT);
    digitalWrite(LED_PIN, LED_OFF);

    // Native USB enumerates after boot; give the host a moment so the banner
    // is not lost. Do not block forever, the board must run headless too.
    const uint32_t deadline = millis() + 2000;
    while (!Serial && millis() < deadline) {
        delay(10);
    }

    Serial.println();
    Serial.println("[boot] esp32-c3 supermini ble sensor client");
    g_ble.begin();

    nextSample = micros();
    nextReport = millis();
}

void loop() {
    const uint32_t now = micros();

    // Signed wraparound-safe comparison: micros() rolls over every ~71 minutes.
    if ((int32_t)(now - nextSample) >= 0) {
        nextSample += SAMPLE_PERIOD_US;

        float t  = (float)now / 1000000.0f;
        float gx = 0.1f * idx, gy = 0.2f * idx, gz = 0.3f * idx;
        float ax = 0.0f, ay = 0.0f, az = 1.0f;
        float qw = 1.0f, qx = 0.0f, qy = 0.0f, qz = 0.0f;
        (void)t;  // seconds-since-boot, handy when you swap in a real sensor

        g_ble.sendSensorData(
            static_cast<uint32_t>(now), idx, gx, gy, gz, ax, ay, az, qw, qx, qy, qz
        );

        idx++;
    }

    g_ble.tick();

    // Heartbeat: solid while streaming, slow blink while waiting for a client.
    if (g_ble.isStreaming()) {
        digitalWrite(LED_PIN, LED_ON);
    } else {
        digitalWrite(LED_PIN, (millis() / 500) % 2 ? LED_ON : LED_OFF);
    }

    if ((int32_t)(millis() - nextReport) >= 0) {
        nextReport += 1000;
        Serial.printf("[stat] idx=%lu sent=%lu dropped=%lu mtu=%u %s\n",
                      (unsigned long)idx, (unsigned long)g_ble.sent(),
                      (unsigned long)g_ble.dropped(), g_ble.mtu(),
                      g_ble.isStreaming() ? "streaming" : "waiting");
    }

    delay(1);
}
