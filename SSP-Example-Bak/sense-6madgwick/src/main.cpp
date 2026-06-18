/*
 * Copyright (C) 2026 Kiril V. Strezikozin
 * SPDX-License-Identifier: Apache-2.0
 */

#include <Arduino.h>
#include <SPI.h>
#include <Wire.h>
#include <cstddef>

#include "bus/arduino/i2c.hpp"
#include "bus/arduino/sw_spi.hpp"
#include "bus/ibus.hpp"
#include "cal/calibration.hpp"
#include "fusion/madgwick/FusionMath.h"
#include "imu/bmi270/i2c.hpp"
#include "imu/lsm6dsl/spi.hpp"
#include "imu/lsm9ds1/i2c.hpp"
#include "log/arduino/log.hpp"
#include "math-utils/math-utils.hpp"
#include "mdm/fk_model.hpp"
#include "mdm/manager.hpp"

#include "fusion/madgwick/Fusion.h"

/* --- I2C Config --- */
#ifndef BMI270_I2C_SPEED
#define BMI270_I2C_SPEED 400000
#endif

/* --- SPI Config for LSM6DSL --- */
#ifndef LSM6DSL_SPI_SPEED
#define LSM6DSL_SPI_SPEED 1000000  // 1MHz as requested
#endif

#ifndef SPI_DEFAULT_SCK
#define SPI_DEFAULT_SCK 13
#endif

#ifndef SPI_DEFAULT_MOSI
#define SPI_DEFAULT_MOSI 11
#endif

#define CAL_DISABLE_FUNCTIONAL        1
// #define TARGET_PLATFORM_ARDUINO_NANO_33_BLE_SENSE_REV1 1

/* Finger MISO & CS Pins */
#define THUMB_PIN_CS                  10
#define THUMB_PIN_MISO                12

#define INDEX_PIN_CS                  9
#define INDEX_PIN_MISO                5

#define MIDDLE_PIN_CS                 7
#define MIDDLE_PIN_MISO               3

#define RING_PIN_CS                   8
#define RING_PIN_MISO                 4

#define PINKY_PIN_CS                  6
#define PINKY_PIN_MISO                2

/* --- Timing & Sample Rates --- */
#define SAMPLE_RATE_HZ                200
#define SAMPLE_RATE_DELAY_COOL_FACTOR 2.0F
#define SAMPLE_RATE_FINAL_DELAY_US    (0UL) /* 10ms */
#define SAMPLE_RATE_INITIAL_DELAY_US  (0UL)

/* --- Globals --- */
static constexpr std::size_t SENSOR_COUNT = 6;  // 1x BMI270 + 5x LSM6DSL

static constexpr uint8_t g_lsm6dsl_cs_pins[5] = {
    THUMB_PIN_CS, INDEX_PIN_CS, MIDDLE_PIN_CS, RING_PIN_CS, PINKY_PIN_CS
};
static constexpr uint8_t g_lsm6dsl_miso_pins[5] = {
    THUMB_PIN_MISO, INDEX_PIN_MISO, MIDDLE_PIN_MISO, RING_PIN_MISO, PINKY_PIN_MISO
};

static TwoWire *g_palm_imu_i2c_wire = nullptr;

/* IMU Pointers */
static imu::IIMU *g_imu_palm   = nullptr;  // 0
static imu::IIMU *g_imu_thumb  = nullptr;  // 1
static imu::IIMU *g_imu_index  = nullptr;  // 2
static imu::IIMU *g_imu_middle = nullptr;  // 3
static imu::IIMU *g_imu_ring   = nullptr;  // 4
static imu::IIMU *g_imu_pinky  = nullptr;  // 5

/* Manager & Calibration */
static mdm::manager::Manager<SENSOR_COUNT> *g_sensor_manager = nullptr;
static mdm::manager::Manager<SENSOR_COUNT>::data_container_type g_data_container{};

/* Forward Kinematics Solution Model for the Hand. */
using HandFKModel =
    mdm::forward_kinematics::HandFKModel<mdm::forward_kinematics::RightHandFKModelConfigTraits<
        mdm::forward_kinematics::HandFKModelMode::RELATIVE_ORIENTATION_ONLY,

