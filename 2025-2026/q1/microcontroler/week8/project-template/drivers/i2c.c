#include "pico/stdlib.h"
#include "hardware/i2c.h"
#include <hardware/gpio.h>
#include <hardware/structs/io_bank0.h>
#include <stdio.h>
#include <stdint.h>
#include <stdbool.h>

#define PIN_SDA 4 
#define PIN_SCL 5 

void initialize_i2c(void) {
    i2c_init(i2c_default, 100 * 1000);
    gpio_set_function(PIN_SDA, GPIO_FUNC_I2C);
    gpio_set_function(PIN_SCL, GPIO_FUNC_I2C);
    gpio_pull_up(PIN_SDA);
    gpio_pull_up(PIN_SCL);
}

