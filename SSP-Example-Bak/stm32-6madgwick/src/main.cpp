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
#include "cal/calibration.hpp"
#include "imu/lsm6dsl/i2c.hpp"
#include "imu/lsm6dsl/spi.hpp"
#include "imu/mpu6xxx/i2c.hpp"
#include "imu/mpu6xxx/spi.hpp"
#include "log/arduino/log.hpp"
#include "mag/lis3mdl/i2c.hpp"
#include "mdm/manager.hpp"

#include "fusion/madgwick/Fusion.h"
#include "wiring_constants.h"

#ifndef LSM6DSL_I2C_SPEED
#define LSM6DSL_I2C_SPEED 400000
#endif

#ifndef LSM6DSL_PIN_SDA
#define LSM6DSL_PIN_SDA PB11
#endif

#ifndef LSM6DSL_PIN_SCL
#define LSM6DSL_PIN_SCL PB10
#endif

#ifndef LIS3MDL_I2C_SPEED
#define LIS3MDL_I2C_SPEED 400000
#endif

#ifndef LIS3MDL_PIN_SDA
#define LIS3MDL_PIN_SDA PB11
#endif

#ifndef LIS3MDL_PIN_SCL
#define LIS3MDL_PIN_SCL PB10
#endif

#ifndef MPU6XXX_SPI_SPEED
#define MPU6XXX_SPI_SPEED 400000
#endif

#ifndef MPU6XXX_PIN_MOSI
#define MPU6XXX_PIN_MOSI PD4
#endif

#ifndef MPU6XXX_PIN_MISO
#define MPU6XXX_PIN_MISO PD3
#endif

#ifndef MPU6XXX_PIN_SCK
#define MPU6XXX_PIN_SCK PD1
#endif

#ifndef MPU6XXX_SPI_INST
#define MPU6XXX_SPI_INST SPI2
#endif

#ifndef MPU6XXX_1_PIN_CS
#define MPU6XXX_1_PIN_CS PD0
#endif

#ifndef MPU6XXX_2_PIN_CS
#define MPU6XXX_2_PIN_CS PD2
#endif

#ifndef MPU6XXX_3_PIN_SDA
#define MPU6XXX_3_PIN_SDA PB9
#endif

#ifndef MPU6XXX_3_PIN_SCL
#define MPU6XXX_3_PIN_SCL PB8
#endif

#ifndef MPU6XXX_3_I2C_SPEED
#define MPU6XXX_3_I2C_SPEED 400000
#endif

#define SAMPLE_RATE_DELAY_COOL_FACTOR 2.0F
#define SAMPLE_RATE_FINAL_DELAY_US    (10000UL) /* 10ms */
#define SAMPLE_RATE_INITIAL_DELAY_US  (10000UL)

static SPIClass *g_mpu6xxx_spi       = nullptr;
static TwoWire *g_lsm6dsl_i2c_wire   = nullptr;
static TwoWire *g_lis3dml_i2c_wire   = nullptr;
static TwoWire *g_mpu6xxx_3_i2c_wire = nullptr;
static imu::IIMU *g_lsm6dsl_imu      = nullptr;
static mag::IMag *g_lis3dml_mag      = nullptr;
static imu::IIMU *g_mpu6xxx_1_imu    = nullptr;
static imu::IIMU *g_mpu6xxx_2_imu    = nullptr;
static imu::IIMU *g_mpu6xxx_3_imu    = nullptr;

static constexpr std::size_t SENSOR_COUNT = 3;

static mdm::manager::Manager<SENSOR_COUNT> *g_sensor_manager = nullptr;

static mdm::manager::Manager<SENSOR_COUNT>::data_container_type g_data_container{};

static cal::Calibration<SENSOR_COUNT, cal::DefaultConfigTraits, cal::DefaultCooldownSamples>
    *g_calibration = nullptr;

static FusionAhrs g_lsm6dsl_ahrs;
static FusionAhrs g_mpu6xxx_1_ahrs;
static FusionAhrs g_mpu6xxx_2_ahrs;
static FusionAhrs g_mpu6xxx_3_ahrs;

static FusionBias g_lsm6dsl_bias;
static FusionBias g_mpu6xxx_1_bias;
static FusionBias g_mpu6xxx_2_bias;
static FusionBias g_mpu6xxx_3_bias;

static logger::arduino::Logger *g_logger = nullptr;

