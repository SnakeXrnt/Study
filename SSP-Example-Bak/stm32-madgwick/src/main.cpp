/*
 * Copyright (C) 2026 Kiril V. Strezikozin
 * SPDX-License-Identifier: Apache-2.0
 */

#include <Arduino.h>
#include <SPI.h>
#include <Wire.h>

#include <bit>

#include "bus/arduino/i2c.hpp"
#include "bus/arduino/spi.hpp"
#include "bus/ibus.hpp"
#include "imu/lsm6dsl/i2c.hpp"
#include "imu/lsm6dsl/spi.hpp"
#include "log/arduino/log.hpp"
#include "mag/lis3mdl/i2c.hpp"

#include "fusion/madgwick/Fusion.h"
#include "fusion/madgwick/FusionAhrs.h"

#ifndef LSM6DSL_I2C_ENABLED
#define LSM6DSL_I2C_ENABLED 1
#endif

#ifdef LSM6DSL_I2C_ENABLED
#ifndef LSM6DSL_I2C_SPEED
#define LSM6DSL_I2C_SPEED 400000
#endif
#else
#ifndef LSM6DSL_PIN_CS
#define LSM6DSL_PIN_CS 10
#endif

#ifndef LSM6DSL_SPI_SPEED
#define LSM6DSL_SPI_SPEED 1000000
#endif
#endif

#define SAMPLE_RATE_DELAY_COOL_FACTOR 2.0F
#define SAMPLE_RATE_FINAL_DELAY_US    (10000UL) /* 10ms */
#define SAMPLE_RATE_INITIAL_DELAY_US  (10000UL)

static bus::IBus *g_imu_bus = nullptr;
static bus::IBus *g_mag_bus = nullptr;
static imu::IIMU *g_imu     = nullptr;
static mag::IMag *g_mag     = nullptr;
static FusionAhrs g_ahrs;
static logger::arduino::Logger *g_logger = nullptr;

static unsigned long last_print_time       = 0;
static unsigned long last_tilt_update_time = 0;
static unsigned long delay_us              = SAMPLE_RATE_INITIAL_DELAY_US;

static float velocity[3] = {0.0F, 0.0F, 0.0F};
static float position[3] = {0.0F, 0.0F, 0.0F};

#define GRAVITY_MSS 9.80665F

void setup() {
    Serial.begin(115200);
    while (!Serial) {
        delay(10);
    }
    delay(1000);

    g_logger = new logger::arduino::Logger();

    imu::lsm6dsl::config::IMUConfig imu_config;

#ifdef LSM6DSL_I2C_ENABLED
    /* Hardware I2C Setup */
    /* Use internal I2C pins instead of default ones routed to external headers. */
    Wire.setSDA(PB11);
    Wire.setSCL(PB10);
    Wire.setClock(LSM6DSL_I2C_SPEED);
    Wire.begin();

    /* Create the Arduino I2C bus wrapper */
    auto *i2c_bus = new bus::arduino::I2CBus(
        &Wire,
        static_cast<bus::arduino::I2CBus::addr_type>(
            imu::lsm6dsl::config::IMUI2CAddress::LSM6DSL_SA0_LOW
        ),
        g_logger

    );
    g_imu_bus = i2c_bus;

    /* Instantiate I2C IMU */
    g_imu = new imu::lsm6dsl::imu::I2CIMU(imu_config, i2c_bus, g_logger);

#else
    /* Hardware SPI Setup */
    pinMode(LSM6DSL_PIN_CS, OUTPUT);
    digitalWrite(LSM6DSL_PIN_CS, HIGH);
    SPI.begin();

    /* Create the Arduino SPI bus wrapper */
    auto *spi_bus = new bus::arduino::SPIBus(
        &SPI, SPISettings(LSM6DSL_SPI_SPEED, MSBFIRST, SPI_MODE3), LSM6DSL_PIN_CS, g_logger
    );
    g_imu_bus = spi_bus;

    /* Instantiate SPI IMU */
    g_imu = new imu::lsm6dsl::imu::SPIIMU(imu_config, spi_bus, g_logger);
#endif

    g_logger->info("Initializing LSM6DSL...");
    while (true) {
        auto init_res = g_imu->init();
        if (init_res) {
            g_logger->info("LSM6DSL Initialized successfully!");
            break;
        } else {
            g_logger->error(
                "LSM6DSL init failed with error code: {}. Retrying...", init_res.error()
            );
            delay(1000);
        }
    }

#ifdef LSM6DSL_I2C_ENABLED
    mag::lis3mdl::config::MagConfig mag_config;

    /* Create the Arduino I2C bus wrapper for the magnetometer. */
    auto *i2c_bus_mag = new bus::arduino::I2CBus(
        &Wire,
        static_cast<bus::arduino::I2CBus::addr_type>(
            mag::lis3mdl::config::MagI2CAddress::LIS3MDL_SA1_HIGH
        ),
        g_logger
    );
    g_mag_bus = i2c_bus_mag;

    /* Instantiate I2C magnetometer. */
    g_mag = new mag::lis3mdl::mag::I2CMag(mag_config, i2c_bus_mag, g_logger);

    g_logger->info("Initializing LIS3MDL...");
    while (true) {
        auto init_res = g_mag->init();
        if (init_res) {
            g_logger->info("LIS3MDL Initialized successfully!");
            break;
        } else {
            g_logger->error(
                "LIS3MDL init failed with error code: {}. Retrying...", init_res.error()
            );
            delay(1000);
        }
    }
#endif

    /* Instantiate AHRS algorithm. */
    FusionAhrsInitialise(&g_ahrs);
}

