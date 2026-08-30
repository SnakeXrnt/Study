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
#define C_CURSOR    0xF81F

// --- Keyboard Config ---
const char* keys[] = {
    "A", "B", "C", "D", "E", "F", "G",
    "H", "I", "J", "K", "L", "M", "N",
    "O", "P", "Q", "R", "S", "T", "U",
    "V", "W", "X", "Y", "Z", "_", "<-"
};
const int ROWS = 4;
const int COLS = 7;
const int KEY_W = 30;
const int KEY_H = 22;
const int KB_OFFSET_X = 15;
const int KB_OFFSET_Y = 45;

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

String typedText = "";
int cursorX = 0;
int cursorY = 0;
uint8_t lastSeq = 0;
unsigned long lastPacketMs = 0;

// --- Callbacks ---

void onDiscovery(const char* name, const char* address, int rssi) {
    if (!name || strlen(name) == 0 || String(name) == "<NULL>") return;
    
    portENTER_CRITICAL(&deviceMux);
    discoveryBuffer.push_back({String(name), String(address), rssi, millis()});
    portEXIT_CRITICAL(&deviceMux);
}

void onData(uint8_t seq, uint32_t ts, Gesture g) {
    if (seq == lastSeq && lastSeq != 0) return; // Basic duplicate filtering
    lastSeq = seq;
    lastPacketMs = millis();

    if (g == GESTURE_UP) {
        cursorY = (cursorY - 1 + ROWS) % ROWS;
    } else if (g == GESTURE_DOWN) {
        cursorY = (cursorY + 1) % ROWS;
    } else if (g == GESTURE_LEFT) {
        cursorX = (cursorX - 1 + COLS) % COLS;
    } else if (g == GESTURE_RIGHT) {
        cursorX = (cursorX + 1) % COLS;
    } else if (g == GESTURE_COBRA) {
        int idx = cursorY * COLS + cursorX;
        const char* key = keys[idx];
        if (strcmp(key, "<-") == 0) {
            if (typedText.length() > 0) typedText.remove(typedText.length() - 1);
        } else if (strcmp(key, "_") == 0) {
            typedText += " ";
        } else {
            typedText += key;
        }
    }
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

void drawKeyboard() {
    // 1. Text Box
    spr.fillRect(10, 26, W - 20, 16, C_PANEL);
    spr.drawRect(10, 26, W - 20, 16, C_DIM);
    spr.setTextColor(C_WHITE, C_PANEL);
    spr.setTextSize(1);
    spr.setCursor(15, 30);
    String displayStr = typedText + "|";
    if (displayStr.length() > 35) displayStr = displayStr.substring(displayStr.length() - 35);
    spr.print(displayStr);

    // 2. Keys
    for (int r = 0; r < ROWS; r++) {
        for (int c = 0; c < COLS; c++) {
            int x = KB_OFFSET_X + c * KEY_W;
            int y = KB_OFFSET_Y + r * KEY_H;
            int idx = r * COLS + c;

            bool isSelected = (r == cursorY && c == cursorX);
            uint16_t bgColor = isSelected ? C_ACCENT : C_PANEL;
            uint16_t textColor = isSelected ? C_BG : C_WHITE;

            spr.fillRect(x + 1, y + 1, KEY_W - 2, KEY_H - 2, bgColor);
            spr.setTextColor(textColor, bgColor);
            
            const char* label = keys[idx];
            int labelW = strlen(label) * 6;
            spr.setCursor(x + (KEY_W - labelW) / 2, y + (KEY_H - 8) / 2);
            spr.print(label);
        }
    }
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
    drawBase("BLE KEYBOARD", C_GREEN);
    drawKeyboard();
    spr.pushSprite(0, 0);
}

void setup() {
    Serial.begin(115200);
    delay(1000);
    Serial.println(">>> KEYBOARD SYSTEM START");
    
    tft.init();
    tft.setRotation(1);
    tft.fillScreen(C_BG);
    spr.createSprite(W, H);
    
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
        lastPacketMs = millis();
        Serial.println(">>> [SYSTEM] Keyboard Connected.");
    }
    wasConnected = connected;

    if (connected) {
        drawConnectedUI();
    } else if (ble.isConnecting()) {
        drawConnectingUI();
    } else {
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
        if (timeSinceLastPacket > 15000) {
            Serial.printf(">>> [SYSTEM] Timeout (%lu ms) - disconnecting.\n", timeSinceLastPacket);
            ble.disconnect();
            lastPacketMs = 0;
        }
    }

    delay(30);
}
