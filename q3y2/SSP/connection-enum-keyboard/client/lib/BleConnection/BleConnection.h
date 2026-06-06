#ifndef BLE_CONNECTION_H
#define BLE_CONNECTION_H

#include <Arduino.h>
#include <cstring>
#include <stdint.h>

#ifndef BLE_SERVICE_UUID
#define BLE_SERVICE_UUID        "4fafc201-1fb5-459e-8fcc-c5c9c331914b"
#endif

#ifndef BLE_CHARACTERISTIC_UUID
#define BLE_CHARACTERISTIC_UUID "beb5483e-36e1-4688-b7f5-ea07361b26a8"
#endif

enum Gesture : uint8_t {
    GESTURE_COBRA   = 0,
    GESTURE_UP      = 1,
    GESTURE_DOWN    = 2,
    GESTURE_LEFT    = 3,
    GESTURE_RIGHT   = 4,
    GESTURE_NONE    = 5
};

class BleConnection {
public:
    BleConnection();

    static const char* getGestureName(Gesture gesture);
    static Gesture stringToGesture(const char* name);

    // Callbacks
    typedef void (*NotifyCallback)(uint8_t seq, uint32_t ts, Gesture gesture);
    typedef void (*DiscoveryCallback)(const char* name, const char* address, int rssi);

#if defined(ARDUINO_ARCH_NRF52840)
    bool initServer(const char* deviceName);
    void sendCommand(Gesture gesture);
    void sendCommand(const char* gestureName);
    bool isConnected();
    void updateServer();
    void disconnect();
#endif

#if defined(ARDUINO_ARCH_ESP32)
    bool initClient(NotifyCallback callback, DiscoveryCallback discovery = nullptr);
    void updateClient();
    bool isConnected();
    bool isScanning();
    bool isConnecting();
    void connect();
    void disconnect();
#endif

private:
    uint8_t _seqOut;
    static int packGesture(uint8_t* buf, uint8_t seq, uint32_t ts, Gesture gesture);
};

#endif
