/*
 * SPDX-FileCopyrightText: 2025 Kiril V. Strezikozin, Zurab Kvachadze
 *
 * SPDX-License-Identifier: Apache-2.0
 */

#ifndef _ECAVA_ROTARY_ENCODER_EC11_PROGRAM_H
#define _ECAVA_ROTARY_ENCODER_EC11_PROGRAM_H

#include <hardware/clocks.h>
#include <hardware/pio.h>
#include <pico/stdlib.h>

#include "config.h"
#include "hardware.h"

#ifdef PICO_DEFAULT_EC11_IRQ_NUM
#define EC11_IRQ_NUM PICO_DEFAULT_EC11_IRQ_NUM
#else
#define EC11_IRQ_NUM 1
#endif

/* If EC11 rotary encoder program's state machine RX FIFO is not empty, reads a
 * word of data from it, stores it in `ptr`, and returns `true`. If the FIFO is
 * empty, does not modify the value pointed to by `ptr`, and returns `false`.
 *
 * \param c EC11 configuration.
 * \param ptr Pointer to storage to write the data to.
 */
bool ec11_rotary_encoder_program_rx_fifo_pop(ec11_rotary_encoder_config *c, uint32_t *ptr);

/* Initialize EC11 Rotary Encoder configuration by instantiating its driver
 * program and initializing the pins of the encoder it configures.
 *
 * \param c EC11 configuration.
 * \param irq Whether to enable interrupts for knob rotations.
 */
void ec11_rotary_encoder_program_init(ec11_rotary_encoder_config *c, bool irq);

/* Cleanup EC11 Rotary Encoder configuration by unloading its driver program.
 *
 * \param c EC11 configuration.
 */
static inline void ec11_rotary_encoder_program_deinit(const ec11_rotary_encoder_config *c) {
    pio_remove_program_and_unclaim_sm(&ec11_program, c->pio, c->sm, c->offset);
}

/* Initialize the EC11 Rotary Encoder button.
 *
 * \param c EC11 configuration.
 * \param pull_up Whether to use the internal pull up resistor for the GPIO pin
 * associated with the encoder button.
 * \param pull_down Whether to use the internal pull down resistor for the GPIO
 * pin associated with the encoder button.
 * \param irq Whether to enable interrupts for EC11 button presses.
 */
static inline void ec11_rotary_encoder_program_button_init(
    const ec11_rotary_encoder_config *c, bool pull_up, bool pull_down, bool irq
) {
    gpio_init(c->pin_btn);
    gpio_set_pulls(c->pin_btn, pull_up, pull_down);

    if (!irq) return;

    if (pull_up)
        gpio_set_irq_enabled_with_callback(
            c->pin_btn, GPIO_IRQ_EDGE_RISE, true, c->pressed_handler
        );
    else
        gpio_set_irq_enabled_with_callback(
            c->pin_btn, GPIO_IRQ_EDGE_FALL, true, c->pressed_handler
        );
}

/* Get the current EC11 rotary encoder button GPIO state.
 *
 * \param c EC11 configuration.
 * \return Current state of the EC11 button GPIO. 0 for low, non-zero for high.
 */
static inline bool ec11_rotary_encoder_program_button_pin_get(const ec11_rotary_encoder_config *c) {
    return gpio_get(c->pin_btn);
}

#endif /* _ECAVA_ROTARY_ENCODER_EC11_PROGRAM_H */
