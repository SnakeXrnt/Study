/*
 * Copyright (C) 2026 Kiril V. Strezikozin
 * SPDX-License-Identifier: Apache-2.0
 */

#include <Arduino.h>

#include <SPI.h>

#include "bus/arduino/sw_spi.hpp"
#include "bus/ibus.hpp"
#include "imu/lsm6dsl/spi.hpp"
#include "log/arduino/log.hpp"
#include "mdm/manager.hpp"

#ifndef SPI_DEFAULT_SCK
#define SPI_DEFAULT_SCK 13
#endif

#ifndef SPI_DEFAULT_MOSI
#define SPI_DEFAULT_MOSI 11
#endif

#ifndef SPI_DEFAULT_MISO
#define SPI_DEFAULT_MISO 12
#endif

#ifndef LSM6DSL_SPI_SPEED
#define LSM6DSL_SPI_SPEED 1000000
#endif

/* Nano 33 BLE Sense D7 pin */
#ifndef LSM6DSL_PIN_CS
#define LSM6DSL_PIN_CS 10
#endif

static imu::IIMU *g_lsm6dsl_imu = nullptr;

static constexpr std::size_t SENSOR_COUNT = 1;

static mdm::manager::Manager<SENSOR_COUNT> *g_sensor_manager = nullptr;
static mdm::manager::Manager<SENSOR_COUNT>::data_container_type g_data_container{};

static logger::arduino::Logger *g_logger = nullptr;

static unsigned long last_print_time = 0;

static inline void init_lsm6dsl_imu() {
    imu::lsm6dsl::config::IMUConfig imu_config;

    // auto *spi_bus = new bus::arduino::SPIBus(
    //     &SPI, SPISettings(LSM6DSL_SPI_SPEED, MSBFIRST, SPI_MODE0), LSM6DSL_PIN_CS, g_logger
    // );

    auto *spi_bus = new bus::arduino::SWSPIBus(
        LSM6DSL_PIN_CS,
        SPI_DEFAULT_SCK,
        SPI_DEFAULT_MISO,
        SPI_DEFAULT_MOSI,
        g_logger,
        LSM6DSL_SPI_SPEED,
        SPI_BITORDER_MSBFIRST,
        SPI_MODE0
    );
    spi_bus->begin();

    g_lsm6dsl_imu = new imu::lsm6dsl::imu::SPIIMU(imu_config, spi_bus, g_logger);
}

void setup() {
    Serial.begin(115200);
    while (!Serial) {
        delay(10);
    }
    delay(1000);

    g_logger = new logger::arduino::Logger();
    g_logger->info("Starting up...");

    /* Hardware SPI Setup */
    pinMode(LSM6DSL_PIN_CS, OUTPUT);
    digitalWrite(LSM6DSL_PIN_CS, HIGH); /* Deselect the sensor. */

    SPI.begin();

    init_lsm6dsl_imu();

    /* Instantiate manager with only the single LSM6DSL IMU */
    mdm::manager::Manager<SENSOR_COUNT>::sensor_mapping_container_type sensor_mappings{
        mdm::manager::SensorMapping{
            .imu  = g_lsm6dsl_imu,
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
        delay(1);
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
