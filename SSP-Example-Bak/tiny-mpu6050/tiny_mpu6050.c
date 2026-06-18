/*
 * Copyright (C) 2026 Kiril V. Strezikozin
 * SPDX-License-Identifier: Apache-2.0
 */

#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>

#include <math.h>

#include <pico/stdio.h>
#include <pico/time.h>
#include <pico/types.h>

#include <hardware/gpio.h>
#include <hardware/i2c.h>
#include <hardware/structs/io_bank0.h>
#include <hardware/timer.h>

#include "tiny-mpu6050/config.h"
#include "tiny-mpu6050/i2c.h"
#include "tiny-mpu6050/reg.h"
#include "tiny-mpu6050/utils.h"

#ifndef GYRO_TILT_LED_MPU6050_PIN_SDA
#define GYRO_TILT_LED_MPU6050_PIN_SDA 2
#endif

#ifndef GYRO_TILT_LED_MPU6050_PIN_SCL
#define GYRO_TILT_LED_MPU6050_PIN_SCL 3
#endif

#ifndef GYRO_TILT_LED_MPU6050_PIN_INT
#define GYRO_TILT_LED_MPU6050_PIN_INT 15
#endif

#ifndef GYRO_TILT_LED_TINY_MPU6050_I2C_INST
#define GYRO_TILT_LED_TINY_MPU6050_I2C_INST i2c1
#endif

static tiny_mpu6050_config mpu_config;
static volatile float tilt[3] = {0, 0, 0};

#define GYRO_TILT_LED_COMPLEMENTARY_FACTOR                  0.99F

#define GYRO_TILT_LED_MPU6050_SAMPLE_RATE_DELAY_COOL_FACTOR 2.0F
#define GYRO_TILT_LED_MPU6050_SAMPLE_RATE_FINAL_DELAY_US    (absolute_time_t)(10 * 1000)
#define GYRO_TILT_LED_MPU6050_SAMPLE_RATE_INITIAL_DELAY_US  (absolute_time_t)(10 * 1000)

#define location_2d_to_pixel_index(__location)                                                     \
    (((__location)[0] * GYRO_TILT_LED_WS2812_PIXEL_COUNT_Y)                                        \
     + (((__location)[0] & 1) ? (GYRO_TILT_LED_WS2812_PIXEL_COUNT_Y - (__location)[1] - 1)         \
                              : (__location)[1]))

/* \brief Calculate next tilt values using a complementary filter.
 */
static inline void calc_tilt_complementary_filter(
    const tiny_mpu6050_accel_measurement a[3],
    const tiny_mpu6050_gyro_measurement g[3],
    const float tilt_prev[3],
    float tilt_dst[3],
    float dt,
    float factor
) {
    float w_a[3]; /* w from accel data. */
    w_a[0] = atan2f(a[1], a[2]);
    w_a[1] = atan2f(-a[0], sqrtf((a[1] * a[1]) + (a[2] * a[2])));
    w_a[2] = 0;

    float w_g[3] /* w from gyro data in radians, integrated. */;
    w_g[0] = (dt * g[0] * (float)(M_PI / 180.0F)) + tilt_prev[0];
    w_g[1] = (dt * g[1] * (float)(M_PI / 180.0F)) + tilt_prev[1];
    w_g[2] = (dt * g[2] * (float)(M_PI / 180.0F)) + tilt_prev[2];

    tilt_dst[0] = factor * w_g[0] + (1 - factor) * w_a[0];
    tilt_dst[1] = factor * w_g[1] + (1 - factor) * w_a[1];
    // tilt_dst[2] = factor * w_g[2] + (1 - factor) * w_a[2];
    tilt_dst[2] = w_g[2];
}

/* \brief Calculate tilt with parameters automatically supplied to a
 * complementary filter.
 */
static inline void get_tilt(
    const tiny_mpu6050_accel_measurement accel[3],
    const tiny_mpu6050_gyro_measurement gyro[3],
    float tilt[3]
) {
    static absolute_time_t time_prev_us = 0;

    absolute_time_t time_now_us = time_us_32();
    float dt                    = (float)(time_now_us - time_prev_us) / (1000 * 1000);
    time_prev_us                = time_now_us;

    calc_tilt_complementary_filter(accel, gyro, tilt, tilt, dt, GYRO_TILT_LED_COMPLEMENTARY_FACTOR);
}

/* \brief Callback for tilt recalculation with automatic timing.
 */