#ifdef TARGET_PLATFORM_ARDUINO_NANO_33_BLE_SENSE_REV1
        mdm::forward_kinematics::HandFKModelOffset::ROT_NEG_90_Z
#else
        mdm::forward_kinematics::HandFKModelOffset::IDENTITY
#endif
        >>;
static HandFKModel *g_hand_fk_model = nullptr;

/* Out-of-class definitions for sample counts array in calibration config traits. */
constexpr std::array<std::size_t, cal::CalibrationStageCount>
    cal::DefaultConfigTraits::sample_counts;

struct CalibrationConfigTraits : public cal::DefaultConfigTraits {
#ifdef TARGET_PLATFORM_ARDUINO_NANO_33_BLE_SENSE_REV1
    /* Rev 1's IMU coordinate system does not follow the right-hand rule,
     * any ONE axis needs to be flipped. My SVD calibration will not fix it,
     * because we take palm as the reference, there is nothing to compare it to
     * and, therefore, align with.
     * <https://forum.arduino.cc/t/nano-33-ble-imu-lsm9ds1-xyz-directions/883592/4>
     * */
    static constexpr float ref_flip_z = -1.0F;
#endif
};

using Calibration =
    cal::Calibration<SENSOR_COUNT, CalibrationConfigTraits, cal::DefaultCooldownSamples>;

static Calibration *g_calibration = nullptr;
static bool g_is_calibrated       = false;

static std::array<cal::SensorCalibrationResult, SENSOR_COUNT> g_calibration_results{};

/* clang-format off */
#ifndef TARGET_PLATFORM_ARDUINO_NANO_33_BLE_SENSE_REV1
__attribute__((unused)) static Calibration::container_type<FusionMatrix, SENSOR_COUNT> g_gyro_accel_misalignment_matrices{
    FusionMatrix{{
		/* 0: BMI270 (Palm) */
         1,             -3.7252903e-09,  0,
        -1.8626451e-09,  0.9999998,     -7.566996e-10,
        -4.656613e-10,  -7.566996e-10,   1,
    }},
    FusionMatrix{{
		/* 1: LSM6DSL (Thumb) */
         0.1582195,     -0.52042305,    -0.8391225,
         0.9710532,      0.23602483,     0.03671308,
         0.1789474,     -0.82064134,     0.5427022,
    }},
    FusionMatrix{{
		/* 2: LSM6DSL (Index) */
         0.31146908,    -0.7674774,     -0.56032634,
         0.92720175,     0.11635647,     0.35603133,
        -0.20804836,    -0.6304282,      0.74784786,
    }},
    FusionMatrix{{
		/* 3: LSM6DSL (Middle) */
         0.1527532,     -0.9651039,     -0.21269952,
         0.9549096,      0.088694744,    0.28333804,
        -0.25458524,    -0.2463896,      0.9351355,
    }},
    FusionMatrix{{
		/* 4: LSM6DSL (Ring) */
        -0.09350005,    -0.9930548,      0.0714113,
         0.9646828,     -0.072620496,    0.25320587,
        -0.24626143,     0.09256402,     0.96477324,
    }},
    FusionMatrix{{
		/* 5: LSM6DSL (Pinky) */
        -0.027524266,   -0.9622299,      0.2708439,
         0.99896383,    -0.01665145,     0.042361032,
        -0.036251098,    0.27172923,     0.96169096,
    }},
};
#else
__attribute__((unused)) static Calibration::container_type<FusionMatrix, SENSOR_COUNT> g_gyro_accel_misalignment_matrices{
    FusionMatrix{{
        /* 0: BMI270 (Palm) */
         1.0000004,      5.2154064e-08,  1.8626451e-09,
         2.2351742e-08,  1,             -2.9802322e-08,
        -9.313226e-09,   0,              1.0000001,
    }},
    FusionMatrix{{
        /* 1: LSM6DSL (Thumb) */
         0.99198425,     0.116567686,   -0.048781373,
        -0.012384005,    0.47386426,     0.8805109,
         0.1257548,     -0.87284875,     0.4715094,
    }},
    FusionMatrix{{
        /* 2: LSM6DSL (Index) */
         0.9364592,     -0.03636738,     0.34888643,
        -0.24818909,     0.63416874,     0.7322786,
        -0.24788389,    -0.77233875,     0.58484703,
    }},
    FusionMatrix{{
        /* 3: LSM6DSL (Middle) */
         0.9489383,     -0.08789804,     0.30296868,
         0.02215273,     0.97659415,     0.21394661,
        -0.31468287,    -0.19631067,     0.9286745,
    }},
    FusionMatrix{{
        /* 4: LSM6DSL (Ring) */
         0.92529505,    -0.18405464,     0.3315922,
         0.20527172,     0.9782509,     -0.029811442,
        -0.31889343,     0.09565079,     0.94295186,
    }},
    FusionMatrix{{
        /* 5: LSM6DSL (Pinky) */
         0.96534806,    -0.17022352,     0.19780555,
         0.21549094,     0.94748706,    -0.23628867,
        -0.14719632,     0.27072603,     0.9513364,
    }},
};
#endif
/* clang-format on */

