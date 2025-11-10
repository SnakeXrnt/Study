
#include "pico/stdlib.h"
#include <stdio.h>


#define LED_PIN 0  

bool timer_callback(struct repeating_timer *t) {
    static bool led_on = false;
    led_on = !led_on;
    gpio_put(LED_PIN, led_on);

    printf("%lld\n", time_us_64());

    return true; 
}

int main() {
    stdio_init_all();

    gpio_init(LED_PIN);
    gpio_set_dir(LED_PIN, true);

    struct repeating_timer timer;
    add_repeating_timer_ms(500, timer_callback, NULL, &timer);

    while (true) {
        tight_loop_contents();
    }
}
