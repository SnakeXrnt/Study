#include <Arduino.h>
#include <BleConnection.h>

BleConnection ble;
ImuSample dummyData[BLE_NUM_IMUS];

void setup() {
    Serial.begin(115200);
    while (!Serial && millis() < 3000); // Wait for serial on Nano

    Serial.println("--- BLE Server Example ---");
    
    // Initialize as server with a broadcast name
    if (ble.initServer("Nano_Sample_Server")) {
        Serial.println("Server initialized and advertising...");
    } else {
        Serial.println("Server initialization failed!");
    }
}

void loop() {
    // 1. Mandatory update call (handles advertising/restarts)
    ble.updateServer();

    // 2. Only send data if a client is actually connected
    if (ble.isConnected()) {
        static unsigned long lastSend = 0;
        if (millis() - lastSend > 100) { // Send at 10Hz
            lastSend = millis();

            // Prepare some dummy data
            for (int i = 0; i < BLE_NUM_IMUS; i++) {
                dummyData[i].ax = random(-100, 100);
                dummyData[i].ay = random(-100, 100);
                dummyData[i].az = random(-100, 100);
            }

            // Send the batch
            ble.sendData(dummyData, BLE_NUM_IMUS);
            Serial.println("Sent 10Hz batch");
        }
    }
}