static unsigned long last_print_time       = 0;
static unsigned long last_tilt_update_time = 0;
static unsigned long delay_us              = SAMPLE_RATE_INITIAL_DELAY_US;

static bool g_is_calibrated = false;
static std::array<cal::SensorCalibrationResult, SENSOR_COUNT> g_calibration_results{};

static inline void init_lis3dml_mag() {
    mag::lis3mdl::config::MagConfig mag_config;

    auto i2c_bus = new bus::arduino::I2CBus(
        g_lis3dml_i2c_wire,
        static_cast<bus::arduino::I2CBus::addr_type>(
            mag::lis3mdl::config::MagI2CAddress::LIS3MDL_SA1_HIGH
        ),
        g_logger
    );

    g_lis3dml_mag = new mag::lis3mdl::mag::I2CMag(mag_config, i2c_bus, g_logger);
}

static inline void init_lsm6dsl_imu() {
    imu::lsm6dsl::config::IMUConfig imu_config;

    auto i2c_bus = new bus::arduino::I2CBus(
        g_lsm6dsl_i2c_wire,
        static_cast<bus::arduino::I2CBus::addr_type>(
            imu::lsm6dsl::config::IMUI2CAddress::LSM6DSL_SA0_LOW
        ),
        g_logger

    );

    g_lsm6dsl_imu = new imu::lsm6dsl::imu::I2CIMU(imu_config, i2c_bus, g_logger);
}

static inline void init_mpu6xxx_1_imu() {
    imu::mpu6xxx::config::IMUConfig imu_config;
    imu_config.whoami_value = imu::mpu6xxx::config::IMUWHOAMIValue::MPU6500;

    auto *spi_bus = new bus::arduino::SPIBus(
        g_mpu6xxx_spi,
        SPISettings(MPU6XXX_SPI_SPEED, MSBFIRST, SPI_MODE3),
        MPU6XXX_1_PIN_CS,
        g_logger
    );

    g_mpu6xxx_1_imu = new imu::mpu6xxx::imu::SPIIMU(imu_config, spi_bus, g_logger);
}

static inline void init_mpu6xxx_2_imu() {
    imu::mpu6xxx::config::IMUConfig imu_config;
    imu_config.whoami_value = imu::mpu6xxx::config::IMUWHOAMIValue::MPU6500;

    auto *spi_bus = new bus::arduino::SPIBus(
        g_mpu6xxx_spi,
        SPISettings(MPU6XXX_SPI_SPEED, MSBFIRST, SPI_MODE3),
        MPU6XXX_2_PIN_CS,
        g_logger
    );

    g_mpu6xxx_2_imu = new imu::mpu6xxx::imu::SPIIMU(imu_config, spi_bus, g_logger);
}

static inline void init_mpu6xxx_3_imu() {
    imu::mpu6xxx::config::IMUConfig imu_config;
    imu_config.whoami_value = imu::mpu6xxx::config::IMUWHOAMIValue::MPU6050;

    auto *i2c_bus = new bus::arduino::I2CBus(
        g_mpu6xxx_3_i2c_wire,
        static_cast<bus::arduino::I2CBus::addr_type>(
            imu::mpu6xxx::config::IMUI2CAddress::MPU6XXX_AD0LOW
        ),
        g_logger
    );

    g_mpu6xxx_3_imu = new imu::mpu6xxx::imu::I2CIMU(imu_config, i2c_bus, g_logger);
}

static inline void init_sensors() {
    init_lsm6dsl_imu();
    init_lis3dml_mag();
    init_mpu6xxx_1_imu();
    init_mpu6xxx_2_imu();
    init_mpu6xxx_3_imu();
}

