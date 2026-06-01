#include <Arduino.h>
#include <BleConnection.h>

BleConnection ble;

unsigned long lastGestureMs = 0;
const int GESTURE_INTERVAL_MS = 2000;
uint8_t currentGestureIdx = 0;

// Example list of names to cycle through
const char* commandNames[] = {"SCRUNCH", "UP", "DOWN", "LEFT", "RIGHT"};

void setup() {
    Serial.begin(115200);
    unsigned long start = millis();
    while (!Serial && millis() - start < 3000);

    Serial.println("Nano 33 BLE Command Server starting...");

    if (!ble.initServer("NanoCmd")) {
        Serial.println("Failed to initialize BLE!");
        while (1);
    }

    Serial.println("BLE initialized. Advertising as 'NanoCmd'");
}

void loop() {
    unsigned long now = millis();
    ble.updateServer();

    if (ble.isConnected()) {
        if (now - lastGestureMs >= GESTURE_INTERVAL_MS) {
            lastGestureMs = now;
            
            const char* cmd = commandNames[currentGestureIdx];
            ble.sendCommand(cmd);
            
            Serial.print("Sent Command: ");
            Serial.println(cmd);

            currentGestureIdx = (currentGestureIdx + 1) % 5;
        }
    } else {
        lastGestureMs = now;
    }
}
