#include <Arduino.h>
#include <TFT_eSPI.h>
#include <NimBLEDevice.h>

static NimBLEUUID serviceUUID("4fafc201-1fb5-459e-8fcc-c5c9c331914b");
static NimBLEUUID charUUID   ("beb5483e-36e1-4688-b7f5-ea07361b26a8");

TFT_eSPI tft = TFT_eSPI();

// --- State -------------------------------------------------------------------

NimBLEAddress targetAddress;
NimBLEClient* pClient         = nullptr;
bool          doConnect       = false;
bool          connected       = false;
bool          scanning        = false;
int           lastValue       = 0;
int           drawnValue      = -1;
int           packetsReceived = 0;
int           peakValue       = 0;
unsigned long lastPacketMs    = 0;
unsigned long connectedAtMs   = 0;
unsigned long startMs         = 0;
unsigned long lastScreenMs    = 0;

// --- Helpers -----------------------------------------------------------------

// T-Display is 240x135 landscape
#define W 240
#define H 135

// Color palette — dark industrial theme
#define C_BG        0x0841   // near-black blue-grey
#define C_PANEL     0x10A2   // slightly lighter panel
#define C_ACCENT    0x07FF   // cyan
#define C_GREEN     0x07E0   // green
#define C_YELLOW    0xFFE0   // yellow
#define C_ORANGE    0xFD20   // orange
#define C_RED       0xF800   // red
#define C_DIM       0x4208   // dark grey for labels
#define C_WHITE     0xFFFF
#define C_BORDER    0x2965   // subtle border grey

String formatTime(unsigned long ms) {
    unsigned long s = ms / 1000;
    char buf[10];
    snprintf(buf, sizeof(buf), "%02lu:%02lu:%02lu", s/3600, (s%3600)/60, s%60);
    return String(buf);
}

int ageSeconds() {
    if (lastPacketMs == 0) return 0;
    return (int)min((millis() - lastPacketMs) / 1000UL, (unsigned long)999);
}

int sessionSeconds() {
    if (connectedAtMs == 0) return 0;
    return (int)((millis() - connectedAtMs) / 1000UL);
}

// Pick color for age indicator — green=fresh, yellow=stale, red=dead
uint16_t ageColor() {
    int a = ageSeconds();
    if (a < 5)  return C_GREEN;
    if (a < 15) return C_YELLOW;
    return C_RED;
}

// Draw a labeled value box
// x,y = top-left, w,h = size, label on top, value inside
void drawBox(int x, int y, int w, int h,
             const char* label, const char* value,
             uint16_t valueColor, uint8_t valueSize) {
    // Panel background
    tft.fillRoundRect(x, y, w, h, 3, C_PANEL);
    tft.drawRoundRect(x, y, w, h, 3, C_BORDER);

    // Label
    tft.setTextColor(C_DIM, C_PANEL);
    tft.setTextSize(1);
    tft.setCursor(x + 4, y + 3);
    tft.print(label);

    // Value
    tft.setTextColor(valueColor, C_PANEL);
    tft.setTextSize(valueSize);
    // Center value horizontally in box
    int charW = valueSize * 6;
    int valLen = strlen(value);
    int vx = x + (w - valLen * charW) / 2;
    if (vx < x + 2) vx = x + 2;
    tft.setCursor(vx, y + 13);
    tft.print(value);
}

// Draw a labeled value box — String overload
void drawBox(int x, int y, int w, int h,
             const char* label, String value,
             uint16_t valueColor, uint8_t valueSize) {
    drawBox(x, y, w, h, label, value.c_str(), valueColor, valueSize);
}

// --- Screens -----------------------------------------------------------------

void screenBase() {
    // Full background
    tft.fillScreen(C_BG);

    // Top header bar
    tft.fillRect(0, 0, W, 18, C_PANEL);
    tft.drawFastHLine(0, 18, W, C_ACCENT);

    // Header: device name left, status right
    tft.setTextColor(C_ACCENT, C_PANEL);
    tft.setTextSize(1);
    tft.setCursor(4, 5);
    tft.print("T-DISPLAY CLIENT");

    // Bottom footer bar
    tft.drawFastHLine(0, H - 14, W, C_BORDER);
    tft.fillRect(0, H - 13, W, 13, C_PANEL);
}

void screenScanning() {
    screenBase();

    // Status badge top-right
    tft.setTextColor(C_YELLOW, C_PANEL);
    tft.setTextSize(1);
    tft.setCursor(W - 60, 5);
    tft.print("BLE:SCAN");

    // Big scanning text
    tft.setTextColor(C_YELLOW, C_BG);
    tft.setTextSize(2);
    tft.setCursor(8, 28);
    tft.print("Scanning...");

    tft.setTextColor(C_DIM, C_BG);
    tft.setTextSize(1);
    tft.setCursor(8, 52);
    tft.print("Looking for: C3_Sensor");

    // Animated dot indicator using uptime
    tft.setTextColor(C_ACCENT, C_BG);
    tft.setCursor(8, 66);
    int dots = (millis() / 400) % 4;
    for (int i = 0; i < dots; i++) tft.print("* ");

    // Footer: uptime
    tft.setTextColor(C_DIM, C_PANEL);
    tft.setTextSize(1);
    tft.setCursor(4, H - 11);
    tft.print("UPTIME: ");
    tft.setTextColor(C_WHITE, C_PANEL);
    tft.print(formatTime(millis() - startMs));
}

