#ifndef BLE_CONNECTION_H
#define BLE_CONNECTION_H

#include <Arduino.h>
#include <cstring>
#include <stdint.h>

/**
 * --- Shared Protocol Constants ---
 * These can be overridden via build flags (-D) in platformio.ini
 */
#ifndef BLE_SERVICE_UUID
#define BLE_SERVICE_UUID        "4fafc201-1fb5-459e-8fcc-c5c9c331914b"
#endif

#ifndef BLE_CHARACTERISTIC_UUID
#define BLE_CHARACTERISTIC_UUID "beb5483e-36e1-4688-b7f5-ea07361b26a8"
#endif

#ifndef BLE_NUM_IMUS
#define BLE_NUM_IMUS            6
#endif

// Max MTU is usually around 200-247; 197 is a safe default for single-packet notifications
#define BLE_PACKET_SIZE         197

/**
 * @brief Structure representing a single IMU's raw motion data.
 * Size: 12 bytes (6 * int16_t)
 */
struct ImuSample {
    int16_t ax, ay, az; // Accelerometer X, Y, Z
    int16_t gx, gy, gz; // Gyroscope X, Y, Z
};

/**
 * @brief A unified class to handle BLE communication for both Server (Nano 33 BLE) 
 * and Client (ESP32) roles.
 */
class BleConnection {
public:
    BleConnection();

    // --- Server Role (Arduino Nano 33 BLE / nRF52) ---
#if defined(ARDUINO_ARCH_NRF52)
    /**
     * @brief Initializes the BLE radio and starts advertising as a Peripheral.
     * @param deviceName The name that will appear in scan results.
     * @return true if BLE initialized successfully.
     */
    bool initServer(const char* deviceName);

    /**
     * @brief Packs and sends a batch of IMU samples to the connected client.
     * @param samples Array of ImuSample structures.
     * @param count Number of IMUs in the array (must be <= BLE_NUM_IMUS).
     */
    void sendData(const ImuSample* samples, uint8_t count);

    /**
     * @brief Checks if a central device is currently connected.
     * @return true if connected.
     */
    bool isConnected();

    /**
     * @brief Periodic update function. Should be called in loop().
     * Restarts advertising automatically if the connection is lost.
     */
    void updateServer();
#endif

    // --- Client Role (ESP32 / NimBLE) ---
#if defined(ARDUINO_ARCH_ESP32)
    /**
     * @brief Function signature for the data notification callback.
     * @param seq Packet sequence number.
     * @param ts Timestamp in milliseconds from the server.
     * @param samples Pointer to the array of received IMU data.
     */
    typedef void (*NotifyCallback)(uint8_t seq, uint32_t ts, ImuSample* samples);
    
    /**
     * @brief Initializes the ESP32 BLE stack and starts scanning for the server.
     * @param callback Function to call whenever new sensor data arrives.
     * @return true if initialized successfully.
     */
    bool initClient(NotifyCallback callback);

    /**
     * @brief Background tasks for the client. Should be called in loop().
     * Handles connection logic and scan restarts.
     */
    void updateClient();

    /**
     * @return true if currently connected to the server.
     */
    bool isConnected();

    /**
     * @return true if currently scanning for a server.
     */
    bool isScanning();
#endif

private:
    uint8_t _seqOut;            // Tracks the outgoing packet index
    unsigned long _lastPacketMs; // Stores the last time a packet was sent/received

    /**
     * @brief Serializes IMU data into a byte buffer for transmission.
     * 
     * Packet Layout:
     * [0] - Sequence Byte (1 byte)
     * [1-4] - Timestamp (4 bytes, uint32_t)
     * [5-N] - IMU Data (12 bytes per sensor)
     * 
     * @param buf The output byte array.
     * @param seq The sequence number.
     * @param ts The timestamp in milliseconds.
     * @param imus Pointer to the source data array.
     * @param count Number of sensors to pack.
     * @return The total length of the packed buffer in bytes.
     */
    static int packBatch(uint8_t* buf, uint8_t seq, uint32_t ts, const ImuSample* imus, int count);
};

#endif
