/*
 * SPDX-FileCopyrightText: 2025 Kiril V. Strezikozin, Zurab Kvachadze
 *
 * SPDX-License-Identifier: Apache-2.0
 */

#ifndef _ECAVA_ROTARY_ENCODER_EC11_CONFIG_H
#define _ECAVA_ROTARY_ENCODER_EC11_CONFIG_H

#include <hardware/pio.h>
#include <pico/stdlib.h>

// See `ec11_rotary_encoder_config_set_freq_div` for description.
#ifndef EC11_DEFAULT_CLK_FREQUENCY_DIVIDER
#define EC11_DEFAULT_CLK_FREQUENCY_DIVIDER 5000
#endif

// See `ec11_rotary_encoder_config_set_cw_dir` for description.
#ifndef EC11_DEFAULT_CLOCKWISE_DIRECTION
#define EC11_DEFAULT_CLOCKWISE_DIRECTION 1
#endif

/* EC11 Rotary Encoder configuration.
 *
 * A rotary encoder has to be configured. Use the provided helper
 * functions to set up configurations structures.
 */
typedef struct {
    PIO pio;        // PIO instance used.
    uint sm;        // State machine configured on `pio`.
    uint offset;    // Where PIO program is loaded in PIO's 5-bit address space.

    uint pin_a;     // GPIO pin Pin A of the rotary encoder is connected to.
    uint pin_b;     // GPIO pin Pin B of the rotary encoder is connected to.
    uint pin_btn;   // GPIO pin for the button terminal is connected to.

    uint freq_div;  // Encoder PIO program clock frequency divider.
    bool cw_dir;    // Clockwise direction. 0 when flipped.

    // Callback handlers.
    gpio_irq_callback_t pressed_handler;
    irq_handler_t scroll_down_handler;
    irq_handler_t scroll_up_handler;
} ec11_rotary_encoder_config;

// clang-format off
static inline void ec11_rotary_encoder_config_set_pin_a(ec11_rotary_encoder_config *c, uint pin_a) { c->pin_a = pin_a; }
static inline void ec11_rotary_encoder_config_set_pin_b(ec11_rotary_encoder_config *c, uint pin_b) { c->pin_b = pin_b; }
static inline void ec11_rotary_encoder_config_set_pin_btn(ec11_rotary_encoder_config *c, uint pin_btn) { c->pin_btn = pin_btn; }
static inline void ec11_rotary_encoder_config_set_pio(ec11_rotary_encoder_config *c, PIO pio) { c->pio = pio; }
static inline void ec11_rotary_encoder_config_set_sm(ec11_rotary_encoder_config *c, uint sm) { c->sm = sm; }
static inline void ec11_rotary_encoder_config_set_offset(ec11_rotary_encoder_config *c, uint offset) { c->offset = offset; }
// clang-format on

/* Set clock frequency divider for the given EC11 Rotary Encoder
 * configuration.
 *
 * The Encoder PIO program's clock is slowed down by the given factor.
 * A balanced value that reduces noise in the readings can be determined
 * through testing.
 *
 * \param c Pointer to EC11 configuration to modify.
 * \param freq_div Clock frequency divider.
 */
static inline void ec11_rotary_encoder_config_set_freq_div(
    ec11_rotary_encoder_config *c, uint freq_div
) {
    c->freq_div = freq_div;
}

/* Set clockwise direction for the given EC11 Rotary Encoder configuration.
 *
 * If the direction of the encoder knob is flipped,
 * swap the wiring or pass 0 to this function.
 *
 * \param c Pointer to EC11 configuration to modify.
 * \param cw_diw Clockwise direction. 0 to flip.
 */
static inline void ec11_rotary_encoder_config_set_cw_dir(
    ec11_rotary_encoder_config *c, bool cw_dir
) {
    c->cw_dir = cw_dir;
}

/* Set the callback handler to call when the button of the EC11 this
 * configuration is used for is pressed.
 *
 * \param c Pointer to EC11 configuration to modify.
 * \param pressed_handler Callback handler.
 */
static inline void ec11_rotary_encoder_config_set_pressed_handler(
    ec11_rotary_encoder_config *c, gpio_irq_callback_t pressed_handler
) {
    c->pressed_handler = pressed_handler;
}

/* Set the callback handler to call when the knob of the EC11 this
 * configuration is used for is rotated in the configured clockwise direction.
 *
 * \param c Pointer to EC11 configuration to modify.
 * \param scroll_down_handler Callback handler.
 */
static inline void ec11_rotary_encoder_config_set_scroll_down_handler(
    ec11_rotary_encoder_config *c, irq_handler_t scroll_down_handler
) {
    c->scroll_down_handler = scroll_down_handler;
}

/* Set the callback handler to call when the knob of the EC11 this
 * configuration is used for is rotated in the counter-clockwise direction.
 *
 * \param c Pointer to EC11 configuration to modify.
 * \param scroll_up_handler Callback handler.
 */
static inline void ec11_rotary_encoder_config_set_scroll_up_handler(
    ec11_rotary_encoder_config *c, irq_handler_t scroll_up_handler
) {
    c->scroll_up_handler = scroll_up_handler;
}

/* No-op callback handler. EC11 callback can be set to this function if its
 * functionality will not be used.
 */
static void ec11_rotary_encoder_noop_handler(void) {}

/* Apply default EC11 Rotary Encoder configuration.
 *
 * \param c Pointer to EC11 configuration to modify.
 * \param pin_a GPIO pin A of the EC11.
 * \param pin_b GPIO pin B of the EC11.
 */
static inline void ec11_rotary_encoder_apply_default_config(
    ec11_rotary_encoder_config *c, uint pin_a, uint pin_b
) {
    ec11_rotary_encoder_config_set_pin_a(c, pin_a);
    ec11_rotary_encoder_config_set_pin_b(c, pin_b);
    ec11_rotary_encoder_config_set_freq_div(c, EC11_DEFAULT_CLK_FREQUENCY_DIVIDER);
    ec11_rotary_encoder_config_set_cw_dir(c, EC11_DEFAULT_CLOCKWISE_DIRECTION);

    // By default, no-op handler are set.
    ec11_rotary_encoder_config_set_pressed_handler(
        c, (gpio_irq_callback_t)ec11_rotary_encoder_noop_handler
    );
    ec11_rotary_encoder_config_set_scroll_down_handler(c, ec11_rotary_encoder_noop_handler);
    ec11_rotary_encoder_config_set_scroll_up_handler(c, ec11_rotary_encoder_noop_handler);
}

#endif /* _ECAVA_ROTARY_ENCODER_EC11_CONFIG_H */