void screenConnecting() {
    screenBase();

    tft.setTextColor(C_ORANGE, C_PANEL);
    tft.setTextSize(1);
    tft.setCursor(W - 72, 5);
    tft.print("BLE:CONN...");

    tft.setTextColor(C_ORANGE, C_BG);
    tft.setTextSize(2);
    tft.setCursor(8, 28);
    tft.print("Connecting");

    tft.setTextColor(C_DIM, C_BG);
    tft.setTextSize(1);
    tft.setCursor(8, 52);
    tft.print("Target: C3_Sensor");

    tft.setTextColor(C_DIM, C_PANEL);
    tft.setCursor(4, H - 11);
    tft.print("UPTIME: ");
    tft.setTextColor(C_WHITE, C_PANEL);
    tft.print(formatTime(millis() - startMs));
}

void screenConnected() {
    screenBase();

    // Status badge
    tft.setTextColor(C_GREEN, C_PANEL);
    tft.setTextSize(1);
    tft.setCursor(W - 54, 5);
    tft.print("BLE:LIVE");

    // --- Row 1: big VALUE box + AGE box ---
    // Value box is wide, age box is narrow
    // VALUE
    char valStr[12];
    snprintf(valStr, sizeof(valStr), "%d", lastValue);
    drawBox(4, 22, 110, 50, "VALUE", valStr, C_YELLOW, 3);

    // AGE — color changes with staleness
    char ageStr[8];
    snprintf(ageStr, sizeof(ageStr), "%ds", ageSeconds());
    drawBox(118, 22, 56, 50, "AGE", ageStr, ageColor(), 2);

    // PEAK
    char peakStr[12];
    snprintf(peakStr, sizeof(peakStr), "%d", peakValue);
    drawBox(178, 22, 58, 50, "PEAK", peakStr, C_ACCENT, 2);

    // --- Row 2: PKTS, SESSION, SOURCE ---
    char pktsStr[10];
    snprintf(pktsStr, sizeof(pktsStr), "%d", packetsReceived);
    drawBox(4, 76, 68, 36, "PACKETS", pktsStr, C_WHITE, 1);

    char sessStr[10];
    int ss = sessionSeconds();
    snprintf(sessStr, sizeof(sessStr), "%02d:%02d", ss/60, ss%60);
    drawBox(76, 76, 80, 36, "SESSION", sessStr, C_ACCENT, 1);

    drawBox(160, 76, 76, 36, "SOURCE", "C3_Sensor", C_GREEN, 1);

    // Footer: system uptime
    tft.setTextColor(C_DIM, C_PANEL);
    tft.setTextSize(1);
    tft.setCursor(4, H - 11);
    tft.print("UPTIME: ");
    tft.setTextColor(C_WHITE, C_PANEL);
    tft.print(formatTime(millis() - startMs));

    // Footer right: packet rate hint
    tft.setTextColor(C_DIM, C_PANEL);
    tft.setCursor(W - 72, H - 11);
    tft.print("2s interval");
}

void screenFailed() {
    screenBase();

    tft.setTextColor(C_RED, C_PANEL);
    tft.setTextSize(1);
    tft.setCursor(W - 54, 5);
    tft.print("BLE:ERR");

    tft.setTextColor(C_RED, C_BG);
    tft.setTextSize(2);
    tft.setCursor(8, 28);
    tft.print("FAILED");

    tft.setTextColor(C_DIM, C_BG);
    tft.setTextSize(1);
    tft.setCursor(8, 52);
    tft.print("Could not reach C3_Sensor");
    tft.setCursor(8, 64);
    tft.print("Retrying scan...");

    tft.setTextColor(C_DIM, C_PANEL);
    tft.setCursor(4, H - 11);
    tft.print("UPTIME: ");
    tft.setTextColor(C_WHITE, C_PANEL);
    tft.print(formatTime(millis() - startMs));
}

void screenDisconnected() {
    screenBase();

    tft.setTextColor(C_RED, C_PANEL);
    tft.setTextSize(1);
    tft.setCursor(W - 60, 5);
    tft.print("BLE:LOST");

    tft.setTextColor(C_RED, C_BG);
    tft.setTextSize(2);
    tft.setCursor(8, 26);
    tft.print("LINK LOST");

    tft.setTextColor(C_DIM, C_BG);
    tft.setTextSize(1);
    tft.setCursor(8, 50);
    tft.print("Last value:  ");
    tft.setTextColor(C_YELLOW, C_BG);
    tft.print(lastValue);

    tft.setTextColor(C_DIM, C_BG);
    tft.setCursor(8, 62);
    tft.print("Packets rcvd: ");
    tft.setTextColor(C_WHITE, C_BG);
    tft.print(packetsReceived);

    tft.setCursor(8, 74);
    tft.setTextColor(C_DIM, C_BG);
    tft.print("Session: ");
    tft.setTextColor(C_ACCENT, C_BG);
    int ss = sessionSeconds();
    char sessStr[10];
    snprintf(sessStr, sizeof(sessStr), "%02d:%02d", ss/60, ss%60);
    tft.print(sessStr);

    tft.setTextColor(C_DIM, C_PANEL);
    tft.setCursor(4, H - 11);
    tft.print("UPTIME: ");
    tft.setTextColor(C_WHITE, C_PANEL);
    tft.print(formatTime(millis() - startMs));
}