static inline void get_tilt_callback(void) {
#define final_delay_us    GYRO_TILT_LED_MPU6050_SAMPLE_RATE_FINAL_DELAY_US
#define delay_cool_factor GYRO_TILT_LED_MPU6050_SAMPLE_RATE_DELAY_COOL_FACTOR
    /* Allow control for delay between reading sensor data. It may be more
    stable to start reading slowly for a moment first and then speed up. */
    static absolute_time_t last_tilt_update_time = 0;
    static absolute_time_t delay = GYRO_TILT_LED_MPU6050_SAMPLE_RATE_INITIAL_DELAY_US;

    /* The delay between reads should be at the
     * minimum the sample rate of MPU6050. */
    absolute_time_t now = time_us_32();
    if (now - last_tilt_update_time < delay) return;

    /* Read accelerometer data. */
    tiny_mpu6050_accel_measurement accel_data[3];
    tiny_mpu6050_get_accel_data(&mpu_config, accel_data, TINY_MPU6050_ACCEL_RANGE_2G);

    /* Read gyroscope data. */
    tiny_mpu6050_gyro_measurement gyro_data[3];
    tiny_mpu6050_get_gyro_data(&mpu_config, gyro_data, TINY_MPU6050_GYRO_RANGE_250DEG);

    /* Calculate (estimate) tilt. */
    get_tilt(accel_data, gyro_data, (float *)(tilt));

    last_tilt_update_time = now;

    /* Update the cooling delay. */
    if (delay > final_delay_us) {
        delay = (absolute_time_t)((float)(delay) / delay_cool_factor);
    } else {
        delay = final_delay_us;
    }

#undef final_delay_us
#undef delay_cool_factor
}

static void gpio_callback(uint gpio, uint32_t events) {
    if (gpio == GYRO_TILT_LED_MPU6050_PIN_INT && (events & GPIO_IRQ_EDGE_FALL)) {
        get_tilt_callback();
    }
}