void setup() {
    Serial.begin(115200);
    while (!Serial) {
        delay(10);
    }
    delay(1000);

    g_logger = new logger::arduino::Logger();

    /* Hardware I2C Setup */
    /* Use internal I2C pins instead of default ones routed to external headers. */
    TwoWire *Wire1 = new TwoWire(LSM6DSL_PIN_SDA, LSM6DSL_PIN_SCL);
    Wire1->setClock(LSM6DSL_I2C_SPEED);
    Wire1->begin();
    TwoWire *Wire2 = new TwoWire(MPU6XXX_3_PIN_SDA, MPU6XXX_3_PIN_SCL);
    Wire2->setClock(MPU6XXX_3_I2C_SPEED);
    Wire2->begin();

    g_lis3dml_i2c_wire   = Wire1;
    g_lsm6dsl_i2c_wire   = Wire1;
    g_mpu6xxx_3_i2c_wire = Wire2;

    /* Hardware SPI Setup */
    pinMode(MPU6XXX_1_PIN_CS, OUTPUT);
    digitalWrite(MPU6XXX_1_PIN_CS, HIGH); /* Deselect the sensor. */
    pinMode(MPU6XXX_2_PIN_CS, OUTPUT);
    digitalWrite(MPU6XXX_2_PIN_CS, HIGH);
    g_mpu6xxx_spi = new SPIClass(MPU6XXX_PIN_MOSI, MPU6XXX_PIN_MISO, MPU6XXX_PIN_SCK);
    g_mpu6xxx_spi->begin();

    init_sensors();

    /* Instantiate AHRS algorithm. */
    constexpr std::size_t sample_rate_hz = 100; /* 100Hz */

    const FusionAhrsSettings g_common_ahrs_settings = {
        .convention            = FusionConventionNwu,
        .gain                  = 0.1f,
        .gyroscopeRange        = 0.0f,
        .accelerationRejection = 10.0f,
        .magneticRejection     = 10.0f,
        .recoveryTriggerPeriod = 5 * sample_rate_hz, /* 5 seconds. */
    };

    FusionAhrsInitialise(&g_lsm6dsl_ahrs);
    auto g_lsm6dsl_ahrs_settings           = g_common_ahrs_settings;
    g_lsm6dsl_ahrs_settings.gyroscopeRange = 1000.0f;
    FusionAhrsSetSettings(&g_lsm6dsl_ahrs, &g_lsm6dsl_ahrs_settings);

    FusionAhrsInitialise(&g_mpu6xxx_1_ahrs);
    auto g_mpu6xxx_1_ahrs_settings           = g_common_ahrs_settings;
    g_mpu6xxx_1_ahrs_settings.gyroscopeRange = 1000.0f;
    FusionAhrsSetSettings(&g_mpu6xxx_1_ahrs, &g_mpu6xxx_1_ahrs_settings);

    FusionAhrsInitialise(&g_mpu6xxx_2_ahrs);
    auto g_mpu6xxx_2_ahrs_settings           = g_common_ahrs_settings;
    g_mpu6xxx_2_ahrs_settings.gyroscopeRange = 1000.0f;
    FusionAhrsSetSettings(&g_mpu6xxx_2_ahrs, &g_mpu6xxx_2_ahrs_settings);

    FusionAhrsInitialise(&g_mpu6xxx_3_ahrs);
    auto g_mpu6xxx_3_ahrs_settings           = g_common_ahrs_settings;
    g_mpu6xxx_3_ahrs_settings.gyroscopeRange = 1000.0f;
    FusionAhrsSetSettings(&g_mpu6xxx_3_ahrs, &g_mpu6xxx_3_ahrs_settings);

    FusionBiasInitialise(&g_lsm6dsl_bias);
    FusionBiasInitialise(&g_mpu6xxx_1_bias);
    FusionBiasInitialise(&g_mpu6xxx_2_bias);
    FusionBiasInitialise(&g_mpu6xxx_3_bias);

    FusionBiasSettings bias_settings = fusionBiasDefaultSettings;
    bias_settings.sampleRate         = static_cast<float>(sample_rate_hz);

    FusionBiasSetSettings(&g_lsm6dsl_bias, &bias_settings);
    FusionBiasSetSettings(&g_mpu6xxx_1_bias, &bias_settings);
    FusionBiasSetSettings(&g_mpu6xxx_2_bias, &bias_settings);
    FusionBiasSetSettings(&g_mpu6xxx_3_bias, &bias_settings);

    /* Instantiate manager. */
    mdm::manager::Manager<SENSOR_COUNT>::sensor_mapping_container_type sensor_mappings{
        mdm::manager::SensorMapping{
            .imu  = g_lsm6dsl_imu,
            .mag  = g_lis3dml_mag,
            .type = mdm::manager::SensorMappingType::IMU_6DOF_WITH_MAG
        },
        mdm::manager::SensorMapping{
            .imu  = g_mpu6xxx_1_imu,
            .mag  = nullptr,
            .type = mdm::manager::SensorMappingType::IMU_6DOF_NO_MAG,
        },
        // mdm::manager::SensorMapping{
        //     .imu  = g_mpu6xxx_2_imu,
        //     .mag  = nullptr,
        //     .type = mdm::manager::SensorMappingType::IMU_6DOF_NO_MAG,
        // },
        mdm::manager::SensorMapping{
            .imu  = g_mpu6xxx_3_imu,
            .mag  = nullptr,
            .type = mdm::manager::SensorMappingType::IMU_6DOF_NO_MAG,
        },
    };

    g_calibration =
        new cal::Calibration<SENSOR_COUNT, cal::DefaultConfigTraits, cal::DefaultCooldownSamples>(
            g_logger
        );

    g_sensor_manager = new mdm::manager::Manager<SENSOR_COUNT>(
        std::move(sensor_mappings), g_logger
    );

    if (auto res = g_sensor_manager->init(); !res) {
        g_logger->error("Sensor manager init failed with error code: {}", res.error());
        while (true) {
            g_logger->error("Sensor manager init failed with error code: {}", res.error());
            delay(1000);
        }
    }
}