/* Sensor Fusion Arrays */
static FusionAhrs g_ahrs[SENSOR_COUNT];
static FusionBias g_bias[SENSOR_COUNT];

static logger::arduino::Logger *g_logger = nullptr;

static unsigned long last_print_time       = 0;
static unsigned long last_tilt_update_time = 0;

/* --- Initialization Helpers --- */

static inline void init_bmi270_imu() {
#ifdef TARGET_PLATFORM_ARDUINO_NANO_33_BLE_SENSE_REV1
    namespace palm_imu           = imu::lsm9ds1;
    const auto palm_imu_i2c_addr = palm_imu::config::IMUI2CAddress::LSM9DS1_SA0_HIGH;
#else
    namespace palm_imu           = imu::bmi270;
    const auto palm_imu_i2c_addr = palm_imu::config::IMUI2CAddress::BMI270_SDO_LOW;
#endif

    palm_imu::config::IMUConfig imu_config;
    auto *i2c_bus = new bus::arduino::I2CBus(
        g_palm_imu_i2c_wire,
        static_cast<bus::arduino::I2CBus::addr_type>(palm_imu_i2c_addr),
        g_logger
    );
    g_imu_palm = new palm_imu::imu::I2CIMU(imu_config, i2c_bus, g_logger);
}

static inline imu::IIMU *init_lsm6dsl_spi_imu(uint8_t miso_pin, uint8_t cs_pin) {
    imu::lsm6dsl::config::IMUConfig imu_config;

    auto *spi_bus = new bus::arduino::SWSPIBus(
        cs_pin,
        SPI_DEFAULT_SCK,
        miso_pin,
        SPI_DEFAULT_MOSI,
        g_logger,
        LSM6DSL_SPI_SPEED,
        SPI_BITORDER_MSBFIRST,
        SPI_MODE0
    );
    spi_bus->begin();

    return new imu::lsm6dsl::imu::SPIIMU(imu_config, spi_bus, g_logger);
}

static inline void init_sensors() {
    init_bmi270_imu();
    g_imu_thumb  = init_lsm6dsl_spi_imu(THUMB_PIN_MISO, THUMB_PIN_CS);
    g_imu_index  = init_lsm6dsl_spi_imu(INDEX_PIN_MISO, INDEX_PIN_CS);
    g_imu_middle = init_lsm6dsl_spi_imu(MIDDLE_PIN_MISO, MIDDLE_PIN_CS);
    g_imu_ring   = init_lsm6dsl_spi_imu(RING_PIN_MISO, RING_PIN_CS);
    g_imu_pinky  = init_lsm6dsl_spi_imu(PINKY_PIN_MISO, PINKY_PIN_CS);
}

