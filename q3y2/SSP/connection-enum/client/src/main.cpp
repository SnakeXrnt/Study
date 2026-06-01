#include <Arduino.h>
#include <TFT_eSPI.h>
#include <BleConnection.h>
#include <vector>
#include <algorithm>

TFT_eSPI tft = TFT_eSPI();
BleConnection ble;

// --- UI Constants ---
#define W 240
#define H 135
#define C_BG        0x0000
#define C_PANEL     0x10A2
#define C_ACCENT    0x07FF
#define C_WHITE     0xFFFF
#define C_DIM       0x4208
#define C_GREEN     0x07E0
#define C_RED       0xF800

// --- State ---
struct ScannedDevice {
    String name;
    String address;
    int rssi;
    unsigned long lastSeen;
};

std::vector<ScannedDevice> foundDevices;
std::vector<ScannedDevice> discoveryBuffer;
portMUX_TYPE deviceMux = portMUX_INITIALIZER_UNLOCKED;

Gesture currentGesture = GESTURE_NONE;
uint8_t lastSeq = 0;
uint32_t lastTs = 0;
unsigned long lastPacketMs = 0;

// --- Callbacks ---

void onDiscovery(const char* name, const char* address, int rssi) {
    portENTER_CRITICAL(&deviceMux);
    discoveryBuffer.push_back({String(name), String(address), rssi, millis()});
    portEXIT_CRITICAL(&deviceMux);
}

void onData(uint8_t seq, uint32_t ts, Gesture g) {
    currentGesture = g;
    lastSeq = seq;
    lastTs = ts;
    lastPacketMs = millis();
}

// --- UI Helpers ---

void drawBase() {
    tft.fillRect(0, 0, W, 22, C_PANEL);
    tft.drawFastHLine(0, 22, W, C_ACCENT);
    tft.setTextColor(C_ACCENT, C_PANEL);
    tft.setTextSize(1);
    tft.setCursor(8, 6);
    tft.print("BLE COMMAND HUB");
}

uint16_t getRssiColor(int rssi) {
    if (rssi > -60) return C_GREEN;
    return C_WHITE;
}

void drawScanningUI() {
    drawBase();
    tft.setTextColor(C_DIM, C_BG);
    tft.setCursor(8, 28);
    tft.print("SEARCHING: NanoCmd");

    int count = std::min((int)foundDevices.size(), 5);
    bool foundTarget = false;

    for (int i = 0; i < 5; i++) {
        int y = 40 + (i * 18);
        tft.fillRect(4, y, W - 8, 16, C_PANEL);
        
        if (i < count) {
            auto& d = foundDevices[i];
            bool isTarget = (d.name == "NanoCmd");
            if (isTarget) foundTarget = true;

            tft.setTextColor(isTarget ? C_ACCENT : C_WHITE, C_PANEL);
            tft.setCursor(10, y + 4);
            tft.print(isTarget ? "> " : "  ");
            
            String label = d.name.length() > 0 ? d.name : d.address;
            if (isTarget) label = "TARGET: " + d.name;
            if (label.length() > 22) label = label.substring(0, 19) + "...";
            tft.print(label);

            tft.setTextColor(getRssiColor(d.rssi), C_PANEL);
            tft.setCursor(W - 45, y + 4);
            tft.printf("%d", d.rssi);
        } else {
            tft.setTextColor(C_DIM, C_PANEL);
            tft.setCursor(10, y + 4);
            tft.print("  -");
        }
    }

    tft.fillRect(0, H - 20, W, 20, C_BG);
    if (foundTarget) {
        tft.setTextColor(C_GREEN, C_BG);
        tft.setCursor(8, H - 15);
        tft.print("NanoCmd Found! Connecting...");
    } else {
        tft.setTextColor(C_ACCENT, C_BG);
        tft.setCursor(8, H - 15);
        tft.print("Scanning...");
    }
}

void drawConnectedUI() {
    drawBase();
    tft.setTextColor(C_GREEN, C_PANEL);
    tft.setCursor(W - 65, 6);
    tft.print("CONNECTED");
    
    tft.setTextColor(C_DIM, C_BG);
    tft.setCursor(10, 35);
    tft.print("ACTIVE COMMAND:");
    
    tft.fillRoundRect(20, 50, W-40, 55, 5, C_PANEL);
    tft.setTextColor(C_WHITE, C_PANEL);
    tft.setTextSize(4);
    const char* name = BleConnection::getGestureName(currentGesture);
    int textW = strlen(name) * 24;
    tft.setCursor((W - textW) / 2, 62);
    tft.print(name);
    
    tft.setTextSize(1);
    tft.fillRect(0, H - 18, W, 18, C_PANEL);
    tft.setTextColor(C_DIM, C_PANEL);
    tft.setCursor(8, H - 13);
    tft.printf("SEQ: %u   LAST PKT: %lu ms ago", lastSeq, millis() - lastPacketMs);
}

void setup() {
    Serial.begin(115200);
    delay(1000);
    Serial.println(">>> SYSTEM START");
    
    tft.init();
    tft.setRotation(1);
    tft.fillScreen(C_BG);
    
    tft.setTextColor(C_WHITE);
    tft.setCursor(10, 40);
    tft.println("SYSTEM BOOTING...");
    tft.println("Initializing BLE Stack...");
    
    if (!ble.initClient(onData, onDiscovery)) {
        Serial.println(">>> BLE INIT FAILED");
        tft.setTextColor(C_RED);
        tft.println("BLE FAILED!");
        while(1);
    }
    
    Serial.println(">>> BLE INIT SUCCESS. Starting Loop.");
    tft.println("READY.");
    delay(500);
}

void loop() {
    // 1. Process Discovery Buffer (Thread Safe)
    if (!discoveryBuffer.empty()) {
        portENTER_CRITICAL(&deviceMux);
        std::vector<ScannedDevice> temp = discoveryBuffer;
        discoveryBuffer.clear();
        portEXIT_CRITICAL(&deviceMux);

        for (auto &newDev : temp) {
            bool found = false;
            for (auto &d : foundDevices) {
                if (d.address == newDev.address) {
                    d.rssi = newDev.rssi;
                    d.name = newDev.name;
                    d.lastSeen = millis();
                    found = true;
                    break;
                }
            }
            if (!found) foundDevices.push_back(newDev);
        }
    }

    // 2. Cleanup old devices
    unsigned long now = millis();
    foundDevices.erase(std::remove_if(foundDevices.begin(), foundDevices.end(),
        [now](const ScannedDevice& d) { return now - d.lastSeen > 5000; }), foundDevices.end());

    // 3. Draw UI
    bool connected = ble.isConnected();
    if (connected) {
        drawConnectedUI();
    } else {
        drawScanningUI();
    }

    // 4. Update BLE (The potentially blocking part)
    ble.updateClient();

    // 5. Diagnostics
    static unsigned long lastLog = 0;
    if (millis() - lastLog > 2000) {
        Serial.printf(">>> [HEARTBEAT] Connected: %d, Devices: %d\n", connected, foundDevices.size());
        lastLog = millis();
    }

    if (connected && (millis() - lastPacketMs > 5000)) {
        Serial.println(">>> [SYSTEM] Timeout - disconnecting.");
        ble.disconnect();
    }

    delay(30);
}
