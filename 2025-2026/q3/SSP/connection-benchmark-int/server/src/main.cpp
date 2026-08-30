#include <Arduino.h>
#include <Wire.h>
#include <Adafruit_GFX.h>
#include <Adafruit_SSD1306.h>
#include <NimBLEDevice.h>

#define SCREEN_WIDTH 128
#define SCREEN_HEIGHT 64
#define I2C_SDA_PIN  8
#define I2C_SCL_PIN  9

#define SERVICE_UUID        "4fafc201-1fb5-459e-8fcc-c5c9c331914b"
#define CHARACTERISTIC_UUID "beb5483e-36e1-4688-b7f5-ea07361b26a8"

#define SEND_INTERVAL_MS    2000   // How often to send data
#define SCREEN_INTERVAL_MS  500    // How often to refresh screen (finer than send)

Adafruit_SSD1306 display(SCREEN_WIDTH, SCREEN_HEIGHT, &Wire, -1);
NimBLEServer*         pServer         = nullptr;
NimBLECharacteristic* pCharacteristic = nullptr;

bool          deviceConnected    = false;
bool          wasConnected       = false;   // Edge detection for disconnect event
bool          oledOk             = false;
int           sensorValue        = 0;
int           packetsSent        = 0;
unsigned long uptimeMs           = 0;
unsigned long lastTickMs         = 0;
unsigned long lastSendMs         = 0;
unsigned long lastScreenMs       = 0;
unsigned long disconnectedAtMs   = 0;       // When disconnect happened
bool          showingDisconnect  = false;   // Are we showing the disconnect screen?

// ─── Helpers ─────────────────────────────────────────────────────────────────

void drawDivider(int y) {
    display.drawFastHLine(0, y, SCREEN_WIDTH, WHITE);
}

String formatUptime(unsigned long ms) {
    unsigned long s = ms / 1000;
    char buf[10];
    snprintf(buf, sizeof(buf), "%02lu:%02lu:%02lu", s/3600, (s%3600)/60, s%60);
    return String(buf);
}

// ─── Screen Renderers ────────────────────────────────────────────────────────

void screenBoot(const char* msg) {
    if (!oledOk) return;
    display.clearDisplay();
    display.setTextSize(1);
    display.setCursor(0, 0);
    display.println("== ESP32-C3 SERVER ==");
    drawDivider(10);
    display.setCursor(0, 16);
    display.println("Booting...");
    display.setCursor(0, 28);
    display.println(msg);
    display.display();
}

void screenWaiting() {
    if (!oledOk) return;
    display.clearDisplay();
    display.setTextSize(1);
    display.setCursor(0, 0);
    display.print("C3_Sensor");
    display.setCursor(80, 0);
    display.print("BLE:ADV");
    drawDivider(9);
    display.setCursor(0, 13);
    display.println("Waiting for client");

    // Animated dots — now driven by real ms, not loop count
    display.setCursor(0, 24);
    int dots = (uptimeMs / 500) % 4;   // Cycles every 500ms regardless of loop speed
    for (int i = 0; i < dots; i++) display.print(".");

    drawDivider(54);
    display.setCursor(0, 56);
    display.print("Up: ");
    display.print(formatUptime(uptimeMs));
    display.display();
}

void screenConnected() {
    if (!oledOk) return;
    display.clearDisplay();
    display.setTextSize(1);
    display.setCursor(0, 0);
    display.print("C3_Sensor");
    display.setCursor(74, 0);
    display.print("BLE:CONN");
    drawDivider(9);

    display.setTextSize(2);
    display.setCursor(0, 14);
    display.print("VAL:");
    display.print(sensorValue);

    display.setTextSize(1);
    display.setCursor(0, 34);
    display.print("Pkts sent : ");
    display.print(packetsSent);

    drawDivider(44);
    display.setCursor(0, 47);
    display.print("Up : ");
    display.print(formatUptime(uptimeMs));
    display.setCursor(0, 56);
    display.print("Client : ACTIVE");
    display.display();
}

