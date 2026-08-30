#include "pico/stdlib.h"
#include "hardware/i2c.h"
#include <hardware/gpio.h>
#include <hardware/structs/io_bank0.h>
#include <stdio.h>
#include <stdint.h>
#include <stdbool.h>


#define LIGHT_ADDR 0x52
#define PIN_SDA 4 
#define PIN_SCL 5

#define REG_MAIN_CTRL        0x00
#define REG_ALS_MEAS_RATE    0x04
#define REG_ALS_GAIN         0x05
#define REG_MAIN_STATUS      0x07
#define REG_ALS_DATA_0       0x0D
#define REG_INT_CFG          0x19
#define REG_INT_PERSIST      0x1A
#define REG_ALS_THRES_UP_0   0x21
#define REG_ALS_THRES_UP_1   0x22
#define REG_ALS_THRES_UP_2   0x23
#define REG_ALS_THRES_LOW_0  0x24
#define REG_ALS_THRES_LOW_1  0x25
#define REG_ALS_THRES_LOW_2  0x26


static inline void amb_write_reg(uint8_t reg, uint8_t val) {
    uint8_t buffer[2] = { reg, val };
    int n = i2c_write_blocking(i2c_default, LIGHT_ADDR, buffer, 2, false);
    if (n != 2) printf("I2C write reg 0x%02X failed (n=%d)\n", reg, n);
}


static inline uint8_t amb_read_reg(uint8_t reg){
    uint8_t result;
    i2c_write_blocking(i2c_default, LIGHT_ADDR, &reg, 1, true);
    i2c_read_blocking(i2c_default, LIGHT_ADDR, &result, 1, false);
    return result;
}

static void amb_write_regs(uint8_t start_reg, const uint8_t *data, size_t len) {
    uint8_t buf[8];
    buf[0] = start_reg;
    for (size_t i = 0; i < len; ++i) buf[i + 1] = data[i];
    i2c_write_blocking(i2c_default, LIGHT_ADDR, buf, len + 1, false);
}

void set_threshold_low(uint32_t value20bit) {
    uint8_t b[3];
    b[0] = (uint8_t)(value20bit & 0xFF);
    b[1] = (uint8_t)((value20bit >> 8) & 0xFF);
    b[2] = (uint8_t)((value20bit >> 16) & 0x0F);
    amb_write_regs(REG_ALS_THRES_LOW_0, b, 3);
}
void set_threshold_up(uint32_t value20bit) {
    uint8_t b[3];
    b[0] = (uint8_t)(value20bit & 0xFF);
    b[1] = (uint8_t)((value20bit >> 8) & 0xFF);
    b[2] = (uint8_t)((value20bit >> 16) & 0x0F);
    amb_write_regs(REG_ALS_THRES_UP_0, b, 3);
}


static void amb_setup_thresholds(uint32_t low, uint32_t high, uint8_t persist_n_plus_1) {
    uint8_t init_buf[2] = {0x00, 0x02};
    i2c_write_blocking(i2c_default, LIGHT_ADDR, init_buf, 2, false);
    // Resolution/time: 18-bit @100ms -> 0x22
    amb_write_reg(REG_ALS_MEAS_RATE, 0x22);
    // Gain: x3 -> 0x01
    amb_write_reg(REG_ALS_GAIN, 0x01);

    // Program threshold window
    set_threshold_low(low);
    set_threshold_up(high);

    // Persistence (N stored as N-1 in bits [7:4], limit to 0..15)
    uint8_t n = (persist_n_plus_1 == 0) ? 0 : (uint8_t)(persist_n_plus_1 - 1);
    if (n > 0x0F) n = 0x0F;
    amb_write_reg(REG_INT_PERSIST, (uint8_t)(n << 4));

    // INT_CFG: ALS source, threshold mode, enable -> 0x14
    amb_write_reg(REG_INT_CFG, 0x14);

    // Enable ALS engine
    amb_write_reg(REG_MAIN_CTRL, 0x02);

    // Clear any stale interrupt flag
    (void)amb_read_reg(REG_MAIN_STATUS);
}


uint32_t read_ambeient(void) {
    // printf("read ambeient is called \n");
    uint8_t reg = REG_ALS_DATA_0;
    uint8_t data[3];
    i2c_write_blocking(i2c_default, LIGHT_ADDR, &reg, 1, true);
    i2c_read_blocking(i2c_default,  LIGHT_ADDR, data, 3, false);
    uint32_t value = ((uint32_t)(data[2] & 0x0F) << 16) | ((uint32_t)data[1] << 8) | (uint32_t)data[0];
    // printf("%lu \n", (unsigned long)value);
    return value;
}

void clear_interupt(void) {

    uint8_t st = amb_read_reg(REG_MAIN_STATUS);
    printf("INT cleared, status=0x%02X\n", st);
}
