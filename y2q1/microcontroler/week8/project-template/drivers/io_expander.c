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



// IO EXPANDER SECTOR
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
    sleep_ms(2);
}


static void flash_leds_3x(void) {
    for (int i = 0; i < 3; ++i) {
        io_exp_write(0x09, 0xFF); // all ON
        sleep_ms(120);
        io_exp_write(0x09, 0x00); // all OFF
        sleep_ms(120);
    }
}

