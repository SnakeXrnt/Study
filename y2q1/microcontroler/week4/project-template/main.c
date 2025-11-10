#include "hardware/spi.h"
#include "pico/stdlib.h"
#include <hardware/structs/io_bank0.h>
#include "hardware/adc.h"
#include <stdint.h>
#include <stdio.h>

#define PIN_CS 17 
#define PIN_MISO 16 
#define PIN_MOSI 19
#define PIN_SCK 18 
#define PIN_SYNC 20

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

static inline void sync_select() {
    asm volatile("nop \n nop \n nop");
    gpio_put(PIN_SYNC, 0);
    asm volatile("nop \n nop \n nop");
}

static inline void sync_deselect() {
    asm volatile("nop \n nop \n nop");
    gpio_put(PIN_SYNC, 1);
    asm volatile("nop \n nop \n nop");
}

void dac_write(uint8_t data) {
    uint8_t buf[2];
    buf[0] = (data & 0b11000000) >> 6; 
    buf[1] = data << 2;
    sync_select();
    spi_write_blocking(spi0, buf, 3);
    sync_deselect();

    sleep_ms(10);
}

// 0b11100001 = data
// 0b00000011
// 0b10000100
//
// (data & 0b11000000) >> 6
// data << 2


int main() {
    stdio_init_all();
    spi_init (spi0, 500*1000);
    gpio_set_function(PIN_MISO, GPIO_FUNC_SPI);
    gpio_set_function(PIN_SCK, GPIO_FUNC_SPI);   
    gpio_set_function(PIN_MOSI, GPIO_FUNC_SPI);

    gpio_init(PIN_CS);
    gpio_set_dir(PIN_CS, GPIO_OUT);
    gpio_put(PIN_CS,1);

    gpio_init(PIN_SYNC);
    gpio_set_dir(PIN_SYNC, GPIO_OUT);
    gpio_put(PIN_SYNC,1);


    adc_init();
    adc_gpio_init(26);
    adc_select_input(0);

    
    io_exp_write(0x00, 0b00);
    uint8_t value = 0;
    while(1) {
        dac_write(value);
        uint16_t raw = adc_read(); 
        float voltage = (raw * 3.3f) / 4095.0f;
        float expected_voltage = (value / 255.0f) * 1.6f;
        // printf("value : %d | voltage : %.3f | expected_voltage : %.3f \n", value, voltage, expected_voltage);
        printf("%d,%.3f,%.3f\n", value, voltage, expected_voltage);
        uint8_t voltage_value = (voltage / 1.6f) * 255;
        io_exp_write(0x09, voltage_value);

        value++;
        
        
        sleep_ms(50);
    }
}