void screenDisconnected() {
    if (!oledOk) return;
    display.clearDisplay();
    display.setTextSize(1);
    display.setCursor(0, 0);
    display.print("C3_Sensor");
    display.setCursor(68, 0);
    display.print("BLE:LOST");
    drawDivider(9);
    display.setCursor(0, 16);
    display.println("Client disconnected");
    display.setCursor(0, 28);
    display.println("Re-advertising...");
    drawDivider(44);
    display.setCursor(0, 47);
    display.print("Pkts sent: ");
    display.print(packetsSent);
    display.setCursor(0, 56);
    display.print("Up: ");
    display.print(formatUptime(uptimeMs));
    display.display();
}

// ─── BLE Callbacks ───────────────────────────────────────────────────────────

class ServerCallbacks : public NimBLEServerCallbacks {
    void onConnect(NimBLEServer* pServer) override {
        deviceConnected = true;
    }
    void onDisconnect(NimBLEServer* pServer) override {
        deviceConnected   = false;
        showingDisconnect = true;
        disconnectedAtMs  = millis();
        // FIX: NO delay() here — just set a flag, handle in loop()
        // Calling delay() inside a BLE callback blocks the NimBLE task
        // and causes watchdog resets / client crashes
    }
};

// ─── Setup ───────────────────────────────────────────────────────────────────

void setup() {
    Serial.begin(115200);
    Wire.begin(I2C_SDA_PIN, I2C_SCL_PIN);
    delay(250); // Only delay() safe here — we're not in a BLE callback

    oledOk = display.begin(SSD1306_SWITCHCAPVCC, 0x3C);
    if (!oledOk) {
        Serial.println("SSD1306 init failed — continuing without display.");
    } else {
        display.setTextColor(WHITE);
        display.setTextSize(1);
    }

    screenBoot("Init BLE...");

    NimBLEDevice::init("C3_Sensor");
    pServer = NimBLEDevice::createServer();
    pServer->setCallbacks(new ServerCallbacks());

    NimBLEService* pService = pServer->createService(SERVICE_UUID);
    pCharacteristic = pService->createCharacteristic(
        CHARACTERISTIC_UUID,
        NIMBLE_PROPERTY::NOTIFY
    );
    pCharacteristic->setValue((uint8_t*)"0", 1);
    pService->start();

    NimBLEAdvertising* pAdvertising = NimBLEDevice::getAdvertising();
    pAdvertising->addServiceUUID(SERVICE_UUID);
    pAdvertising->start();

    screenBoot("Ready. Advertising.");

    lastTickMs  = millis();
    lastSendMs  = millis();
    lastScreenMs = millis();
}

// ─── Loop ────────────────────────────────────────────────────────────────────

void loop() {
    unsigned long now = millis();

    // ── Always update uptime ──────────────────────────────────────────────────
    uptimeMs = now - lastTickMs; // FIX: Just track elapsed — no blocking tick needed
    // (reset lastTickMs in setup, never again)

    // ── Handle disconnect screen + re-advertise after 1.5s ───────────────────
    if (showingDisconnect) {
        screenDisconnected();
        if (now - disconnectedAtMs >= 1500) {
            showingDisconnect = false;
            NimBLEDevice::getAdvertising()->start(); // Safe to call from loop()
        }
        return; // Skip send logic while showing disconnect
    }

    // ── Send data on interval ─────────────────────────────────────────────────
    if (deviceConnected && (now - lastSendMs >= SEND_INTERVAL_MS)) {
    lastSendMs = now;
    sensorValue = random(1000,9999);
    packetsSent++;

    // Send as raw bytes with explicit length — no c_str(), no null terminator ambiguity
    String payload = String(sensorValue);
    pCharacteristic->setValue((uint8_t*)payload.c_str(), payload.length());
    pCharacteristic->notify();
    }

    // ── Refresh screen on its own faster interval ─────────────────────────────
    if (now - lastScreenMs >= SCREEN_INTERVAL_MS) {
        lastScreenMs = now;
        if (deviceConnected) {
            screenConnected();
        } else {
            screenWaiting();
        }
    }

    // FIX: No delay() at all — loop runs free, timers control everything
}