int main(void) {
    stdio_init_all();

    /* Initialize MPU6050 configuration. */
    tiny_mpu6050_config_apply_default_config(&mpu_config);
    tiny_mpu6050_config_set_i2c_instance(&mpu_config, GYRO_TILT_LED_TINY_MPU6050_I2C_INST);

    /* I2C setup for MPU6050. */
    i2c_init(GYRO_TILT_LED_TINY_MPU6050_I2C_INST, TINY_MPU6050_I2C_BAUDRATE_HZ);
    gpio_init(GYRO_TILT_LED_MPU6050_PIN_SDA);
    gpio_init(GYRO_TILT_LED_MPU6050_PIN_SCL);
    gpio_set_function(GYRO_TILT_LED_MPU6050_PIN_SDA, GPIO_FUNC_I2C);
    gpio_set_function(GYRO_TILT_LED_MPU6050_PIN_SCL, GPIO_FUNC_I2C);
    gpio_pull_up(GYRO_TILT_LED_MPU6050_PIN_SDA);
    gpio_pull_up(GYRO_TILT_LED_MPU6050_PIN_SCL);
    sleep_ms(1000);
    /* */

    gpio_init(GYRO_TILT_LED_MPU6050_PIN_INT);

    while (!tiny_mpu6050_get_is_whoami_valid(&mpu_config)) {
        printf("Could not confirm sensor identity\n");
        sleep_ms(1000);
    }

    /* MPU6050 Configuration. */

    /* Digital low-pass filter: */
    tiny_mpu6050_i2c_write_byte_timeout(
        &mpu_config,
        TINY_MPU6050_REG_26_CONFIG_ADDR_RW,
        ((2 & TINY_MPU6050_REG_26_CONFIG_MASK_DLPF_CFG) << TINY_MPU6050_REG_26_CONFIG_RSH_DLPF_CFG)
    );
    sleep_us(40);

    /* Sample rate divider = 0 (sample rate is 1 kHz): */
    tiny_mpu6050_i2c_write_byte_timeout(
        &mpu_config,
        TINY_MPU6050_REG_25_SAMPLE_RATE_DIV_ADDR_RW,
        ((0 & TINY_MPU6050_REG_25_SAMPLE_MASK) << TINY_MPU6050_REG_25_SAMPLE_RATE_DIV_RSH)
    );
    sleep_us(40);

    /* Gyroscope and accelerometer full scale (sensitivity) ranges: */
    tiny_mpu6050_i2c_write_byte_timeout(
        &mpu_config,
        TINY_MPU6050_REG_27_GYRO_CONFIG_ADDR_RW,
        /* 250 deg/s. */
        (TINY_MPU6050_REG_27_GYRO_CONFIG_VAL_FS_SEL_250DEG
         << TINY_MPU6050_REG_27_GYRO_CONFIG_RSH_FS_SEL)
    );
    sleep_us(40);

    tiny_mpu6050_i2c_write_byte_timeout(
        &mpu_config,
        TINY_MPU6050_REG_28_ACCEL_CONFIG_ADDR_RW,
        /* 2 g/s. */
        (TINY_MPU6050_REG_28_ACCEL_CONFIG_VAL_AFS_SEL_2G
         << TINY_MPU6050_REG_28_ACCEL_CONFIG_RSH_AFS_SEL)
    );
    sleep_us(40);

    /* Interrupt pin: */
    tiny_mpu6050_i2c_write_byte_timeout(
        &mpu_config,
        TINY_MPU6050_REG_55_INT_PIN_CONFIG_ADDR_RW,
        (
            /* INT pin is active low. */
            (TINY_MPU6050_REG_55_INT_PIN_CONFIG_VAL_INT_LEVEL_ACTIVE_HIGH
             << TINY_MPU6050_REG_55_INT_PIN_CONFIG_RSH_INT_LEVEL)

            /* Push-pull (MPU6050 drives the INT pin). */
            | (TINY_MPU6050_REG_55_INT_PIN_CONFIG_VAL_INT_OPEN_PUSHPULL
               << TINY_MPU6050_REG_55_INT_PIN_CONFIG_RSH_INT_OPEN)

            /* INT pin is held high until the interrupt is cleared. */
            | (TINY_MPU6050_REG_55_INT_PIN_CONFIG_VAL_LATCH_INT_EN_PULSE
               << TINY_MPU6050_REG_55_INT_PIN_CONFIG_RSH_LATCH_INT_EN)

            /* Interrupt status is cleared on any read operation. */
            | (TINY_MPU6050_REG_55_INT_PIN_CONFIG_VAL_INT_RD_CLEAR_ON_READ_ANY
               << TINY_MPU6050_REG_55_INT_PIN_CONFIG_RSH_INT_RD_CLEAR)
        )
    );
    sleep_us(40);

    /* Interrupt enable: */
    tiny_mpu6050_i2c_write_byte_timeout(
        &mpu_config,
        TINY_MPU6050_REG_56_INT_ENABLE_ADDR_RW,
        /* When sensor data is ready. */
        ((true & TINY_MPU6050_REG_56_INT_ENABLE_MASK_DATA_READY_EN)
         << TINY_MPU6050_REG_56_INT_ENABLE_RSH_DATA_READY_EN)
    );
    sleep_us(40);

    /* Power management 1: */
    tiny_mpu6050_i2c_write_byte_timeout(
        &mpu_config,
        TINY_MPU6050_REG_107_PWR_MGMT_1_ADDR_RW,
        (
            /* Clear sleep bit. */
            ((false & TINY_MPU6050_REG_107_PWR_MGMT_1_MASK_CYCLE)
             << TINY_MPU6050_REG_107_PWR_MGMT_1_RSH_SLEEP)

            /* Clock source is PLL with X axis gyroscope reference. */
            | (TINY_MPU6050_REG_107_PWR_MGMT_1_VAL_CKLSEL_GYRO_X
               << TINY_MPU6050_REG_107_PWR_MGMT_1_RSH_CLKSEL)
        )
    );
    sleep_us(40);

    /* Power management 2: */
    // tiny_mpu6050_i2c_write_byte_timeout(
    //     &mpu_config,
    //     TINY_MPU6050_REG_108_PWR_MGMT_2_ADDR_RW,
    //     /* Put Z axis gyroscope into standby mode. */
    //     ((true & TINY_MPU6050_REG_108_PWR_MGMT_2_MASK_STBY_ZG)
    //      << TINY_MPU6050_REG_108_PWR_MGMT_2_RSH_STBY_ZG)
    // );
    // sleep_us(40);

    /* */

    /* Set up an interrupt callback to trigger titl recalculation when new
     * sensor data from MPU6050 is ready to be read. */
    sleep_ms(3000);
    gpio_set_irq_enabled_with_callback(
        GYRO_TILT_LED_MPU6050_PIN_INT, GPIO_IRQ_EDGE_FALL, true, &gpio_callback
    );

    absolute_time_t last_print_time = 0;

    while (1) {
        absolute_time_t now = time_us_32();
        if (now - last_print_time > (absolute_time_t)(50 * 1000)) {
            printf("%.4f rad\t", tilt[0]);
            printf("%.4f rad\t", tilt[1]);
            printf("%.4f rad\t", tilt[2]);
            printf("\n");

            last_print_time = now;
        }
    }

    i2c_deinit(GYRO_TILT_LED_TINY_MPU6050_I2C_INST);
    return 0;
}