void loop() {
    unsigned long now = micros();

    /* Throttle reads. */
    if (now - last_tilt_update_time >= delay_us) {
        const auto data_ready_res = g_sensor_manager->get_is_all_data_ready();
        if (!data_ready_res) {
            g_logger->error("Error checking if sensor data is ready: {}", data_ready_res.error());
            return;
        } else if (!data_ready_res.value()) {
            return;
        }

        const auto read_res = g_sensor_manager->read_all_sensors(g_data_container);
        if (!read_res) {
            g_logger->error("Error reading sensor data: {}", read_res.error());
            return;
        } else {
            if (!g_is_calibrated) {

                if (!g_calibration->done()) {
                    const auto res = g_calibration->on_data(g_data_container);
                    if (!res) {
                        g_logger->error("Calibration failed with error code: {}", res.error());
                    }

                } else {
                    g_is_calibrated = true;
                    const auto res  = g_calibration->get_result(g_calibration_results);
                    if (!res) {
                        g_logger->error(
                            "Failed to get calibration results with error code: {}", res.error()
                        );
                    } else {

                        const auto ref = g_calibration_results[0].gyro.misalignment;
                        g_calibration_results[0].mag.soft_iron_matrix = FusionMatrix{
                            {-ref.element.xx,
                             -ref.element.xy,
                             -ref.element.xz,
                             -ref.element.yx,
                             -ref.element.yy,
                             -ref.element.yz,
                             ref.element.zx,
                             ref.element.zy,
                             ref.element.zz}
                        };

                        g_is_calibrated = true;
                        delete g_calibration;
                    }
                }

                return;
            }

            for (std::size_t i = 0; i < SENSOR_COUNT; i++) {
                g_data_container[i].gyro = FusionModelInertial(
                    g_data_container[i].gyro,
                    g_calibration_results[i].gyro.misalignment,
                    g_calibration_results[i].gyro.sensitivity,
                    g_calibration_results[i].gyro.offset
                );
                g_data_container[i].accel = FusionModelInertial(
                    g_data_container[i].accel,
                    g_calibration_results[i].accel.misalignment,
                    g_calibration_results[i].accel.sensitivity,
                    g_calibration_results[i].accel.offset
                );
                if (i == 0) {
                    g_data_container[i].mag = FusionModelMagnetic(
                        g_data_container[i].mag,
                        g_calibration_results[i].mag.soft_iron_matrix,
                        g_calibration_results[i].mag.hard_iron_offset
                    );
                }
            }

            g_data_container[0].gyro = FusionBiasUpdate(&g_lsm6dsl_bias, g_data_container[0].gyro);
            g_data_container[1].gyro = FusionBiasUpdate(
                &g_mpu6xxx_1_bias, g_data_container[1].gyro
            );
            // g_data_container[2].gyro = FusionBiasUpdate(
            //     &g_mpu6xxx_2_bias, g_data_container[2].gyro
            // );
            g_data_container[2].gyro = FusionBiasUpdate(
                &g_mpu6xxx_3_bias, g_data_container[2].gyro
            );

            const float deltaTime = (float)(now - last_tilt_update_time) / 1000000.0F;
            last_tilt_update_time = now;

            /* Update AHRS algorithm. */
            FusionAhrsUpdate(
                &g_lsm6dsl_ahrs,
                g_data_container[0].gyro,
                g_data_container[0].accel,
                g_data_container[0].mag,
                deltaTime
            );

            FusionAhrsUpdateNoMagnetometer(
                &g_mpu6xxx_1_ahrs, g_data_container[1].gyro, g_data_container[1].accel, deltaTime
            );

            // FusionAhrsUpdateNoMagnetometer(
            //     &g_mpu6xxx_2_ahrs, g_data_container[2].gyro, g_data_container[2].accel, deltaTime
            // );

            FusionAhrsUpdateNoMagnetometer(
                &g_mpu6xxx_3_ahrs, g_data_container[2].gyro, g_data_container[2].accel, deltaTime
            );

            /* Update the cooling delay. */
            if (delay_us > SAMPLE_RATE_FINAL_DELAY_US) {
                delay_us = (unsigned long)((float)(delay_us) / SAMPLE_RATE_DELAY_COOL_FACTOR);
            } else {
                delay_us = SAMPLE_RATE_FINAL_DELAY_US;
            }
        }
    }

    if (!g_is_calibrated) return;

    /* Handle printing at 20Hz. */
    if (now - last_print_time > 50000UL) {
        // const FusionEuler lsm6dsl_euler = FusionQuaternionToEuler(
        //     FusionAhrsGetQuaternion(&g_lsm6dsl_ahrs)
        // );
        // const FusionEuler mpu6xxx_1_euler = FusionQuaternionToEuler(
        //     FusionAhrsGetQuaternion(&g_mpu6xxx_1_ahrs)
        // );

        // g_logger->println("{}", g_data_container[0].mag);

        FusionQuaternion lsm6dsl_quaternion   = FusionAhrsGetQuaternion(&g_lsm6dsl_ahrs);
        FusionQuaternion mpu6xxx_1_quaternion = FusionAhrsGetQuaternion(&g_mpu6xxx_1_ahrs);
        FusionQuaternion mpu6xxx_2_quaternion = FusionAhrsGetQuaternion(&g_mpu6xxx_2_ahrs);
        FusionQuaternion mpu6xxx_3_quaternion = FusionAhrsGetQuaternion(&g_mpu6xxx_3_ahrs);

        // lsm6dsl_quaternion = FusionQuaternionProduct(
        //     lsm6dsl_quaternion, g_calibration_quat_offsets[0]
        // );
        // mpu6xxx_1_quaternion = FusionQuaternionProduct(
        //     mpu6xxx_1_quaternion, g_calibration_quat_offsets[1]
        // );
        // mpu6xxx_2_quaternion = FusionQuaternionProduct(
        //     mpu6xxx_2_quaternion, g_calibration_quat_offsets[2]
        // );
        // mpu6xxx_3_quaternion = FusionQuaternionProduct(
        //     mpu6xxx_3_quaternion, g_calibration_quat_offsets[3]
        // );

        g_logger->println(
            "palm:{:.4f},{:.4f},{:.4f},{:.4f};"
            "index:{:.4f},{:.4f},{:.4f},{:.4f};"
            "middle:{:.4f},{:.4f},{:.4f},{:.4f};"
            "thumb:{:.4f},{:.4f},{:.4f},{:.4f};",
            lsm6dsl_quaternion.element.w,
            lsm6dsl_quaternion.element.x,
            lsm6dsl_quaternion.element.y,
            lsm6dsl_quaternion.element.z,
            mpu6xxx_1_quaternion.element.w,
            mpu6xxx_1_quaternion.element.x,
            mpu6xxx_1_quaternion.element.y,
            mpu6xxx_1_quaternion.element.z,
            mpu6xxx_2_quaternion.element.w,
            mpu6xxx_2_quaternion.element.x,
            mpu6xxx_2_quaternion.element.y,
            mpu6xxx_2_quaternion.element.z,
            mpu6xxx_3_quaternion.element.w,
            mpu6xxx_3_quaternion.element.x,
            mpu6xxx_3_quaternion.element.y,
            mpu6xxx_3_quaternion.element.z
        );

        // g_logger->println(
        //     "lsm6dsl:{:.2f},{:.2f},{:.2f};mpu6xxx_1:{:.2f},{:.2f},{:.2f};",
        //     lsm6dsl_euler.angle.roll,
        //     lsm6dsl_euler.angle.pitch,
        //     lsm6dsl_euler.angle.yaw,
        //     mpu6xxx_1_euler.angle.roll,
        //     mpu6xxx_1_euler.angle.pitch,
        //     mpu6xxx_1_euler.angle.yaw
        // );

        last_print_time = now;
    }
}
