#include <Arduino.h>
#include <Wire.h>
#include <Adafruit_GFX.h>
#include <Adafruit_SSD1306.h>
#include <NimBLEDevice.h>
#include <cstring>
#include <stdint.h>

#define SCREEN_WIDTH 128
#define SCREEN_HEIGHT 64
#define I2C_SDA_PIN  8
#define I2C_SCL_PIN  9
#define BTN_PIN      2

#define SERVICE_UUID        "4fafc201-1fb5-459e-8fcc-c5c9c331914b"
#define CHARACTERISTIC_UUID "beb5483e-36e1-4688-b7f5-ea07361b26a8"

#define SCREEN_INTERVAL_MS  2000
#define SCREEN_DATA_MS      250
#define BATCH_MS            16   // ~60Hz

struct ImuSample {
    int16_t ax, ay, az;
    int16_t gx, gy, gz;
};

static_assert(sizeof(ImuSample) == 12, "ImuSample must be 12 bytes");

#define NUM_IMUS 6

int packImuBatch(uint8_t* buf, uint8_t seq, uint32_t ts_ms, const ImuSample* imus, int count) {
    int off = 0;
    buf[off++] = seq;
    memcpy(buf + off, &ts_ms, sizeof(uint32_t));
    off += sizeof(uint32_t);
    for (int i = 0; i < count; i++) {
        memcpy(buf + off, &imus[i], sizeof(ImuSample));
        off += sizeof(ImuSample);
    }
    return off;
}

Adafruit_SSD1306 display(SCREEN_WIDTH, SCREEN_HEIGHT, &Wire, -1);
NimBLEServer*         pServer         = nullptr;
NimBLECharacteristic* pCharacteristic = nullptr;

bool          deviceConnected    = false;
bool          oledOk             = false;
int           packetsSent        = 0;
uint8_t       seqOut             = 0;
unsigned long startMs            = 0;   // fixed: store boot time once
unsigned long lastScreenMs       = 0;
unsigned long lastBatchMs        = 0;
unsigned long disconnectedAtMs   = 0;
bool          showingDisconnect  = false;

ImuSample     imuSamples[NUM_IMUS];
uint8_t       screenPage     = 0;
bool          btnLastState   = HIGH;
unsigned long btnLastPress   = 0;

// ── helpers ──────────────────────────────────────────────────────────────────

void drawDivider(int y) {
    display.drawFastHLine(0, y, SCREEN_WIDTH, WHITE);
}

String formatUptime(unsigned long ms) {
    unsigned long s = ms / 1000;
    char buf[10];
    snprintf(buf, sizeof(buf), "%02u:%02u:%02u",
             (unsigned)(s / 3600),
             (unsigned)((s % 3600) / 60),
             (unsigned)(s % 60));
    return String(buf);
}

// ── screens ──────────────────────────────────────────────────────────────────

void screenBoot(const char* msg) {
    if (!oledOk) return;
    display.clearDisplay();
    display.setTextColor(WHITE);   // always reset before drawing
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
    unsigned long uptimeMs = millis() - startMs;

    display.clearDisplay();
    display.setTextColor(WHITE);   // reset here too
    display.setTextSize(1);

    display.setCursor(0, 0);
    display.print("C3_Sensor");
    display.setCursor(80, 0);
    display.print("BLE:ADV");
    drawDivider(9);

    display.setCursor(0, 13);
    display.println("Waiting for client");
    display.setCursor(0, 24);
    int dots = (uptimeMs / 500) % 4;
    for (int i = 0; i < dots; i++) display.print(".");

    drawDivider(54);
    display.setCursor(0, 56);
    display.print("Up: ");
    display.print(formatUptime(uptimeMs));
    display.display();
}

void screenConnectedData() {
    if (!oledOk) return;
    unsigned long uptimeMs = millis() - startMs;

    char buf[16];
    display.clearDisplay();
    display.setTextColor(WHITE);   // reset at top of every draw call
    display.setTextSize(1);

    int base = screenPage * 3;  // Page 0: IMU 0-2 | Page 1: IMU 3-5

    const int labelW = 16;
    const int dataW  = 37;

    // Column headers
    for (int i = 0; i < 3; i++) {
        snprintf(buf, sizeof(buf), "I%d", base + i);
        display.setCursor(labelW + i * dataW + 2, 0);
        display.print(buf);
    }
    display.drawFastHLine(0, 8, SCREEN_WIDTH, WHITE);

    // Data rows: AX AY AZ | GX GY GZ
    const char* labels[] = {"AX","AY","AZ","GX","GY","GZ"};

    for (int j = 0; j < 6; j++) {
        int y = 12 + j * 7;

        display.setCursor(1, y);
        display.print(labels[j]);

        for (int i = 0; i < 3; i++) {
            ImuSample* s = &imuSamples[base + i];
            int16_t dv = 0;
            switch (j) {
                case 0: dv = s->ax; break;
                case 1: dv = s->ay; break;
                case 2: dv = s->az; break;
                case 3: dv = s->gx; break;
                case 4: dv = s->gy; break;
                case 5: dv = s->gz; break;
            }
            snprintf(buf, sizeof(buf), "%4d", (int)dv);
            display.setCursor(labelW + i * dataW + 2, y);
            display.print(buf);
        }

        if (j == 2) drawDivider(y + 7);   // divider between accel and gyro
    }

    // Footer: white bar with black text
    display.fillRect(0, 56, SCREEN_WIDTH, 8, WHITE);
    display.setTextColor(BLACK);
    display.setCursor(2, 57);
    snprintf(buf, sizeof(buf), "P%u", packetsSent);
    display.print(buf);
    display.setCursor(30, 57);
    display.print(formatUptime(uptimeMs));
    display.setCursor(96, 57);
    snprintf(buf, sizeof(buf), "Pg%d", screenPage + 1);
    display.print(buf);

    // *** KEY FIX: restore WHITE before display() so the next call starts clean ***
    display.setTextColor(WHITE);

    display.display();
}

