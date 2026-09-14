#include "ble_sensor_server.h"

#include <Arduino.h>

void BleSensorServer::begin(const char* deviceName) {
    NimBLEDevice::init(deviceName);

    // Ask for a larger ATT MTU. The default of 23 bytes leaves only 20 bytes of
    // payload per notification, which would truncate our 48-byte packet. The
    // central has the final say; we check the negotiated value in onMTUChange.
    NimBLEDevice::setMTU(247);

    m_server = NimBLEDevice::createServer();
    m_server->setCallbacks(this);
    m_server->advertiseOnDisconnect(true);

    NimBLEService* service = m_server->createService(BLE_SENSOR_SERVICE_UUID);

    m_data = service->createCharacteristic(
        BLE_SENSOR_DATA_UUID,
        NIMBLE_PROPERTY::READ | NIMBLE_PROPERTY::NOTIFY,
        sizeof(SensorPacket));
    m_data->setCallbacks(this);

    service->start();

    NimBLEAdvertising* advertising = NimBLEDevice::getAdvertising();
    advertising->setName(deviceName);
    // Advertising the service UUID is what lets the receiver find us without
    // relying on the name, which clones and OS caches like to mangle.
    advertising->addServiceUUID(service->getUUID());
    advertising->enableScanResponse(true);
    advertising->start();

    Serial.printf("[ble] advertising as \"%s\"\n", deviceName);
    Serial.printf("[ble] service %s\n", BLE_SENSOR_SERVICE_UUID);
    Serial.printf("[ble] data    %s (%u bytes/packet)\n",
                  BLE_SENSOR_DATA_UUID, (unsigned)sizeof(SensorPacket));
    Serial.printf("[ble] mac     %s\n", NimBLEDevice::getAddress().toString().c_str());
}

bool BleSensorServer::sendSensorData(uint32_t t_us, uint32_t idx,
                                     float gx, float gy, float gz,
                                     float ax, float ay, float az,
                                     float qw, float qx, float qy, float qz) {
    if (!isStreaming()) {
        return false;
    }

    SensorPacket packet;
    packet.t_us = t_us;
    packet.idx  = idx;
    packet.gx = gx;  packet.gy = gy;  packet.gz = gz;
    packet.ax = ax;  packet.ay = ay;  packet.az = az;
    packet.qw = qw;  packet.qx = qx;  packet.qy = qy;  packet.qz = qz;

    // notify() returns false when the controller's outgoing buffers are full,
    // i.e. we are producing faster than the connection interval can drain.
    const bool ok = m_data->notify(reinterpret_cast<const uint8_t*>(&packet), sizeof(packet));
    if (ok) {
        m_sent++;
    } else {
        m_dropped++;
    }
    return ok;
}

void BleSensorServer::tick() {
    if (!m_connected || m_subscribed) {
        return;
    }
    if (millis() - m_connectedAt < IDLE_DISCONNECT_MS) {
        return;
    }
    Serial.printf("[ble] client idle for %lus without subscribing, dropping it\n",
                  (unsigned long)(IDLE_DISCONNECT_MS / 1000));
    m_server->disconnect(m_connHandle);
    m_connectedAt = millis();  // do not spam if the disconnect is slow
}

void BleSensorServer::onConnect(NimBLEServer* server, NimBLEConnInfo& connInfo) {
    m_connected   = true;
    m_connHandle  = connInfo.getConnHandle();
    m_connectedAt = millis();
    m_mtu         = connInfo.getMTU();

    // Pull the connection interval down to 15-30 ms so there are enough radio
    // events per second to carry our sample rate. Units are 1.25 ms.
    server->updateConnParams(connInfo.getConnHandle(), 12, 24, 0, 400);

    Serial.printf("[ble] connected to %s\n", connInfo.getAddress().toString().c_str());
}

void BleSensorServer::onDisconnect(NimBLEServer* server, NimBLEConnInfo& connInfo, int reason) {
    m_connected  = false;
    m_subscribed = false;
    m_mtu        = 23;
    Serial.printf("[ble] disconnected (reason 0x%02x), advertising again\n", reason);
}

void BleSensorServer::onMTUChange(uint16_t mtu, NimBLEConnInfo& connInfo) {
    m_mtu = mtu;
    Serial.printf("[ble] mtu negotiated: %u (payload %u bytes)\n", mtu, (unsigned)(mtu - 3));
    if (mtu - 3 < (int)sizeof(SensorPacket)) {
        Serial.printf("[ble] WARNING: mtu too small for a %u byte packet\n",
                      (unsigned)sizeof(SensorPacket));
    }
}

void BleSensorServer::onSubscribe(NimBLECharacteristic* characteristic,
                                  NimBLEConnInfo& connInfo, uint16_t subValue) {
    // subValue bit 0 = notifications, bit 1 = indications.
    m_subscribed = (subValue & 0x0001) != 0;
    Serial.printf("[ble] client %s notifications\n", m_subscribed ? "subscribed to" : "unsubscribed from");
}
