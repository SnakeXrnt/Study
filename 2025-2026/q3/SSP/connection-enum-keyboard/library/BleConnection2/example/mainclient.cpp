#include <Arduino.h>
#include <BleConnection.h>

BleConnection ble;

// This callback is triggered every time the server sends new data
void onDataReceived(uint8_t seq, uint32_t ts, ImuSample* samples) {
    Serial.print("Data Recv! Seq: ");
    Serial.print(seq);
    Serial.print(" | IMU0_AX: ");
    Serial.println(samples[0].ax);
}

void setup() {
    Serial.begin(115200);
    Serial.println("--- BLE Client Example ---");

    // Initialize as client and provide the callback function
    if (ble.initClient(onDataReceived)) {
        Serial.println("Client initialized. Scanning for server...");
    } else {
        Serial.println("Client initialization failed!");
    }
}

void loop() {
    // Mandatory update call (handles scanning and background BLE tasks)
    ble.updateClient();

    static unsigned long lastStatus = 0;
    if (millis() - lastStatus > 2000) {
        lastStatus = millis();
        if (ble.isConnected()) {
            Serial.println("[Status] Connected");
        } else if (ble.isScanning()) {
            Serial.println("[Status] Scanning...");
        }
    }
}
