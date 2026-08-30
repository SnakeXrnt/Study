# BleConnection Library

A unified BLE communication bridge between **Arduino Nano 33 BLE (Server)** and **ESP32 (Client)**, optimized for high-speed IMU data transmission.

## 1. Setup

### PlatformIO
Add the library path to your `platformio.ini`:
```ini
lib_extra_dirs = ../library
```

### Shared Data Structure
Both sides use the `ImuSample` struct (12 bytes):
```cpp
struct ImuSample {
    int16_t ax, ay, az; // Accelerometer
    int16_t gx, gy, gz; // Gyroscope
};
```

---

## 2. Server Side (Arduino Nano 33 BLE)

The server acts as a **Peripheral**. It reads sensors, packs them into a batch, and "Notifies" the client.

### Initialization
```cpp
#include <BleConnection.h>
BleConnection ble;

void setup() {
    ble.initServer("My_Sensor_Node");
}
```

### Packing & Sending
The library handles packing automatically when you call `sendData`. It adds a 1-byte sequence number and a 4-byte timestamp before your data.

```cpp
void loop() {
    ble.updateServer(); // Handles reconnection logic

    if (ble.isConnected()) {
        ImuSample batch[BLE_NUM_IMUS];
        
        // --- Step 1: Pack your data into the array ---
        for(int i=0; i < BLE_NUM_IMUS; i++) {
            batch[i].ax = readAccelX(i); 
            // ... fill other fields
        }

        // --- Step 2: Send the whole batch ---
        // This sends: [seq:1][timestamp:4][data:72] = 77 bytes total
        ble.sendData(batch, BLE_NUM_IMUS);
    }
}
```

---

## 3. Client Side (ESP32)

The client acts as a **Central**. It scans for the server and receives data via a callback function.

### Initialization
```cpp
void onData(uint8_t seq, uint32_t ts, ImuSample* samples) {
    // This is called automatically when data arrives
}

void setup() {
    ble.initClient(onData);
}
```

### Receiving & Unpacking
When `onData` is triggered, the library has already "unpacked" the raw bytes back into usable variables.

```cpp
// 1. Storage variable
ImuSample latestReadings[BLE_NUM_IMUS];

void onData(uint8_t seq, uint32_t ts, ImuSample* samples) {
    // 2. Unpack the pointer into your local storage
    memcpy(latestReadings, samples, sizeof(ImuSample) * BLE_NUM_IMUS);
    
    Serial.printf("Received Packet #%d sent at %d ms\n", seq, ts);
}

void loop() {
    ble.updateClient(); // Essential for background BLE tasks
    
    // Use latestReadings[0].ax here...
}
```

---

## 4. Protocol Details (The "Wire" Format)

The library packs data into a single BLE notification of **77 bytes** (default for 6 IMUs):

| Offset | Size | Name | Description |
| :--- | :--- | :--- | :--- |
| 0 | 1 | Sequence | 0-255 counter (for drop detection) |
| 1 | 4 | Timestamp | `millis()` from the Server at time of packing |
| 5 | 12 | IMU 0 | `ax, ay, az, gx, gy, gz` (int16_t each) |
| 17 | 12 | IMU 1 | ... |
| ... | ... | ... | ... |
| 65 | 12 | IMU 5 | Final sensor data |

---

## 5. Custom Configuration

You can change the UUIDs or the number of IMUs without touching the library code by using build flags in your `platformio.ini`:

```ini
build_flags = 
    -D BLE_NUM_IMUS=10
    -D BLE_SERVICE_UUID=\"your-uuid-here\"
```
