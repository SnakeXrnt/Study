#include "pico/stdlib.h"
#include "hardware/i2c.h"
#include "hardware/spi.h"
#include <hardware/gpio.h>
#include <hardware/structs/io_bank0.h>
#include <stdio.h>
#include <stdint.h>
#include <stdbool.h>

#include "drivers/ambeient.c"
#include "drivers/io_expander.c"
#include "drivers/temperature.c"
#include "drivers/i2c.c"
#include "drivers/spi.c"
#include "drivers/button.c"

#define LIGHT_ADDR 0x52
#define TEMP_ADDR  0x49
#define BUTTON_PIN 15
#define INT_PIN    14
#define OS_PIN 13

#define PIN_CS   17
#define PIN_MISO 16
#define PIN_MOSI 19
#define PIN_SCK  18
#define PIN_SYNC 20

#define PIN_SDA 4 
#define PIN_SCL 5 

// ====== Mode/LED state ======
static volatile uint8_t mode_light = 1;      // 1 = show light, 0 = show temperature
static volatile bool mode_changed = false;
static volatile bool flash_request = false;  // set by INT ISR, handled in main()
static uint8_t last_led_byte = 0x00;    

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

static void gpio_all_irq(uint gpio, uint32_t events) {
    if (gpio == BUTTON_PIN && (events & GPIO_IRQ_EDGE_RISE)) {
        gpio_callback(gpio, events);
    } else if (gpio == INT_PIN && (events & GPIO_IRQ_EDGE_FALL)) {
        flash_request = true;
    } else if (gpio == OS_PIN && (events & GPIO_IRQ_EDGE_FALL)) {
        flash_request = true;
    }
}

int main(void) {
    stdio_init_all();

    initialize_i2c();
    initialize_spi();
    io_exp_write(0x00, 0);
    amb_setup_thresholds(100, 160000, 4);
    
    // *** KEY CHANGE: Initialize interrupt mode and set thresholds ***
    temp_init_interrupt_mode();  // Enable interrupt mode
    temp_set_thresholds(26, 26); // Both thresholds at 26°C for immediate re-trigger
    
    // GPIO setup...
    gpio_init(BUTTON_PIN);
    gpio_set_dir(BUTTON_PIN, GPIO_IN);
    gpio_pull_down(BUTTON_PIN);

    gpio_init(INT_PIN);
    gpio_set_dir(INT_PIN, GPIO_IN);
    gpio_pull_up(INT_PIN);

    gpio_init(OS_PIN);
    gpio_set_dir(OS_PIN, GPIO_IN);
    gpio_pull_up(OS_PIN);

    gpio_set_irq_enabled_with_callback(BUTTON_PIN, 0, true, &gpio_all_irq);
    gpio_set_irq_enabled(BUTTON_PIN, GPIO_IRQ_EDGE_RISE, true);
    gpio_set_irq_enabled(INT_PIN, GPIO_IRQ_EDGE_FALL, true);
    gpio_set_irq_enabled(OS_PIN, GPIO_IRQ_EDGE_FALL, true);

    while (true) {
        if (mode_changed) {
            mode_changed = false;

            if (mode_light) {
                gpio_set_irq_enabled(OS_PIN, GPIO_IRQ_EDGE_FALL, false);
                uint8_t st = amb_read_reg(REG_MAIN_STATUS);
                if (gpio_get(INT_PIN) == 0) {
                    flash_request = true;
                }
                gpio_set_irq_enabled(INT_PIN, GPIO_IRQ_EDGE_FALL, true);
            } else {
                gpio_set_irq_enabled(INT_PIN, GPIO_IRQ_EDGE_FALL, false);
                clear_os();
                if (gpio_get(OS_PIN) == 0) {
                    flash_request = true;
                }
                gpio_set_irq_enabled(OS_PIN, GPIO_IRQ_EDGE_FALL, true);
            }
            printf("Mode: %s\n", mode_light ? "LIGHT" : "TEMPERATURE");
        }

        // *** KEY CHANGE: Handle interrupt and re-arm ***
        if (flash_request) {
            flash_request = false;
            flash_leds_3x();
            clear_interupt();  // For ambient sensor
            
            // For temperature sensor in interrupt mode:
            if (!mode_light) {
                clear_os();  // Clear the interrupt
                
                // Check if temp is still above threshold
                float temp = read_temperature();
                if (temp > 26.0f) {
                    flash_request = true;
                    // Temperature still high - manu ally retrigger
                    // The sensor will generate a new falling edge because
                    // we cleared it while temp is still > Tos
                    sleep_us(100);  // Small delay to ensure edge detection
                }
            }
        }

        if (mode_light) {
            uint32_t light = read_ambeient();
            printf("Light raw: %lu\n", (unsigned long)light);
            last_led_byte = (uint8_t)light;
            io_exp_write(0x09, last_led_byte);
        } else {
            float temp = read_temperature();
            printf("Temperature: %.3f C\n", temp);
            last_led_byte = (uint8_t)temp;
            io_exp_write(0x09, last_led_byte);
        }

        sleep_ms(300);
    }
}