static inline void disableI2C_Broadcast() {
    for (uint8_t pin : g_lsm6dsl_cs_pins) {
        digitalWrite(pin, LOW);
    }
    delay(1);

    // shiftOut behaves like SPI Mode 0 (SCK idles LOW)
    shiftOut(SPI_DEFAULT_MOSI, SPI_DEFAULT_SCK, MSBFIRST, 0x13);
    shiftOut(SPI_DEFAULT_MOSI, SPI_DEFAULT_SCK, MSBFIRST, 0x04);

    for (uint8_t pin : g_lsm6dsl_cs_pins) {
        digitalWrite(pin, HIGH);
    }
    delay(2);
}

static inline void disableI2C_Single(uint8_t csPin) {
    digitalWrite(csPin, LOW);
    shiftOut(SPI_DEFAULT_MOSI, SPI_DEFAULT_SCK, MSBFIRST, 0x13);
    shiftOut(SPI_DEFAULT_MOSI, SPI_DEFAULT_SCK, MSBFIRST, 0x04);
    digitalWrite(csPin, HIGH);
    delay(2);
}

static mdm::manager::Manager<SENSOR_COUNT>::res_type on_one_sensor_init_post(
    __attribute__((unused)) mdm::manager::SensorMapping const &m,
    mdm::manager::Manager<SENSOR_COUNT>::sensor_mapping_size_type i
) noexcept {
    if (i == 0) {
        /* No-op for the BMI270 since it's on a separate I2C bus and
         * doesn't share the broadcast disable. */
        return {};
    }

    /* The manager init likely issued a software reset to the IMUs, re-enabling I2C.
     * Re-take manual control and disable I2C individually for each sensor.
     */
    pinMode(SPI_DEFAULT_SCK, OUTPUT);
    pinMode(SPI_DEFAULT_MOSI, OUTPUT);
    digitalWrite(SPI_DEFAULT_SCK, LOW);

    disableI2C_Single(g_lsm6dsl_cs_pins[i - 1]);

    return {};
}

