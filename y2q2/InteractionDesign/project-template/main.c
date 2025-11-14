#include "pico/stdlib.h"
#include "hardware/adc.h"
#include <stdio.h>

int main() {
    stdio_init_all();    // Initialize stdio (USB serial output)
    adc_init();          // Initialize the ADC hardware
    adc_gpio_init(26);   // Enable GPIO26 (ADC0)
    adc_select_input(0); // Select ADC0 as input channel

    while (true) {
        uint16_t raw = adc_read();             // Read raw 12-bit ADC value (0–4095)
        float voltage = raw * 3.3f / 4095.0f;  // Convert to voltage (assuming 3.3V reference)

        printf("ADC0 Voltage: %.2f V\n", voltage);

        sleep_ms(500); // Delay 500ms
    }
}
