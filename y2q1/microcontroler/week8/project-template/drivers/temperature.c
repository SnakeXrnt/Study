#include "pico/stdlib.h"
#include "hardware/i2c.h"
#include "hardware/spi.h"
#include <hardware/gpio.h>
#include <hardware/structs/io_bank0.h>
#include <stdio.h>
#include <stdint.h>
#include <stdbool.h>


#define TEMP_ADDR  0x49
#define PIN_SDA 4 
#define PIN_SCL 5


#define REG_TOS 0x03 // upper treshold 
#define REG_THYST 0x02 // lower treshold
#define REG_TEMP 0X00

// In your temperature.c driver:

void temp_init_interrupt_mode(void) {
    // Configuration register: 0x02 = interrupt mode (bit 1 = 1)
    uint8_t config_data[2] = {0x01, 0x02};  // Reg pointer 0x01, config byte 0x02
    i2c_write_blocking(i2c_default, TEMP_ADDR, config_data, 2, false);
}

void temp_set_thresholds(int temp_low, int temp_high) {
    // Convert to LM75B format: 0.5°C per LSB, left-shifted 7 bits
    uint16_t low_raw = (uint16_t)(temp_low * 2) << 7;
    uint16_t high_raw = (uint16_t)(temp_high * 2) << 7;
    
    uint8_t thyst[2] = {(low_raw >> 8) & 0xFF, low_raw & 0xFF};
    uint8_t tos[2] = {(high_raw >> 8) & 0xFF, high_raw & 0xFF};
    
    uint8_t buffer[3];
    
    // Write Thyst
    buffer[0] = REG_THYST;
    buffer[1] = thyst[0];
    buffer[2] = thyst[1];
    i2c_write_blocking(i2c_default, TEMP_ADDR, buffer, 3, false);
    
    // Write Tos
    buffer[0] = REG_TOS;
    buffer[1] = tos[0];
    buffer[2] = tos[1];
    i2c_write_blocking(i2c_default, TEMP_ADDR, buffer, 3, false);
}

void clear_os(void) {
    // Reading ANY register clears the OS interrupt
    uint8_t reg = 0x01;  // Config register
    uint8_t buf;
    i2c_write_blocking(i2c_default, TEMP_ADDR, &reg, 1, true);
    i2c_read_blocking(i2c_default, TEMP_ADDR, &buf, 1, false);
}
float read_temperature(void)
{
    uint8_t reg = 0x00;
    uint8_t buf[2];

    i2c_write_blocking(i2c_default, TEMP_ADDR, &reg, 1, true);
    i2c_read_blocking(i2c_default, TEMP_ADDR, buf, 2, false);

    int16_t raw = (int16_t)((buf[0] << 8) | buf[1]);
    raw >>= 5;
    if (raw & 0x0400) raw |= 0xF800;

    return raw * 0.125f;
}
