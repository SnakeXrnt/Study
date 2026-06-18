/*
 * Copyright (C) 2026 Kiril V. Strezikozin
 * SPDX-License-Identifier: Apache-2.0
 */

#include <Arduino.h>

#include <Wire.h>

#include "bus/arduino/i2c.hpp"
#include "bus/ibus.hpp"
#include "imu/bmi270/i2c.hpp"
#include "log/arduino/log.hpp"
#include "mdm/manager.hpp"

#ifndef BMI270_I2C_SPEED
#define BMI270_I2C_SPEED 400000
#endif

/* Nano 33 BLE Sense D7 pin */
#ifndef LSM6DSL_PIN_CS
#define LSM6DSL_PIN_CS 10
#endif

static TwoWire *g_bmi270_i2c_wire = nullptr;

static imu::IIMU *g_bmi720_imu = nullptr;

static constexpr std::size_t SENSOR_COUNT = 1;

static mdm::manager::Manager<SENSOR_COUNT> *g_sensor_manager = nullptr;
static mdm::manager::Manager<SENSOR_COUNT>::data_container_type g_data_container{};

static logger::arduino::Logger *g_logger = nullptr;

static unsigned long last_print_time = 0;

static inline void init_bmi270_imu() {
    imu::bmi270::config::IMUConfig imu_config;

    auto *i2c_bus = new bus::arduino::I2CBus(
        g_bmi270_i2c_wire,
        static_cast<bus::arduino::I2CBus::addr_type>(
            imu::bmi270::config::IMUI2CAddress::BMI270_SDO_LOW
        ),
        g_logger
    );

    g_bmi720_imu = new imu::bmi270::imu::I2CIMU(imu_config, i2c_bus, g_logger);
}

void setup() {
    Serial.begin(115200);
    while (!Serial) {
        delay(10);
    }
    delay(1000);

    g_logger = new logger::arduino::Logger();
    g_logger->info("Starting up...");

    Wire1.begin();
    Wire1.setClock(BMI270_I2C_SPEED);

    g_bmi270_i2c_wire = &Wire1;

    init_bmi270_imu();

    /* Instantiate manager with only the single LSM6DSL IMU */
    mdm::manager::Manager<SENSOR_COUNT>::sensor_mapping_container_type sensor_mappings{
        mdm::manager::SensorMapping{
            .imu  = g_bmi720_imu,
            .mag  = nullptr,
            .type = mdm::manager::SensorMappingType::IMU_6DOF_NO_MAG
        }
    };

    g_sensor_manager = new mdm::manager::Manager<SENSOR_COUNT>(
        std::move(sensor_mappings), g_logger
    );

    auto res = g_sensor_manager->init();
    if (!res) {
        g_logger->error("Sensor manager init failed with error code: {}", res.error());
        while (true) {
            g_logger->error("Sensor manager init failed with error code: {}", res.error());
            delay(1000);
        }
    }
}

void loop() {
    unsigned long now = millis();

    /* Poll for data */
    const auto data_ready_res = g_sensor_manager->get_is_all_data_ready();
    if (!data_ready_res) {
        g_logger->error("Error checking if sensor data is ready: {}", data_ready_res.error());
        delay(1000);
        return;
    } else if (!data_ready_res.value()) {
        // delay(1);
        return; /* Data not ready yet */
    }

    const auto read_res = g_sensor_manager->read_all_sensors(g_data_container);
    if (!read_res) {
        g_logger->error("Error reading sensor data: {}", read_res.error());
        delay(1000);
        return;
    }

    /* Handle printing at ~20Hz (every 50ms) */
    if (now - last_print_time > 50UL) {
        g_logger->println(
            "Accel: {:.4f}, {:.4f}, {:.4f} | Gyro: {:.4f}, {:.4f}, {:.4f}",
            g_data_container[0].accel.x(),
            g_data_container[0].accel.y(),
            g_data_container[0].accel.z(),
            g_data_container[0].gyro.x(),
            g_data_container[0].gyro.y(),
            g_data_container[0].gyro.z()
        );

        last_print_time = now;
    }
}
