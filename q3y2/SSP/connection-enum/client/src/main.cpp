#include <Arduino.h>
#include <TFT_eSPI.h>
#include <BleConnection.h>
#include <vector>
#include <algorithm>

TFT_eSPI tft = TFT_eSPI();
TFT_eSprite spr = TFT_eSprite(&tft);
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
    if (!name || strlen(name) == 0 || String(name) == "<NULL>") return;
    
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

void drawBase(const char* status = "BLE HUB", uint16_t statusColor = C_ACCENT) {
    spr.fillRect(0, 0, W, 22, C_PANEL);
    spr.drawFastHLine(0, 22, W, C_ACCENT);
    spr.setTextColor(statusColor, C_PANEL);
    spr.setTextSize(1);
    spr.setCursor(8, 6);
    spr.print(status);
}

void drawScanningUI() {
    spr.fillSprite(C_BG);
    drawBase("SEARCHING...");
    
    spr.setTextColor(C_DIM, C_BG);
    spr.setCursor(10, 30);
    spr.print("AVAILABLE DEVICES:");

    int count = std::min((int)foundDevices.size(), 5);
    for (int i = 0; i < 5; i++) {
        int y = 45 + (i * 16);
        spr.fillRect(4, y, W - 8, 14, C_PANEL);
        if (i < count) {
            auto& d = foundDevices[i];
            spr.setTextColor(C_WHITE, C_PANEL);
            spr.setCursor(10, y + 3);
            String label = d.name;
            if (label.length() > 20) label = label.substring(0, 17) + "...";
            spr.print(label);
            spr.setCursor(W - 40, y + 3);
            spr.print(d.rssi);
        }
    }
    
    spr.setTextColor(C_ACCENT, C_BG);
    spr.setCursor(8, H - 15);
    spr.print("Scanning for NanoCmd...");
    spr.pushSprite(0, 0);
}

void drawConnectingUI() {
    spr.fillSprite(C_BG);
    drawBase("CONNECTING", C_WHITE);
    
    spr.fillRoundRect(20, 40, W-40, 60, 5, C_PANEL);
    spr.setTextColor(C_ACCENT, C_PANEL);
    spr.setTextSize(2);
    spr.setCursor(50, 55);
    spr.print("TARGET FOUND");
    
    spr.setTextSize(1);
    spr.setTextColor(C_WHITE, C_PANEL);
    spr.setCursor(45, 80);
    spr.print("Initializing Services...");
    
    spr.pushSprite(0, 0);
}

void drawConnectedUI() {
    spr.fillSprite(C_BG);
    drawBase("CONNECTED", C_GREEN);
    
    spr.setTextColor(C_DIM, C_BG);
    spr.setCursor(10, 35);
    spr.print("ACTIVE COMMAND:");
    
    spr.fillRoundRect(20, 50, W-40, 55, 5, C_PANEL);
    spr.setTextColor(C_WHITE, C_PANEL);
    spr.setTextSize(4);
    const char* name = BleConnection::getGestureName(currentGesture);
    int textW = strlen(name) * 24;
    spr.setCursor((W - textW) / 2, 62);
    spr.print(name);
    
    spr.setTextSize(1);
    spr.fillRect(0, H - 18, W, 18, C_PANEL);
    spr.setTextColor(C_DIM, C_PANEL);
    spr.setCursor(8, H - 13);
    unsigned long ago = millis() - lastPacketMs;
    spr.printf("SEQ: %u   LAST PKT: %lu ms", lastSeq, ago);
    spr.pushSprite(0, 0);
}

void setup() {
    Serial.begin(115200);
    delay(1000);
    Serial.println(">>> SYSTEM START");
    
    tft.init();
    tft.setRotation(1);
    tft.fillScreen(C_BG);
    spr.createSprite(W, H);
    
    tft.setTextColor(C_WHITE);
    tft.setCursor(10, 40);
    tft.println("SYSTEM BOOTING...");
    
    if (!ble.initClient(onData, onDiscovery)) {
        Serial.println(">>> BLE INIT FAILED");
        while(1);
    }
    
    Serial.println(">>> BLE INIT SUCCESS.");
    delay(500);
}

void loop() {
    // 1. Process Discovery Buffer
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

    // 2. Cleanup
    unsigned long now = millis();
    foundDevices.erase(std::remove_if(foundDevices.begin(), foundDevices.end(),
        [now](const ScannedDevice& d) { return now - d.lastSeen > 5000; }), foundDevices.end());

    // 3. Logic-driven UI State
    static bool wasConnected = false;
    bool connected = ble.isConnected();
    
    if (connected && !wasConnected) {
        // Just connected! Reset the packet timer so we don't timeout immediately
        lastPacketMs = millis();
        Serial.println(">>> [SYSTEM] Connection established - Timer reset.");
    }
    wasConnected = connected;

    if (connected) {
        drawConnectedUI();
    } else if (ble.isConnecting()) {
        drawConnectingUI();
    } else {
        // Special case: if NanoCmd is in our list but not connecting yet, 
        // we might still be in the 'delay' or about to trigger _doConnect.
        bool foundNano = false;
        for(auto &d : foundDevices) if(d.name == "NanoCmd") foundNano = true;
        
        if (foundNano) {
            drawConnectingUI();
        } else {
            drawScanningUI();
        }
    }

    // 4. Update BLE
    ble.updateClient();

    // 5. Cleanup / Timeout
    if (connected) {
        unsigned long timeSinceLastPacket = millis() - lastPacketMs;
        if (timeSinceLastPacket > 10000) {
            Serial.printf(">>> [SYSTEM] Timeout (%lu ms) - disconnecting.\n", timeSinceLastPacket);
            ble.disconnect();
            lastPacketMs = 0; // Reset for next connection
        }
    }

    delay(30);
}
