#include "pico/stdlib.h"
#include "hardware/pwm.h"
#include "hardware/irq.h"
#include "pico/sleep.h"
#include "hardware/clocks.h"
#include "hardware/rosc.h"
#include <stdio.h>

#ifdef CYW43_WL_GPIO_LED_PIN
#include "pico/cyw43_arch.h"
#endif

#define LED_DELAY_MS  250
#define EXT_LED_PIN   0
#define SERVO_PIN     2
#define BTN_EXT_LED   16
#define BTN_SERVO     17
#define BTN_INTERNAL  18
#define BTN_SLEEP     19
#define SERVO_ON_US   1000u
#define SERVO_OFF_US  1500u

static bool ext_led_state  = false;
static bool servo_state    = false;
static bool internal_state = false;
static bool sleeping       = false;
static uint servo_slice;

int pico_led_init(void) {
#if defined(PICO_DEFAULT_LED_PIN)
    gpio_init(PICO_DEFAULT_LED_PIN);
    gpio_set_dir(PICO_DEFAULT_LED_PIN, GPIO_OUT);
    return PICO_OK;
#elif defined(CYW43_WL_GPIO_LED_PIN)
    return cyw43_arch_init();
#endif
}

void pico_set_led(bool on) {
#if defined(PICO_DEFAULT_LED_PIN)
    gpio_put(PICO_DEFAULT_LED_PIN, on);
#elif defined(CYW43_WL_GPIO_LED_PIN)
    cyw43_arch_gpio_put(CYW43_WL_GPIO_LED_PIN, on);
#endif
}

void servo_init(void) {
    gpio_set_function(SERVO_PIN, GPIO_FUNC_PWM);
    servo_slice = pwm_gpio_to_slice_num(SERVO_PIN);
    pwm_config config = pwm_get_default_config();
    pwm_config_set_clkdiv(&config, 125.0f);
    pwm_config_set_wrap(&config, 20000);
    pwm_init(servo_slice, &config, true);
    pwm_set_gpio_level(SERVO_PIN, SERVO_OFF_US);
}

void servo_set(bool on) {
    pwm_set_gpio_level(SERVO_PIN, on ? SERVO_ON_US : SERVO_OFF_US);
}

void gpio_callback(uint gpio, uint32_t events) {
    if (!(events & GPIO_IRQ_EDGE_RISE)) return;
    switch (gpio) {
        case BTN_EXT_LED:
            ext_led_state = !ext_led_state;
            gpio_put(EXT_LED_PIN, ext_led_state);
            break;
        case BTN_SERVO:
            servo_state = !servo_state;
            servo_set(servo_state);
            break;
        case BTN_INTERNAL:
            internal_state = !internal_state;
            break;
        case BTN_SLEEP:
            sleeping = true;
            break;
    }
}

void setup_buttons(void) {
    const uint8_t buttons[] = {BTN_EXT_LED, BTN_SERVO, BTN_INTERNAL, BTN_SLEEP};
    for (size_t i = 0; i < sizeof(buttons) / sizeof(buttons[0]); i++) {
        gpio_init(buttons[i]);
        gpio_set_dir(buttons[i], GPIO_IN);
        gpio_pull_down(buttons[i]);
        gpio_set_irq_enabled_with_callback(buttons[i], GPIO_IRQ_EDGE_RISE, true, &gpio_callback);
    }
}

static void enter_dormant(void) {
    gpio_put(EXT_LED_PIN, false);
    servo_set(false);
    pico_set_led(false);
    pwm_set_enabled(servo_slice, false);

    // Switch to XOSC before going dormant
    sleep_run_from_dormant_source(DORMANT_SOURCE_XOSC);

    // Sleep until BTN_SLEEP (GPIO 19) goes high (edge=true, high=true)
    sleep_goto_dormant_until_pin(BTN_SLEEP, true, true);

    // Woke up — use the official power up restore function
    sleep_power_up();

    // Re-enable servo and buttons
    pwm_set_enabled(servo_slice, true);
    setup_buttons();
    sleeping = false;
}

int main() {
    stdio_init_all();
    hard_assert(pico_led_init() == PICO_OK);

    gpio_init(EXT_LED_PIN);
    gpio_set_dir(EXT_LED_PIN, GPIO_OUT);
    servo_init();
    setup_buttons();

    while (true) {
        if (sleeping) {
            enter_dormant();
            continue;
        }
        if (internal_state) {
            pico_set_led(true);
            sleep_ms(LED_DELAY_MS);
            pico_set_led(false);
        }
        sleep_ms(LED_DELAY_MS);
    }
}