void screenDisconnected() {
    if (!oledOk) return;
    unsigned long uptimeMs = millis() - startMs;

    display.clearDisplay();
    display.setTextColor(WHITE);   // reset
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

// ── BLE callbacks ─────────────────────────────────────────────────────────────

class ServerCallbacks : public NimBLEServerCallbacks {
    void onConnect(NimBLEServer*) override {
        deviceConnected = true;
    }
    void onDisconnect(NimBLEServer*) override {
        deviceConnected   = false;
        showingDisconnect = true;
        disconnectedAtMs  = millis();
    }
};

// ── setup ─────────────────────────────────────────────────────────────────────

void setup() {
    Serial.begin(115200);
    Wire.begin(I2C_SDA_PIN, I2C_SCL_PIN);
    pinMode(BTN_PIN, INPUT_PULLUP);
    delay(250);

    oledOk = display.begin(SSD1306_SWITCHCAPVCC, 0x3C);
    Serial.print("SSD1306 init: ");
    Serial.println(oledOk ? "OK" : "FAILED — continuing without display");
    if (oledOk) {
        display.setTextColor(WHITE);
        display.setTextSize(1);
    }

    screenBoot("Init BLE...");

    NimBLEDevice::init("C3_Sensor");
    NimBLEDevice::setMTU(200);
    pServer = NimBLEDevice::createServer();
    pServer->setCallbacks(new ServerCallbacks());

    NimBLEService* pService = pServer->createService(SERVICE_UUID);
    pCharacteristic = pService->createCharacteristic(
        CHARACTERISTIC_UUID,
        NIMBLE_PROPERTY::NOTIFY
    );
    pService->start();

    NimBLEAdvertising* pAdvertising = NimBLEDevice::getAdvertising();
    pAdvertising->addServiceUUID(SERVICE_UUID);
    pAdvertising->start();

    screenBoot("Ready. Advertising.");

    startMs      = millis();   // record boot time once
    lastBatchMs  = millis();
    lastScreenMs = millis();
}

// ── loop ──────────────────────────────────────────────────────────────────────

void loop() {
    unsigned long now = millis();
    static unsigned long lastDataMs = 0;

    // Show disconnect screen then re-advertise after 1.5 s
    if (showingDisconnect) {
        screenDisconnected();
        if (now - disconnectedAtMs >= 1500) {
            showingDisconnect = false;
            NimBLEDevice::getAdvertising()->start();
        }
        return;
    }

    // Send IMU batch ~60 Hz
    if (deviceConnected && (now - lastBatchMs >= BATCH_MS)) {
        lastBatchMs = now;
        seqOut++;

        // Replace with real IMU reads here
        for (int i = 0; i < NUM_IMUS; i++) {
            imuSamples[i].ax = (i + 1) * 100 + (seqOut % 50);
            imuSamples[i].ay = (i + 1) * 200 + (seqOut % 50);
            imuSamples[i].az = (i + 1) * 300 + (seqOut % 50);
            imuSamples[i].gx = (i + 1) * 10  + (seqOut % 20);
            imuSamples[i].gy = (i + 1) * 20  + (seqOut % 20);
            imuSamples[i].gz = (i + 1) * 30  + (seqOut % 20);
        }

        uint8_t pkt[197];
        int len = packImuBatch(pkt, seqOut, now, imuSamples, NUM_IMUS);
        pCharacteristic->setValue(pkt, len);
        pCharacteristic->notify();
        packetsSent = seqOut;
    }

    // Button: toggle page (debounced 200 ms)
    bool btnState = digitalRead(BTN_PIN);
    if (btnState == LOW && btnLastState == HIGH && (now - btnLastPress > 200)) {
        btnLastPress = now;
        screenPage = (screenPage + 1) % 2;
        Serial.printf("Button pressed — page %d\n", screenPage);
        // Force immediate redraw on page change
        lastDataMs = 0;
    }
    btnLastState = btnState;

    // Refresh display
    if (deviceConnected) {
        if (now - lastDataMs >= SCREEN_DATA_MS) {
            lastDataMs = now;
            screenConnectedData();
        }
    } else {
        if (now - lastScreenMs >= SCREEN_INTERVAL_MS) {
            lastScreenMs = now;
            screenWaiting();
        }
    }
}
