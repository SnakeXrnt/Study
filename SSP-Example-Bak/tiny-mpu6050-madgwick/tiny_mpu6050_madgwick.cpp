/*
 * Copyright (C) 2026 Kiril V. Strezikozin
 * SPDX-License-Identifier: Apache-2.0
 */

#include <cmath>
#include <cstdint>
#include <cstdio>

#include <pico/stdio.h>
#include <pico/stdlib.h>
#include <pico/time.h>
#include <pico/types.h>

#include <hardware/gpio.h>
#include <hardware/i2c.h>
#include <hardware/spi.h>
#include <hardware/timer.h>

#include "bus/pico/i2c.hpp"
#include "bus/pico/spi.hpp"
#include "imu/iimu.hpp"
#include "imu/mpu6xxx/i2c.hpp"
#include "imu/mpu6xxx/spi.hpp"

#include "log/pico/log.hpp"

#include "fusion/madgwick/Fusion.h"
#include "fusion/madgwick/FusionAhrs.h"

#ifndef MPU6XXX_I2C_ENABLED
// #define MPU6XXX_I2C_ENABLED 1
#endif

#ifndef MPU6XXX_PIN_SDA
#define MPU6XXX_PIN_SDA 2
#endif

#ifndef MPU6XXX_PIN_SCL
#define MPU6XXX_PIN_SCL 3
#endif

#ifndef MPU6XXX_PIN_INT
#define MPU6XXX_PIN_INT 15
#endif

#ifndef MPU6XXX_I2C_INST
#define MPU6XXX_I2C_INST i2c1
#endif

#ifndef MPU6XXX_PIN_SCK
#define MPU6XXX_PIN_SCK 2
#endif

#ifndef MPU6XXX_PIN_MOSI
#define MPU6XXX_PIN_MOSI 3
#endif

#ifndef MPU6XXX_PIN_MISO
#define MPU6XXX_PIN_MISO 4
#endif

#ifndef MPU6XXX_PIN_CS
#define MPU6XXX_PIN_CS 5
#endif

#ifndef MPU6XXX_SPI_INST
#define MPU6XXX_SPI_INST spi0
#endif

#define SAMPLE_RATE_DELAY_COOL_FACTOR 2.0F
#define SAMPLE_RATE_FINAL_DELAY_US    (absolute_time_t)(10 * 1000)
#define SAMPLE_RATE_INITIAL_DELAY_US  (absolute_time_t)(10 * 1000)

static volatile bool g_imu_data_ready = false;

[[maybe_unused]] static void gpio_callback(uint gpio, uint32_t events) {
    if (gpio == MPU6XXX_PIN_INT && (events & GPIO_IRQ_EDGE_FALL)) { g_imu_data_ready = true; }
}