// --- BLE Callbacks -----------------------------------------------------------

class ClientCallbacks : public NimBLEClientCallbacks {
    void onDisconnect(NimBLEClient* pclient) override {
        connected = false;
        scanning  = false;
        Serial.println("Disconnected");
    }
};

class ScanCallbacks : public NimBLEAdvertisedDeviceCallbacks {
    void onResult(NimBLEAdvertisedDevice* advertisedDevice) override {
        Serial.print("Found: ");
        Serial.println(advertisedDevice->getName().c_str());
        if (advertisedDevice->getName() == "C3_Sensor") {
            NimBLEDevice::getScan()->stop();
            targetAddress = advertisedDevice->getAddress();
            doConnect     = true;
            scanning      = false;
            Serial.println("Target found, connecting...");
        }
    }
};

// --- Notify ------------------------------------------------------------------

static void notifyCallback(
    NimBLERemoteCharacteristic* pChar,
    uint8_t* pData, size_t length, bool isNotify)
{
    if (length == 0 || length > 16) return;

    char buf[17] = {0};
    bool valid = true;
    for (size_t i = 0; i < length; i++) {
        if (pData[i] < '0' || pData[i] > '9') { valid = false; break; }
        buf[i] = (char)pData[i];
    }
    if (!valid) return;

    int parsed = atoi(buf);
    if (parsed == 0 && packetsReceived == 0) return; // skip stale init

    lastValue = parsed;
    if (lastValue > peakValue) peakValue = lastValue; // track peak
    packetsReceived++;
    lastPacketMs = millis();

    Serial.print("RX: ");
    Serial.println(lastValue);
}

// --- Connect -----------------------------------------------------------------

bool connectToServer() {
    screenConnecting();

    if (pClient == nullptr) {
        pClient = NimBLEDevice::createClient();
        pClient->setClientCallbacks(new ClientCallbacks());
    }

    if (!pClient->connect(targetAddress)) {
        Serial.println("Connect failed");
        return false;
    }
    Serial.println("Connected");

    NimBLERemoteService* pService = pClient->getService(serviceUUID);
    if (!pService) { pClient->disconnect(); return false; }

    NimBLERemoteCharacteristic* pChar = pService->getCharacteristic(charUUID);
    if (!pChar)    { pClient->disconnect(); return false; }

    if (pChar->canNotify()) {
        bool ok = pChar->subscribe(true, notifyCallback);
        Serial.print("Subscribe: ");
        Serial.println(ok ? "OK" : "FAILED");
        if (!ok) { pClient->disconnect(); return false; }
    } else {
        return false;
    }

    return true;
}

// --- Scan --------------------------------------------------------------------

void startScan() {
    Serial.println("Scanning...");
    scanning  = true;
    doConnect = false;
    screenScanning();
    NimBLEScan* pScan = NimBLEDevice::getScan();
    pScan->setAdvertisedDeviceCallbacks(new ScanCallbacks());
    pScan->setActiveScan(true);
    pScan->start(10, false);
}

// --- Setup -------------------------------------------------------------------

void setup() {
    Serial.begin(115200);

    pinMode(4, OUTPUT);
    digitalWrite(4, HIGH);

    tft.init();
    tft.setRotation(1);
    tft.fillScreen(C_BG);
    tft.setTextColor(C_WHITE, C_BG);
    tft.setTextSize(2);
    tft.setCursor(8, 50);
    tft.print("Booting...");

    NimBLEDevice::init("");
    delay(500);

    startMs = millis();
    startScan();
}

// --- Loop --------------------------------------------------------------------

void loop() {
    unsigned long now = millis();

    if (doConnect) {
        doConnect = false;
        if (connectToServer()) {
            connected     = true;
            connectedAtMs = now;
            drawnValue    = -1;
            lastPacketMs  = now;
            screenConnected();
        } else {
            screenFailed();
            delay(3000);
            startScan();
        }
        return;
    }

    if (!connected && !scanning && !doConnect) {
        delay(1000);
        startScan();
        return;
    }

    // Refresh screen every 500ms so age/uptime/session tick live
    if (now - lastScreenMs >= 500) {
        lastScreenMs = now;
        if (connected) {
            screenConnected();
        } else if (scanning) {
            screenScanning();
        }
    }

    // Show disconnect screen immediately when connection drops
    if (!connected && !scanning) {
        screenDisconnected();
    }

    delay(50);
}
