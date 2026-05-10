/*
 * SPDX-FileCopyrightText: 2025 Kiril V. Strezikozin, Zurab Kvachadze
 *
 * SPDX-License-Identifier: Apache-2.0
 */

#include <stdio.h>

#include "rotary_encoder/ec11/config.h"
#include "rotary_encoder/ec11/program.h"

#define EC11_PIN_BTN 22
#define EC11_PIN_A   26
#define EC11_PIN_B   18

#define BTN_DEBOUNCE_DELAY_US 10000

/* Callback handlers used for the EC11 Rotary Encoder in this example. */

// See `gpio_irq_callback_t` for parameter description.
static void on_press(uint gpio, uint32_t event_mask)
{
    static absolute_time_t last_press_time = 0;
    const absolute_time_t now = time_us_64();
    
    printf("[DEBUG] Button IRQ triggered on GPIO %d\n", gpio);

    if (now - last_press_time < BTN_DEBOUNCE_DELAY_US) {
        printf("[DEBUG] Button debounce - ignoring\n");
        return;
    }
    last_press_time = now;

    printf("EC11 Rotary Encoder button was pressed\n");
}

static void on_scroll_up(void)
{
    printf("[DEBUG] Scroll UP IRQ triggered\n");
    printf("EC11 Rotary Encoder knob was scrolled up\n");
}

static void on_scroll_down(void)
{
    printf("[DEBUG] Scroll DOWN IRQ triggered\n");
    printf("EC11 Rotary Encoder knob was scrolled down\n");
}

int main()
{
    stdio_init_all();
    
    // Give some time for USB serial to connect
    for(int i = 5; i > 0; i--) {
        printf("Starting in %d...\n", i);
        sleep_ms(1000);
    }

    printf("--- EC11 Rotary Encoder Debug Start ---\n");
    printf("Configured Pins: BTN=%d, A=%d, B=%d\n", EC11_PIN_BTN, EC11_PIN_A, EC11_PIN_B);

    ec11_rotary_encoder_config ec11_config;
    
    printf("[DEBUG] Applying default config for A/B...\n");
    ec11_rotary_encoder_apply_default_config(
        &ec11_config, EC11_PIN_A, EC11_PIN_B
    );
    
    printf("[DEBUG] Setting button pin...\n");
    ec11_rotary_encoder_config_set_pin_btn(&ec11_config, EC11_PIN_BTN);

    printf("[DEBUG] Setting handlers...\n");
    ec11_rotary_encoder_config_set_pressed_handler(&ec11_config, on_press);
    ec11_rotary_encoder_config_set_scroll_down_handler(&ec11_config, on_scroll_down);
    ec11_rotary_encoder_config_set_scroll_up_handler(&ec11_config, on_scroll_up);

    printf("[DEBUG] Initializing PIO program (IRQs enabled)...\n");
    ec11_rotary_encoder_program_init(&ec11_config, true);

    printf("[DEBUG] Initializing Button (Internal Pull-up, IRQs enabled)...\n");
    ec11_rotary_encoder_program_button_init(
        &ec11_config,
        true,  /* Pull up */
        false, /* Pull down */
        true   /* Enable IRQs */
    );

    printf("--- Initialization Complete. Waiting for input... ---\n");

    while (true) {
        // Optional: heartbeat to show the Pico is still alive
        static uint32_t last_heartbeat = 0;
        if (time_us_32() - last_heartbeat > 5000000) {
            printf("[HEARTBEAT] System running, waiting for encoder movement...\n");
            last_heartbeat = time_us_32();
        }
        tight_loop_contents();
    }

    // Unload the State machine program from the PIO assigned to the EC11
    // Rotary Encoder pins. The State machine acquired during initialization
    // will become available for others to use, and the EC11 Rotary Encoder
    // driver instruction program will be unloaded from its memory.
    ec11_rotary_encoder_program_deinit(&ec11_config);
}
