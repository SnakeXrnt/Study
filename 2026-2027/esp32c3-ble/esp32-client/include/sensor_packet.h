#pragma once

#include <stdint.h>

// ---------------------------------------------------------------------------
// Wire format shared between this firmware and the laptop receiver.
//
// Any change here must be mirrored in laptop-receiver/ble_rx/protocol.py.
// ---------------------------------------------------------------------------

// Custom 128-bit UUIDs. They are random: BLE reserves the short 16-bit UUIDs
// for standardised services (heart rate, battery, ...), so anything vendor
// specific has to carry its own 128-bit value.
#define BLE_SENSOR_SERVICE_UUID "cb187d50-b25c-4984-a9f7-70a65d837cfe"
#define BLE_SENSOR_DATA_UUID    "cb187d51-b25c-4984-a9f7-70a65d837cfe"

// Advertised name. The receiver matches on the service UUID, not on this, but
// it makes the device recognisable in nRF Connect / bluetoothctl.
#define BLE_SENSOR_DEVICE_NAME "ESP32C3-SENSOR"

#pragma pack(push, 1)
struct SensorPacket {
    uint32_t t_us;  // micros() at sample time
    uint32_t idx;   // sample counter, lets the receiver spot dropped packets
    float    gx, gy, gz;
    float    ax, ay, az;
    float    qw, qx, qy, qz;
};
#pragma pack(pop)

// 4 + 4 + (10 * 4) = 48 bytes. The ESP32-C3 is little-endian with IEEE-754
// floats, which is exactly what Python's struct "<II10f" decodes.
static_assert(sizeof(SensorPacket) == 48, "SensorPacket must stay 48 bytes");
