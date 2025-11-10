#include "pico/stdlib.h"
#include "hardware/i2c.h"
#include "hardware/spi.h" 
#include <stdio.h>
#include <stdint.h>
#include <stdbool.h>

#define LIGHT_ADDR 0x52
#define TEMP_ADDR  0x49
#define BUTTON_PIN 15

#define PIN_CS 17 
#define PIN_MISO 16 
#define PIN_MOSI 19
#define PIN_SCK 18 
#define PIN_SYNC 20

static volatile uint8_t mode_light = 1;      // 1 = show light, 0 = show temperature
static volatile bool mode_changed = false;

static inline void cs_select() {
    asm volatile("nop \n nop \n nop");
    gpio_put(PIN_CS, 0);
    asm volatile("nop \n nop \n nop");
}

static inline void cs_deselect() {
    asm volatile("nop \n nop \n nop");
    gpio_put(PIN_CS, 1);
    asm volatile("nop \n nop \n nop");
}

void io_exp_write(uint8_t reg, uint8_t data) {
    uint8_t buf[3];
    buf[0] = 0b01000110; 
    buf[1] = reg;
    buf[2] = data;
    cs_select();
    spi_write_blocking(spi0, buf, 3);
    cs_deselect();

    sleep_ms(10);
}

void gpio_callback(uint gpio, uint32_t events) {
    static uint64_t last_us = 0;
    uint64_t now = time_us_64();
    if (gpio == BUTTON_PIN && (events & GPIO_IRQ_EDGE_RISE)) {
        if (now - last_us > 200000) {  // 200 ms debounce
            mode_light ^= 1;
            mode_changed = true;
            last_us = now;
        }
    }
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


uint32_t read_light_raw(void)
{
    uint8_t reg = 0x0D;
    uint8_t data[3];

    i2c_write_blocking(i2c_default, LIGHT_ADDR, &reg, 1, true);
    i2c_read_blocking(i2c_default, LIGHT_ADDR, data, 3, false);

    uint32_t value = ((uint32_t)(data[2] & 0x0F) << 16) | ((uint32_t)data[1] << 8) | (uint32_t)data[0];
    return value;
}

int main(void)
{
    stdio_init_all();

    // I2C setup on GPIO 4=SDA, 5=SCL
    i2c_init(i2c_default, 100 * 1000);
    gpio_set_function(4, GPIO_FUNC_I2C);
    gpio_set_function(5, GPIO_FUNC_I2C);
    gpio_pull_up(4);
    gpio_pull_up(5);

    spi_init (spi0, 500*1000);
    gpio_set_function(PIN_MISO, GPIO_FUNC_SPI);
    gpio_set_function(PIN_SCK, GPIO_FUNC_SPI);   
    gpio_set_function(PIN_MOSI, GPIO_FUNC_SPI);

    gpio_init(PIN_CS);
    gpio_set_dir(PIN_CS, GPIO_OUT);
    gpio_put(PIN_CS,1);

    io_exp_write(0x00, 0b00);




    // Light sensor example init: write 0x02 to reg 0x00
    uint8_t init_buf[2] = {0x00, 0x02};
    i2c_write_blocking(i2c_default, LIGHT_ADDR, init_buf, 2, false);

    // Button on GPIO 15 to 3.3V with internal pull-down, rising edge interrupt
    gpio_init(BUTTON_PIN);
    gpio_set_dir(BUTTON_PIN, GPIO_IN);
    gpio_pull_down(BUTTON_PIN);
    gpio_set_irq_enabled_with_callback(BUTTON_PIN, GPIO_IRQ_EDGE_RISE, true, &gpio_callback);

    printf("Mode: LIGHT (press button on GPIO 15 to toggle)\n");

    while (true) {
        if (mode_changed) {
            mode_changed = false;
            printf("Mode: %s\n", mode_light ? "LIGHT" : "TEMPERATURE");
        }

        if (mode_light) {
            uint32_t light = read_light_raw();
            printf("Light raw: %lu\n", (unsigned long)light);
            io_exp_write(0x09, (uint8_t)light);

        } else {
            float temp = read_temperature();
            printf("Temperature: %.3f C\n", temp);
            io_exp_write(0x09, (uint8_t)temp);

        }

        sleep_ms(300);
    }
}