void setup() {
    Serial.begin(115200);
    while (!Serial) {
        delay(10);
    }
    delay(1000);

    g_logger = new logger::arduino::Logger();
    g_logger->info("Starting up...");

    /* I2C Setup */
    Wire1.begin();
    Wire1.setClock(BMI270_I2C_SPEED);
    g_palm_imu_i2c_wire = &Wire1;

    /* Manually configure shared pins and Broadcast Disable I2C */
    pinMode(SPI_DEFAULT_SCK, OUTPUT);
    pinMode(SPI_DEFAULT_MOSI, OUTPUT);
    digitalWrite(SPI_DEFAULT_SCK, LOW);  // Force SCK to idle LOW

    /* Hardware/Software SPI Setup - Deselect all CS pins first */
    for (size_t i = 0; i < SENSOR_COUNT - 1; i++) {
        uint8_t cs_pin   = g_lsm6dsl_cs_pins[i];
        uint8_t miso_pin = g_lsm6dsl_miso_pins[i];
        pinMode(cs_pin, OUTPUT);
        digitalWrite(cs_pin, HIGH);
        pinMode(miso_pin, INPUT);
    }
    delay(50);

    disableI2C_Broadcast();
    delay(10);

    init_sensors();

    /* Instantiate AHRS algorithm for all sensors */
    const FusionAhrsSettings common_ahrs_settings = {
        .convention            = FusionConventionNwu,
        .gain                  = 0.05f,   /* 0.1f. */
        .gyroscopeRange        = 2000.0f, /* Assuming 1000 dps for all */
        .accelerationRejection = 10.0f,   /* 10.0f. */
        .magneticRejection     = 10.0f,
        .recoveryTriggerPeriod = 5 * SAMPLE_RATE_HZ,
    };

    FusionBiasSettings bias_settings = fusionBiasDefaultSettings;
    bias_settings.sampleRate         = static_cast<float>(SAMPLE_RATE_HZ);

    for (std::size_t i = 0; i < SENSOR_COUNT; i++) {
        FusionAhrsInitialise(&g_ahrs[i]);
        FusionAhrsSetSettings(&g_ahrs[i], &common_ahrs_settings);
        FusionBiasInitialise(&g_bias[i]);
        FusionBiasSetSettings(&g_bias[i], &bias_settings);
    }

    /* Map all 6 sensors (None have magnetometers configured here) */
    mdm::manager::Manager<SENSOR_COUNT>::sensor_mapping_container_type sensor_mappings{
        mdm::manager::SensorMapping{
            .imu  = g_imu_palm,
            .mag  = nullptr,
            .type = mdm::manager::SensorMappingType::IMU_6DOF_NO_MAG,
            .name = mdm::manager::SensorName::PALM,
        },
        mdm::manager::SensorMapping{
            .imu  = g_imu_thumb,
            .mag  = nullptr,
            .type = mdm::manager::SensorMappingType::IMU_6DOF_NO_MAG,
            .name = mdm::manager::SensorName::THUMB,
        },
        mdm::manager::SensorMapping{
            .imu  = g_imu_index,
            .mag  = nullptr,
            .type = mdm::manager::SensorMappingType::IMU_6DOF_NO_MAG,
            .name = mdm::manager::SensorName::INDEX,
        },
        mdm::manager::SensorMapping{
            .imu  = g_imu_middle,
            .mag  = nullptr,
            .type = mdm::manager::SensorMappingType::IMU_6DOF_NO_MAG,
            .name = mdm::manager::SensorName::MIDDLE,
        },
        mdm::manager::SensorMapping{
            .imu  = g_imu_ring,
            .mag  = nullptr,
            .type = mdm::manager::SensorMappingType::IMU_6DOF_NO_MAG,
            .name = mdm::manager::SensorName::RING,
        },
        mdm::manager::SensorMapping{
            .imu  = g_imu_pinky,
            .mag  = nullptr,
            .type = mdm::manager::SensorMappingType::IMU_6DOF_NO_MAG,
            .name = mdm::manager::SensorName::PINKY,
        },
    };

    g_calibration = new Calibration(g_logger);

#ifdef CAL_DISABLE_FUNCTIONAL
    Calibration::result_type dres;
    dres = g_calibration->disable_calibration_stage(cal::CalibrationStage::ROT_X_AXIS);
    if (!dres) { g_logger->error("Failed to disable ROT_X_AXIS stage: {}", dres.error()); }
    dres = g_calibration->disable_calibration_stage(cal::CalibrationStage::ROT_Y_AXIS);
    if (!dres) { g_logger->error("Failed to disable ROT_Y_AXIS stage: {}", dres.error()); }
    dres = g_calibration->disable_calibration_stage(cal::CalibrationStage::ROT_Z_AXIS);
    if (!dres) { g_logger->error("Failed to disable ROT_Z_AXIS stage: {}", dres.error()); }
    dres = g_calibration->disable_calibration_stage(cal::CalibrationStage::MISALIGNMENT_COMPUTATION
    );
    if (!dres) { g_logger->error("Failed to disable MISALIG_COMPUT stage: {}", dres.error()); }
#endif

    g_sensor_manager = new mdm::manager::Manager<SENSOR_COUNT>(
        std::move(sensor_mappings), g_logger
    );

    g_sensor_manager->set_on_one_sensor_init_post_callback(on_one_sensor_init_post);

    auto res = g_sensor_manager->init();
    if (!res) {
        g_logger->error("Sensor manager init failed with error code: {}", res.error());
        while (true) {
            g_logger->error("Sensor manager init failed with error code: {}", res.error());
            delay(1000);
        }
    }

    g_hand_fk_model = new HandFKModel();
}

