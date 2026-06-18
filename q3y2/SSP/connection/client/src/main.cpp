#include <Arduino.h>
#include <TFT_eSPI.h>
#include <NimBLEDevice.h>

static NimBLEUUID serviceUUID("4fafc201-1fb5-459e-8fcc-c5c9c331914b");
static NimBLEUUID charUUID   ("beb5483e-36e1-4688-b7f5-ea07361b26a8");

TFT_eSPI tft = TFT_eSPI();

enum Direction { LEFT = 0, RIGHT = 1, UP = 2, DOWN = 3 };
const char* dirNames[] = {"LEFT", "RIGHT", "UP", "DOWN"};

#define C_BG        0x0841
#define C_ACCENT    0x07FF
#define C_WHITE     0xFFFF

NimBLEAddress targetAddress("");
bool          doConnect       = false;
bool          connected       = false;
Direction     lastDirection   = LEFT;
Direction     displayedDir    = (Direction)-1;
int           pkts            = 0;

class ClientCallbacks : public NimBLEClientCallbacks {
    void onConnect(NimBLEClient* pClient) override { connected = true; }
    void onDisconnect(NimBLEClient* pClient) override { 
        connected = false; 
        Serial.println("!!! Disconnected");
    }
};

void notifyCallback(NimBLERemoteCharacteristic* pChar, uint8_t* pData, size_t length, bool isNotify) {
    if (length > 0 && pData[0] < 4) {
        lastDirection = (Direction)pData[0];
        pkts++;
        Serial.printf("[RX] Received: %s\n", dirNames[lastDirection]);
    }
}

class ScanCallbacks : public NimBLEAdvertisedDeviceCallbacks {
    void onResult(NimBLEAdvertisedDevice* advertisedDevice) override {
        if (advertisedDevice->getName() == "C3_Sensor") {
            NimBLEDevice::getScan()->stop();
            targetAddress = advertisedDevice->getAddress();
            doConnect     = true;
        }
    }
};

void updateUI() {
    if (lastDirection != displayedDir) {
        tft.setTextColor(C_WHITE, C_BG);
        tft.setTextSize(4);
        tft.setTextPadding(200);
        tft.setCursor(40, 60);
        tft.print(dirNames[lastDirection]);
        displayedDir = lastDirection;
    }
    tft.setTextSize(1);
    tft.setCursor(4, 115);
    tft.setTextColor(0x7BEF, C_BG);
    tft.printf("Packets: %d", pkts);
}

bool connectToServer() {
    Serial.println(">>> Connecting...");
    NimBLEClient* pClient = NimBLEDevice::createClient();
    pClient->setClientCallbacks(new ClientCallbacks());
    if (!pClient->connect(targetAddress)) return false;

    NimBLERemoteService* pSvc = pClient->getService(serviceUUID);
    if (!pSvc) return false;
    NimBLERemoteCharacteristic* pChr = pSvc->getCharacteristic(charUUID);
    if (!pChr || !pChr->canNotify()) return false;
    
    return pChr->subscribe(true, notifyCallback);
}

void setup() {
    Serial.begin(115200);
    delay(1000);
    Serial.println("\n--- CLIENT STARTING ---");

    tft.init();
    tft.setRotation(1);
    tft.fillScreen(C_BG);
    tft.setTextColor(C_ACCENT);
    tft.setCursor(10, 10);
    tft.print("SCANNING...");

    NimBLEDevice::init("");
    NimBLEDevice::getScan()->setAdvertisedDeviceCallbacks(new ScanCallbacks());
    NimBLEDevice::getScan()->setActiveScan(true);
    NimBLEDevice::getScan()->start(0, false); // continuous scan
}

void loop() {
    if (doConnect) {
        doConnect = false;
        if (connectToServer()) {
            Serial.println(">>> Connected!");
            tft.fillScreen(C_BG);
            tft.setCursor(10, 10);
            tft.print("LIVE");
        } else {
            Serial.println(">>> Connection Failed");
            NimBLEDevice::getScan()->start(0, false);
        }
    }

    if (connected) {
        updateUI();
    } else {
        if (!NimBLEDevice::getScan()->isScanning()) {
            NimBLEDevice::getScan()->start(0, false);
        }
    }
    delay(50);
}
