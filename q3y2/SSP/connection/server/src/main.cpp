#include <Arduino.h>
#include <Wire.h>
#include <Adafruit_GFX.h>
#include <Adafruit_SSD1306.h>
#include <NimBLEDevice.h>

#define SCREEN_WIDTH 128
#define SCREEN_HEIGHT 64
#define I2C_SDA_PIN  8
#define I2C_SCL_PIN  9
#define BTN_PIN      9

#define SERVICE_UUID        "4fafc201-1fb5-459e-8fcc-c5c9c331914b"
#define CHARACTERISTIC_UUID "beb5483e-36e1-4688-b7f5-ea07361b26a8"

enum Direction { LEFT = 0, RIGHT = 1, UP = 2, DOWN = 3 };
const char* dirNames[] = {"LEFT", "RIGHT", "UP", "DOWN"};

Adafruit_SSD1306 display(SCREEN_WIDTH, SCREEN_HEIGHT, &Wire, -1);
NimBLEServer*         pServer         = nullptr;
NimBLECharacteristic* pCharacteristic = nullptr;

bool          deviceConnected    = false;
bool          oledOk             = false;
int           packetsSent        = 0;
unsigned long startMs            = 0;
unsigned long lastAutoSendMs     = 0;

Direction     currentDir     = LEFT;

void screenConnectedData() {
    if (!oledOk) return;
    display.clearDisplay();
    display.setTextColor(WHITE);
    display.setTextSize(1);
    display.setCursor(0, 0);
    display.printf("C3 SERVER [%s]", deviceConnected ? "LIVE" : "WAIT");
    display.drawFastHLine(0, 9, 128, WHITE);
    display.setTextSize(2);
    display.setCursor(10, 25);
    display.print(dirNames[currentDir]);
    display.setTextSize(1);
    display.setCursor(0, 55);
    display.printf("Sent: %d", packetsSent);
    display.display();
}

class ServerCallbacks : public NimBLEServerCallbacks {
    void onConnect(NimBLEServer* pServer) override {
        deviceConnected = true;
        Serial.println(">>> Client Connected");
    }
    void onDisconnect(NimBLEServer* pServer) override {
        deviceConnected = false;
        Serial.println(">>> Client Disconnected. Restarting Advertising...");
        NimBLEDevice::startAdvertising();
    }
};

void setup() {
    Serial.begin(115200);
    delay(1000);
    Serial.println("\n\n--- C3 SERVER STARTING ---");

    Wire.begin(I2C_SDA_PIN, I2C_SCL_PIN);
    oledOk = display.begin(SSD1306_SWITCHCAPVCC, 0x3C);
    
    randomSeed(analogRead(0));

    NimBLEDevice::init("C3_Sensor");
    pServer = NimBLEDevice::createServer();
    pServer->setCallbacks(new ServerCallbacks());
    
    NimBLEService* pService = pServer->createService(SERVICE_UUID);
    pCharacteristic = pService->createCharacteristic(CHARACTERISTIC_UUID, NIMBLE_PROPERTY::NOTIFY);
    pService->start();

    NimBLEAdvertising* pAdvertising = NimBLEDevice::getAdvertising();
    pAdvertising->addServiceUUID(SERVICE_UUID);
    pAdvertising->setScanResponse(true);
    pAdvertising->start();

    Serial.println("Advertising active: 'C3_Sensor'");
    startMs = millis();
}

void loop() {
    unsigned long now = millis();

    // Randomize and Send every 2 seconds
    if (now - lastAutoSendMs >= 2000) {
        lastAutoSendMs = now;
        currentDir = (Direction)random(0, 4);
        
        if (deviceConnected) {
            uint8_t val = (uint8_t)currentDir;
            pCharacteristic->setValue(&val, 1);
            pCharacteristic->notify();
            packetsSent++;
            Serial.printf("[TX] Sent: %s\n", dirNames[currentDir]);
        } else {
            Serial.printf("[IDLE] Generated: %s (No Client)\n", dirNames[currentDir]);
        }
        screenConnectedData();
    }

    // Manual Reset Advertising if stuck
    static unsigned long lastAdvCheck = 0;
    if (!deviceConnected && (now - lastAdvCheck > 5000)) {
        lastAdvCheck = now;
        if (!NimBLEDevice::getAdvertising()->isAdvertising()) {
            NimBLEDevice::startAdvertising();
        }
    }

    delay(20);
}