void loop() {
    unsigned long now = micros();

    /* Throttle reads. */
    if (now - last_tilt_update_time >= delay_us) {
        if (g_imu->get_is_data_ready().value_or(false)
            && g_mag->get_is_data_ready().value_or(false)) {
            imu::IIMU::gyro_measurement_type gyro_data;
            imu::IIMU::accel_measurement_type accel_data;
            mag::IMag::mag_measurement_type mag_data;

            auto accel_res = g_imu->get_accel_data(accel_data);
            auto gyro_res  = g_imu->get_gyro_data(gyro_data);
            auto mag_res   = g_mag->get_mag_data(mag_data);

            if (accel_res && gyro_res && mag_res) {
                const float deltaTime = (float)(now - last_tilt_update_time) / 1000000.0F;

                /* Update AHRS algorithm. */
                FusionAhrsUpdate(
                    &g_ahrs,
                    std::bit_cast<FusionVector>(gyro_data),
                    std::bit_cast<FusionVector>(accel_data),
                    std::bit_cast<FusionVector>(mag_data),
                    deltaTime
                );

                /* Extract Earth-frame acceleration and convert to m/s^2 */
                const FusionVector earth = FusionAhrsGetEarthAcceleration(&g_ahrs);
                float ax                 = earth.axis.x * GRAVITY_MSS;
                float ay                 = earth.axis.y * GRAVITY_MSS;
                float az                 = earth.axis.z * GRAVITY_MSS;

                /* Ignore tiny noise. */
                if (abs(ax) < 0.005F) ax = 0.0F;
                if (abs(ay) < 0.005F) ay = 0.0F;
                if (abs(az) < 0.01F) az = 0.0F;

                /* Acceleration to Velocity. */
                velocity[0] += ax * deltaTime;
                velocity[1] += ay * deltaTime;
                velocity[2] += az * deltaTime;

                /* Help the insane drift ta bit by dragging the velocity
                 * values back towards zero. */
                velocity[0] *= 0.98F;
                velocity[1] *= 0.98F;
                velocity[2] *= 0.98F;

                /* Velocity to Position. */
                position[0] += velocity[0] * deltaTime;
                position[1] += velocity[1] * deltaTime;
                position[2] += velocity[2] * deltaTime;

                position[0] *= 0.99F;
                position[1] *= 0.99F;
                position[2] *= 0.99F;

                last_tilt_update_time = now;

                /* Update the cooling delay. */
                if (delay_us > SAMPLE_RATE_FINAL_DELAY_US) {
                    delay_us = (unsigned long)((float)(delay_us) / SAMPLE_RATE_DELAY_COOL_FACTOR);
                } else {
                    delay_us = SAMPLE_RATE_FINAL_DELAY_US;
                }
            } else {
                g_logger->error("Error reading sensor data");
            }
        }
    }

    /* Handle printing at 20Hz. */
    if (now - last_print_time > 50000UL) {
        const FusionEuler euler = FusionQuaternionToEuler(FusionAhrsGetQuaternion(&g_ahrs));

        g_logger->println(
            "Orientation: {:.4f}, {:.4f}, {:.4f} | Position: {:.4f}, {:.4f}, {:.4f}",
            euler.angle.roll,
            euler.angle.pitch,
            euler.angle.yaw,
            position[0],
            position[1],
            position[2]
        );

        last_print_time = now;
    }
}
