#include "BleConnection.h"

// --- Global/Static pointers for callbacks ---
#if defined(ARDUINO_ARCH_ESP32)
#include <NimBLEDevice.h>
static BleConnection::NotifyCallback _clientCallback = nullptr;
static bool _doConnect = false;
static bool _connected = false;
static bool _scanning  = false;
static NimBLEAddress _targetAddress;
static NimBLEClient* _pClient = nullptr;
#endif

#if defined(ARDUINO_ARCH_NRF52)
#include <ArduinoBLE.h>
static BLEService* _pService = nullptr;
static BLECharacteristic* _pChar = nullptr;
#endif

BleConnection::BleConnection() : _seqOut(0) {}

int BleConnection::packGesture(uint8_t* buf, uint8_t seq, uint32_t ts, Gesture gesture) {
    int off = 0;
    buf[off++] = seq;
    memcpy(buf + off, &ts, sizeof(uint32_t));
    off += sizeof(uint32_t);
    buf[off++] = (uint8_t)gesture;
    return off;
}

// =============================================================================
// SERVER IMPLEMENTATION (Nano 33 BLE)
// =============================================================================
#if defined(ARDUINO_ARCH_NRF52)

bool BleConnection::initServer(const char* deviceName) {
    if (!BLE.begin()) return false;

    _pService = new BLEService(BLE_SERVICE_UUID);
    // Gesture packet is small (6 bytes)
    _pChar = new BLECharacteristic(BLE_CHARACTERISTIC_UUID, BLERead | BLENotify, 20);

    BLE.setLocalName(deviceName);
    BLE.setAdvertisedService(*_pService);
    _pService->addCharacteristic(*_pChar);
    BLE.addService(*_pService);
    BLE.advertise();
    return true;
}

bool BleConnection::isConnected() {
    return BLE.central().connected();
}

void BleConnection::sendGesture(Gesture gesture) {
    _seqOut++;
    uint8_t pkt[20];
    int len = packGesture(pkt, _seqOut, millis(), gesture);
    _pChar->writeValue(pkt, len);
}

void BleConnection::updateServer() {
    static bool wasConnected = false;
    bool connected = isConnected();
    if (wasConnected && !connected) {
        BLE.advertise(); // Restart advertising on disconnect
    }
    wasConnected = connected;
}

#endif

// =============================================================================
// CLIENT IMPLEMENTATION (ESP32)
// =============================================================================
#if defined(ARDUINO_ARCH_ESP32)

class ClientCallbacks : public NimBLEClientCallbacks {
    void onDisconnect(NimBLEClient* pclient) override { _connected = false; _scanning = false; }
};

class ScanCallbacks : public NimBLEAdvertisedDeviceCallbacks {
    void onResult(NimBLEAdvertisedDevice* advertisedDevice) override {
        if (advertisedDevice->isAdvertisingService(NimBLEUUID(BLE_SERVICE_UUID))) {
            NimBLEDevice::getScan()->stop();
            _targetAddress = advertisedDevice->getAddress();
            _doConnect = true;
            _scanning = false;
        }
    }
};

static void internalNotifyCallback(NimBLERemoteCharacteristic* pChar, uint8_t* pData, size_t length, bool isNotify) {
    if (length < 6 || !_clientCallback) return;
    uint8_t seq = pData[0];
    uint32_t ts;
    memcpy(&ts, pData + 1, sizeof(uint32_t));
    Gesture gesture = (Gesture)pData[5];
    _clientCallback(seq, ts, gesture);
}

bool BleConnection::initClient(NotifyCallback callback) {
    _clientCallback = callback;
    NimBLEDevice::init("");
    NimBLEDevice::setMTU(200);
    
    NimBLEScan* pScan = NimBLEDevice::getScan();
    pScan->setAdvertisedDeviceCallbacks(new ScanCallbacks());
    pScan->setActiveScan(true);
    pScan->start(0, false); // Start continuous scan
    _scanning = true;
    return true;
}

bool BleConnection::isConnected() { return _connected; }
bool BleConnection::isScanning()  { return _scanning; }

void BleConnection::updateClient() {
    if (_doConnect) {
        _doConnect = false;
        if (!_pClient) {
            _pClient = NimBLEDevice::createClient();
            _pClient->setClientCallbacks(new ClientCallbacks());
        }
        if (_pClient->connect(_targetAddress)) {
            NimBLERemoteService* pSvc = _pClient->getService(BLE_SERVICE_UUID);
            if (pSvc) {
                NimBLERemoteCharacteristic* pChr = pSvc->getCharacteristic(BLE_CHARACTERISTIC_UUID);
                if (pChr && pChr->canNotify()) {
                    if (pChr->subscribe(true, internalNotifyCallback)) {
                        _connected = true;
                        return;
                    }
                }
            }
        }
        _pClient->disconnect();
        NimBLEDevice::getScan()->start(0, false);
        _scanning = true;
    }

    if (!_connected && !_scanning) {
        NimBLEDevice::getScan()->start(0, false);
        _scanning = true;
    }
}

#endif
