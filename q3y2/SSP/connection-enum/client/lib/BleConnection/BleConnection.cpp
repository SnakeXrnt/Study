#include "BleConnection.h"

static const char* GESTURE_NAMES[] = {"SCRUNCH", "UP", "DOWN", "LEFT", "RIGHT", "NONE"};

// --- Global/Static pointers for callbacks ---
#if defined(ARDUINO_ARCH_ESP32)
#include <NimBLEDevice.h>
static BleConnection::NotifyCallback _clientCallback = nullptr;
static BleConnection::DiscoveryCallback _discoveryCallback = nullptr;
static bool _doConnect = false;
static bool _connected = false;
static bool _scanning  = false;
static bool _connecting = false;
static NimBLEAddress _targetAddress;
static NimBLEClient* _pClient = nullptr;

static void scanEndedCB(NimBLEScanResults results) {
    Serial.println(">>> [BLE] Scan ended.");
    _scanning = false;
}
#endif

#if defined(ARDUINO_ARCH_NRF52840)
#include <ArduinoBLE.h>
static BLEService* _pService = nullptr;
static BLECharacteristic* _pChar = nullptr;
#endif

BleConnection::BleConnection() : _seqOut(0) {}

const char* BleConnection::getGestureName(Gesture gesture) {
    if (gesture >= 0 && gesture <= 5) return GESTURE_NAMES[gesture];
    return "UNKNOWN";
}

Gesture BleConnection::stringToGesture(const char* name) {
    for (int i = 0; i < 6; i++) {
        if (strcmp(name, GESTURE_NAMES[i]) == 0) return (Gesture)i;
    }
    return GESTURE_NONE;
}

int BleConnection::packGesture(uint8_t* buf, uint8_t seq, uint32_t ts, Gesture gesture) {
    int off = 0;
    buf[off++] = seq;
    memcpy(buf + off, &ts, sizeof(uint32_t));
    off += sizeof(uint32_t);
    buf[off++] = (uint8_t)gesture;
    return off;
}

#if defined(ARDUINO_ARCH_NRF52840)
bool BleConnection::initServer(const char* deviceName) {
    if (!BLE.begin()) return false;

    _pService = new BLEService(BLE_SERVICE_UUID);
    _pChar = new BLECharacteristic(BLE_CHARACTERISTIC_UUID, BLERead | BLENotify, 20);

    // Add service and characteristic first
    _pService->addCharacteristic(*_pChar);
    BLE.addService(*_pService);

    // Set names
    BLE.setLocalName(deviceName);
    BLE.setDeviceName(deviceName);
    
    // Explicitly advertise the service UUID
    BLE.setAdvertisedService(*_pService);

    BLE.advertise();
    Serial.print("Started advertising as: ");
    Serial.println(deviceName);
    return true;
}

bool BleConnection::isConnected() { return BLE.central().connected(); }

void BleConnection::sendCommand(Gesture gesture) {
    _seqOut++;
    uint8_t pkt[20];
    int len = packGesture(pkt, _seqOut, millis(), gesture);
    _pChar->writeValue(pkt, len);
}

void BleConnection::sendCommand(const char* name) {
    sendCommand(stringToGesture(name));
}

void BleConnection::updateServer() {
    BLE.poll();
    static bool wasConnected = false;
    bool connected = isConnected();
    if (wasConnected && !connected) {
        Serial.println("Central disconnected, restarting advertising...");
        BLE.advertise();
    }
    if (!wasConnected && connected) {
        Serial.println("Central connected!");
    }
    wasConnected = connected;
}

void BleConnection::disconnect() {
    BLE.central().disconnect();
}
#endif

#if defined(ARDUINO_ARCH_ESP32)
class ClientCallbacks : public NimBLEClientCallbacks {
    void onDisconnect(NimBLEClient* pclient) override { 
        _connected = false; 
        _scanning = false; 
        _connecting = false;
    }
};

