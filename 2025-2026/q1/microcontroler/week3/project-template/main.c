
#include "pico/stdlib.h"
#include <hardware/gpio.h>
#include "hardware/adc.h"
#include "hardware/uart.h"


#define UART_ID uart0
#define BAUD_RATE 9600

#define UART_TX_PIN 0
#define UART_RX_PIN 1


const uint LED_PINS[4] = {5, 6, 7, 8};

#define LED_MASK (1 << LED_PINS[0]) | (1 << LED_PINS[1]) | (1 << LED_PINS[2]) | (1 << LED_PINS[3])

#define POT_ADC_CH 0

void set_leds(uint8_t value) {
    uint32_t mask = ((value & 0x1)<< 5) |  ((value & 0x2) << 5) |  ((value & 0x4) << 5) | ((value & 0x8) << 5);   
    
    gpio_put_masked(LED_MASK, mask);
}

void on_uart_rx() {
    while (uart_is_readable(UART_ID)) {
        uint8_t val = uart_getc(UART_ID);
        set_leds(val & 0x1F); 
    }
}

int main() {
    stdio_init_all();

    for (int i = 0; i < 4; i++) {
        gpio_init(LED_PINS[i]);
        gpio_set_dir(LED_PINS[i], true);
    }

    uart_init(UART_ID, BAUD_RATE);
    gpio_set_function(UART_TX_PIN, GPIO_FUNC_UART);
    gpio_set_function(UART_RX_PIN, GPIO_FUNC_UART);

    irq_set_exclusive_handler(UART0_IRQ, on_uart_rx);
    irq_set_enabled(UART0_IRQ, true);
    uart_set_irq_enables(UART_ID, true, false);

    adc_init();
    adc_gpio_init(26);
    adc_select_input(POT_ADC_CH);

    while (true) {
        uint16_t raw = adc_read();
        uint8_t msb5 = raw >> 7;  
        uart_putc_raw(UART_ID, msb5);
        set_leds(msb5);
        sleep_ms(501);
    }
}
