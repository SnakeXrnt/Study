
#include "pico/stdlib.h"
#include "hardware/spi.h"
#include <hardware/gpio.h>
#include <hardware/structs/io_bank0.h>
#include <stdio.h>
#include <stdint.h>
#include <stdbool.h>

#define PIN_CS   17
#define PIN_MISO 16
#define PIN_MOSI 19
#define PIN_SCK  18
#define PIN_SYNC 20

void initialize_spi(void) {
    spi_init(spi0,500 * 10000);
    gpio_set_function(PIN_MISO, GPIO_FUNC_SPI);
    gpio_set_function(PIN_SCK, GPIO_FUNC_SPI);
    gpio_set_function(PIN_MOSI, GPIO_FUNC_SPI);
    gpio_init(PIN_CS);
    gpio_set_dir(PIN_CS, GPIO_OUT);
    gpio_put(PIN_CS, 1);
}
   