class ScanCallbacks : public NimBLEAdvertisedDeviceCallbacks {
    void onResult(NimBLEAdvertisedDevice* advertisedDevice) override {
        if (_discoveryCallback) {
            _discoveryCallback(advertisedDevice->getName().c_str(), 
                              advertisedDevice->getAddress().toString().c_str(), 
                              advertisedDevice->getRSSI());
        }

        bool isTarget = false;
        if (advertisedDevice->isAdvertisingService(NimBLEUUID(BLE_SERVICE_UUID))) {
            isTarget = true;
        } else if (advertisedDevice->getName() == "NanoCmd") {
            isTarget = true;
        }

        if (isTarget && !_connected && !_doConnect && !_connecting) {
            Serial.printf("Target detected! Name: %s, Addr: %s, RSSI: %d\n", 
                          advertisedDevice->getName().c_str(),
                          advertisedDevice->getAddress().toString().c_str(),
                          advertisedDevice->getRSSI());
            _targetAddress = advertisedDevice->getAddress();
            _doConnect = true;
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

bool BleConnection::initClient(NotifyCallback callback, DiscoveryCallback discovery) {
    _clientCallback = callback;
    _discoveryCallback = discovery;
    NimBLEDevice::init("");
    NimBLEDevice::setMTU(200);
    NimBLEScan* pScan = NimBLEDevice::getScan();
    pScan->setAdvertisedDeviceCallbacks(new ScanCallbacks());
    pScan->setActiveScan(true);
    _scanning = false;
    _connecting = false;
    _connected = false;
    return true;
}

bool BleConnection::isConnected()  { return _connected; }
bool BleConnection::isScanning()   { return _scanning; }
bool BleConnection::isConnecting() { return _connecting; }

void BleConnection::connect() {
    _doConnect = true;
}

void BleConnection::disconnect() {
    if (_pClient) _pClient->disconnect();
    _connected = false;
    _connecting = false;
}

void BleConnection::updateClient() {
    if (_doConnect) {
        Serial.println(">>> [BLE] _doConnect triggered. Stopping scan...");
        _doConnect = false;
        _connecting = true;
        
        NimBLEDevice::getScan()->stop();
        _scanning = false;
        delay(100); 
        
        if (_targetAddress.toString() == "00:00:00:00:00:00") {
            Serial.println(">>> [BLE] Error: Invalid Address.");
            _connecting = false;
        } else {
            Serial.printf(">>> [BLE] Connecting to %s...\n", _targetAddress.toString().c_str());

            if (!_pClient) {
                _pClient = NimBLEDevice::createClient();
                _pClient->setClientCallbacks(new ClientCallbacks());
            }

            if (_pClient->connect(_targetAddress)) {
                Serial.println(">>> [BLE] Connected! Discovering Services...");
                NimBLERemoteService* pSvc = _pClient->getService(BLE_SERVICE_UUID);
                if (pSvc) {
                    Serial.println(">>> [BLE] Service found. Discovering Characteristic...");
                    NimBLERemoteCharacteristic* pChr = pSvc->getCharacteristic(BLE_CHARACTERISTIC_UUID);
                    if (pChr) {
                        Serial.println(">>> [BLE] Characteristic found. Checking Notify...");
                        if (pChr->canNotify()) {
                            if (pChr->subscribe(true, internalNotifyCallback)) {
                                Serial.println(">>> [BLE] Subscribed! System READY.");
                                _connected = true;
                                _connecting = false;
                                _scanning = false;
                                return;
                            } else {
                                Serial.println(">>> [BLE] Subscription failed.");
                            }
                        } else {
                            Serial.println(">>> [BLE] Characteristic cannot notify.");
                        }
                    } else {
                        Serial.println(">>> [BLE] Characteristic not found.");
                    }
                } else {
                    Serial.println(">>> [BLE] Service not found.");
                }
            } else {
                Serial.println(">>> [BLE] Connection attempt failed.");
            }
        }
        
        if (_pClient) _pClient->disconnect();
        Serial.println(">>> [BLE] Failed to complete setup. Restarting scan...");
        _connecting = false;
        NimBLEDevice::getScan()->start(0, scanEndedCB, false);
        _scanning = true;
    }
    
    if (!_connected && !_scanning && !_connecting) {
        Serial.println(">>> [BLE] Scan starting (Async)...");
        if (NimBLEDevice::getScan()->start(0, scanEndedCB, false)) {
            _scanning = true;
        } else {
            Serial.println(">>> [BLE] Scan start failed.");
        }
    }
}
#endif