int main() {
    stdio_init_all();

    /* Instantiate the logger. */
    logger::pico::Logger logger;

/* I2C and GPIO setup for MPU6XXX. */
#ifdef MPU6XXX_I2C_ENABLED
    i2c_init(MPU6XXX_I2C_INST, 400 * 1000);
    gpio_init(MPU6XXX_PIN_SDA);
    gpio_init(MPU6XXX_PIN_SCL);
    gpio_set_function(MPU6XXX_PIN_SDA, GPIO_FUNC_I2C);
    gpio_set_function(MPU6XXX_PIN_SCL, GPIO_FUNC_I2C);
    gpio_pull_up(MPU6XXX_PIN_SDA);
    gpio_pull_up(MPU6XXX_PIN_SCL);
#else
    spi_init(MPU6XXX_SPI_INST, 500 * 1000);
    gpio_set_function(MPU6XXX_PIN_SCK, GPIO_FUNC_SPI);
    gpio_set_function(MPU6XXX_PIN_MOSI, GPIO_FUNC_SPI);
    gpio_set_function(MPU6XXX_PIN_MISO, GPIO_FUNC_SPI);

    gpio_init(MPU6XXX_PIN_CS);
    gpio_set_dir(MPU6XXX_PIN_CS, GPIO_OUT);
#endif

    sleep_ms(1000);

    gpio_init(MPU6XXX_PIN_INT);

/* Create an I2C bus instance and IMU instance. */
#ifdef MPU6XXX_I2C_ENABLED
    bus::pico::I2CBus i2c_bus(
        MPU6XXX_I2C_INST,
        static_cast<bus::pico::I2CBus::addr_type>(
            imu::mpu6xxx::config::IMUI2CAddress::MPU6XXX_AD0LOW
        ),
        &logger
    );

    imu::mpu6xxx::config::IMUConfig imu_config;
    imu_config.whoami_value                 = imu::mpu6xxx::config::IMUWHOAMIValue::MPU6500;
    imu_config.data_ready_interrupt_enabled = false; /* NOTE: polling is used. */

    imu::mpu6xxx::imu::I2CIMU imu(imu_config, &i2c_bus, &logger);
#else
    bus::pico::SPIBus spi_bus(MPU6XXX_SPI_INST, MPU6XXX_PIN_CS, &logger);

    imu::mpu6xxx::config::IMUConfig imu_config;
    imu_config.whoami_value                 = imu::mpu6xxx::config::IMUWHOAMIValue::MPU6500;
    imu_config.data_ready_interrupt_enabled = false; /* NOTE: polling is used. */

    imu::mpu6xxx::imu::SPIIMU imu(imu_config, &spi_bus, &logger);
#endif

    logger.info("Initializing MPU...");
    while (true) {
        auto init_res = imu.init();
        if (init_res) {
            logger.info("MPU Initialized successfully!");
            break;
        } else {
            logger.error("MPU init failed with error code: {}. Retrying...", init_res.error());
            sleep_ms(1000);
        }
    }

    FusionAhrs ahrs;

    /* Instantiate AHRS algorithm. */
    FusionAhrsInitialise(&ahrs);

    /* Set up the interrupt callback */
    // sleep_ms(50);
    // gpio_set_irq_enabled_with_callback(
    //     MPU6XXX_PIN_INT, GPIO_IRQ_EDGE_FALL, true, &gpio_callback
    // );

    absolute_time_t last_print_time       = 0;
    absolute_time_t last_tilt_update_time = 0;
    absolute_time_t delay                 = SAMPLE_RATE_INITIAL_DELAY_US;

    /* Main Super-Loop */
    while (true) {
        absolute_time_t now = time_us_32();

        /* Throttle reads. */
        if (now - last_tilt_update_time >= delay) {
            if (imu.get_is_data_ready().value_or(false)) {
                imu::IIMU::gyro_measurement_type gyro_data;
                imu::IIMU::accel_measurement_type accel_data;

                auto accel_res = imu.get_accel_data(accel_data);
                auto gyro_res  = imu.get_gyro_data(gyro_data);

                if (accel_res && gyro_res) {
                    const float deltaTime = (float)(now - last_tilt_update_time) / 1000000.0F;

                    /* Update AHRS algorithm. */
                    FusionAhrsUpdateNoMagnetometer(
                        &ahrs,
                        *((FusionVector *)gyro_data),
                        *((FusionVector *)accel_data),
                        deltaTime
                    );

                    last_tilt_update_time = now;

                    /* Update the cooling delay. */
                    if (delay > SAMPLE_RATE_FINAL_DELAY_US) {
                        delay = (absolute_time_t)((float)(delay) / SAMPLE_RATE_DELAY_COOL_FACTOR);
                    } else {
                        delay = SAMPLE_RATE_FINAL_DELAY_US;
                    }
                } else {
                    logger.error("Error reading sensor data");
                }
            }
        }

        /* Handle printing at 20Hz. */
        if (now - last_print_time > (absolute_time_t)(50 * 1000)) {
            const FusionEuler euler = FusionQuaternionToEuler(FusionAhrsGetQuaternion(&ahrs));

            logger.println(
                "{:.4f},{:.4f},{:.4f}", euler.angle.roll, euler.angle.pitch, euler.angle.yaw
            );
            last_print_time = now;
        }
    }

    i2c_deinit(MPU6XXX_I2C_INST);
    return 0;
}
