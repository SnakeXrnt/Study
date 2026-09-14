#pragma once

#include <NimBLEDevice.h>
#include <stdint.h>

#include "sensor_packet.h"

// A BLE peripheral that advertises one service with one notify characteristic
// and streams SensorPacket structs to whoever subscribes.
//
// In BLE terms this is the *server* (it owns the data) and the laptop is the
// *client*. The naming is the opposite of the usual network convention.
class BleSensorServer : public NimBLEServerCallbacks, public NimBLECharacteristicCallbacks {
   public:
    void begin(const char* deviceName = BLE_SENSOR_DEVICE_NAME);

    // Signature kept flat on purpose so call sites read like the sensor maths.
    bool sendSensorData(uint32_t t_us, uint32_t idx,
                        float gx, float gy, float gz,
                        float ax, float ay, float az,
                        float qw, float qx, float qy, float qz);

    // Call from loop(). Drops a client that connects but never subscribes,
    // otherwise a crashed receiver leaves the link up and the board stops
    // advertising, making it look dead to everyone else.
    void tick();

    bool isConnected() const { return m_connected; }

    // True once a client has written the notify bit on the CCCD. Sending before
    // that just burns CPU, so the main loop gates on it.
    bool isStreaming() const { return m_connected && m_subscribed; }

    uint16_t mtu() const { return m_mtu; }
    uint32_t sent() const { return m_sent; }
    uint32_t dropped() const { return m_dropped; }

   private:
    // NimBLEServerCallbacks
    void onConnect(NimBLEServer* server, NimBLEConnInfo& connInfo) override;
    void onDisconnect(NimBLEServer* server, NimBLEConnInfo& connInfo, int reason) override;
    void onMTUChange(uint16_t mtu, NimBLEConnInfo& connInfo) override;

    // NimBLECharacteristicCallbacks
    void onSubscribe(NimBLECharacteristic* characteristic, NimBLEConnInfo& connInfo,
                     uint16_t subValue) override;

    NimBLEServer*         m_server = nullptr;
    NimBLECharacteristic* m_data   = nullptr;

    static constexpr uint32_t IDLE_DISCONNECT_MS = 15000;

    volatile uint16_t m_connHandle  = 0;
    volatile uint32_t m_connectedAt = 0;
    volatile bool     m_connected  = false;
    volatile bool     m_subscribed = false;
    volatile uint16_t m_mtu        = 23;

    uint32_t m_sent    = 0;
    uint32_t m_dropped = 0;
};

extern BleSensorServer g_ble;