void loop() {
    unsigned long now = micros();

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
        /* Calibration Phase */
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
                    /* Calibration is complete. Can safely delete the
                     * calibration object and free memory since we have the
                     * results stored. I tried to optimize the calibration
                     * implementation as much as possible such that it does
                     * not use scratch arrays to store data it reads from
                     * sensors, but there is no point to keep it hanging
                     * around in memory. */
                    delete g_calibration;
                    g_logger->info("Calibration Complete.");

                    last_tilt_update_time = now;
                }
            }
            return;
        }

        const float deltaTime = (float)(now - last_tilt_update_time) / 1000000.0F;
        last_tilt_update_time = now;

        /* Apply calibration and Update AHRS for all 6 sensors */
        for (std::size_t i = 0; i < SENSOR_COUNT; i++) {
            g_data_container[i].gyro = FusionModelInertial(
                g_data_container[i].gyro,
#ifdef CAL_DISABLE_FUNCTIONAL
                g_gyro_accel_misalignment_matrices[i],
#else
                g_calibration_results[i].gyro.misalignment,
#endif
                g_calibration_results[i].gyro.sensitivity,
                g_calibration_results[i].gyro.offset
            );

            g_data_container[i].accel = FusionModelInertial(
                g_data_container[i].accel,

#ifdef CAL_DISABLE_FUNCTIONAL
                g_gyro_accel_misalignment_matrices[i],
#else
                g_calibration_results[i].accel.misalignment,
#endif
                g_calibration_results[i].accel.sensitivity,
                g_calibration_results[i].accel.offset
            );

            g_data_container[i].gyro = FusionBiasUpdate(&g_bias[i], g_data_container[i].gyro);

            FusionAhrsUpdateNoMagnetometer(
                &g_ahrs[i], g_data_container[i].gyro, g_data_container[i].accel, deltaTime
            );
        }
    }

    if (!g_is_calibrated) return;

    /* Handle printing at 20Hz (every 50ms) */
    if (now - last_print_time > 50000UL && Serial) {
        // FusionQuaternion q_bmi    = FusionAhrsGetQuaternion(&g_ahrs[0]);
        // FusionQuaternion q_thumb  = FusionAhrsGetQuaternion(&g_ahrs[1]);
        // FusionQuaternion q_index  = FusionAhrsGetQuaternion(&g_ahrs[2]);
        // FusionQuaternion q_middle = FusionAhrsGetQuaternion(&g_ahrs[3]);
        // FusionQuaternion q_ring   = FusionAhrsGetQuaternion(&g_ahrs[4]);
        // FusionQuaternion q_pinky  = FusionAhrsGetQuaternion(&g_ahrs[5]);

        for (std::size_t i = 0; i < SENSOR_COUNT; i++) {
            FusionQuaternion q = FusionAhrsGetQuaternion(&g_ahrs[i]);
            Vector3<float> loc{};

            /* Modifies `q` and `loc` in place: */
            g_hand_fk_model->solve(q, loc, static_cast<mdm::manager::SensorName>(i));

            g_logger->println(
                "{}:{:.4f},{:.4f},{:.4f},{:.4f},{:.4f},{:.4f},{:.4f};",
                i,
                q.element.w,
                q.element.x,
                q.element.y,
                q.element.z,
                loc.x(),
                loc.y(),
                loc.z()
            );
        }

        // g_logger->println(
        //     "palm:{:.4f},{:.4f},{:.4f},{:.4f};"
        //     "thumb:{:.4f},{:.4f},{:.4f},{:.4f};"
        //     "index:{:.4f},{:.4f},{:.4f},{:.4f};"
        //     "middle:{:.4f},{:.4f},{:.4f},{:.4f};"
        //     "ring:{:.4f},{:.4f},{:.4f},{:.4f};"
        //     "pinky:{:.4f},{:.4f},{:.4f},{:.4f};",
        //     q_bmi.element.w,
        //     q_bmi.element.x,
        //     q_bmi.element.y,
        //     q_bmi.element.z,
        //     q_thumb.element.w,
        //     q_thumb.element.x,
        //     q_thumb.element.y,
        //     q_thumb.element.z,
        //     q_index.element.w,
        //     q_index.element.x,
        //     q_index.element.y,
        //     q_index.element.z,
        //     q_middle.element.w,
        //     q_middle.element.x,
        //     q_middle.element.y,
        //     q_middle.element.z,
        //     q_ring.element.w,
        //     q_ring.element.x,
        //     q_ring.element.y,
        //     q_ring.element.z,
        //     q_pinky.element.w,
        //     q_pinky.element.x,
        //     q_pinky.element.y,
        //     q_pinky.element.z
        // );

        last_print_time = now;
    }
}
