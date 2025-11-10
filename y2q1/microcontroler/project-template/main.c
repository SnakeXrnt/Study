#include "pico/stdlib.h" // Standard library for Pico
#include "stdio.h"

int main() {
    stdio_init_all(); // needed for picotool to autoload

    // Set up the LED pin 15 / physical pin 20
    const uint LED_PIN = 15;
    gpio_init(LED_PIN);
    gpio_set_dir(LED_PIN, GPIO_OUT);

    // Never-ending superloop
    while (true) {
        gpio_put(LED_PIN, true);
		printf("on ");
        sleep_ms(1000);
        gpio_put(LED_PIN, false);
		printf("off ");
        sleep_ms(1000);
    }
}