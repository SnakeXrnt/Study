/*
 * SPDX-FileCopyrightText: 2021 Copyright (c) 2021 Pimoroni Ltd.
 * SPDX-FileCopyrightText: 2025 Kiril V. Strezikozin, Zurab Kvachadze
 *
 * SPDX-License-Identifier: Apache-2.0
 *
 * Portions of this file, namely the PIO State machine Clock division and the
 * IRQ hardware trigger status, were derived from:
 *   - Pimoroni Pico Encoder, authored by Christopher Parrott,
 *     Pimoroni Ltd in 2021, licensed under MIT.
 * See the README file for more details.
 */

// This library does not implement the functionality to operate
// multiple EC11 rotary encoders. Each consequent initialization overwrites
// the callback handlers used by the previous.

#include <pico/stdlib.h>

#include <hardware/clocks.h>
#include <hardware/pio.h>

#include "rotary_encoder/ec11/config.h"
#include "rotary_encoder/ec11/hardware.h"
#include "rotary_encoder/ec11/program.h"

// Interrupt handlers do not accept user data (arguments). Hence, the active
// EC11 rotary encoder configuration is tracked globally in this file.
static ec11_rotary_encoder_config *ec11_config;

#if (EC11_IRQ_NUM != 0 && EC11_IRQ_NUM != 1)
#error Attempting to use unsupported EC11_IRQ_NUM
#endif

/* EC11 Rotary Encoder internal interrupt status handler.
 *
 * Calls the corresponding scroll callback handlers configured by the EC11
 * configuration passed during program initialization.
 */
static void __isr ec11_inte_handler(void) {
    if (pio_sm_get(ec11_config->pio, ec11_config->sm) == EC11_DEFAULT_CLOCKWISE_DIRECTION) {
        ec11_config->scroll_down_handler();
    } else {
        ec11_config->scroll_up_handler();
    }
}

bool ec11_rotary_encoder_program_rx_fifo_pop(ec11_rotary_encoder_config *c, uint32_t *ptr) {
    if (pio_sm_is_rx_fifo_empty(c->pio, c->sm)) return false;
    *ptr = pio_sm_get(c->pio, c->sm);
    return true;
}

void ec11_rotary_encoder_program_init(ec11_rotary_encoder_config *c, bool irq) {
    ec11_config = c;

    hard_assert(pio_claim_free_sm_and_add_program(
        &ec11_program, &ec11_config->pio, &ec11_config->sm, &ec11_config->offset
    ));

    pio_sm_config sm_config = ec11_program_get_default_config(c->offset);

    // Encoder pins have to be pulled up. Internal Pico pull-up resistors are
    // used for the Encoder's A and B pins.
    gpio_pull_up(c->pin_a);
    gpio_pull_up(c->pin_b);

    // Initialize input pins.
    pio_sm_set_pindirs_with_mask(c->pio, c->sm, 0, (1u << c->pin_a) | (1u << c->pin_b));

    pio_gpio_init(c->pio, c->pin_a);
    pio_gpio_init(c->pio, c->pin_b);

    sm_config_set_in_pins(&sm_config, c->pin_b);
    sm_config_set_jmp_pin(&sm_config, c->pin_a);
    sm_config_set_in_shift(&sm_config, false, true, 1);
    sm_config_set_fifo_join(&sm_config, PIO_FIFO_JOIN_RX);

    sm_config_set_clkdiv_int_frac(&sm_config, c->freq_div, 0);

    if (irq) {
        // Trigger the PIO interrupt request when the
        // State machine's RX FIFO is full. This happens when the encoder's
        // knob has been rotated, thus transmitting a signal to the program
        // where it is converted into the rotation direction.
        hw_set_bits(
            __CONCAT(&ec11_config->pio->inte, EC11_IRQ_NUM),  // inte0 or inte1
            // Which sm. PIO_IRQ0_INTE_SM0_RXNEMPTY_BITS and
            // PIO_IRQ1_INTE_SM0_RXNEMPTY_BITS are identical.
            PIO_IRQ0_INTE_SM0_RXNEMPTY_BITS << c->sm
        );

#ifdef EC11_IRQ_SHARED
        irq_add_shared_handler(
            pio_get_irq_num(c->pio, EC11_IRQ_NUM),
            ec11_inte_handler,
            PICO_SHARED_IRQ_HANDLER_DEFAULT_ORDER_PRIORITY
        );
#else
        irq_set_exclusive_handler(pio_get_irq_num(c->pio, EC11_IRQ_NUM), ec11_inte_handler);
#endif

        irq_set_enabled(pio_get_irq_num(c->pio, EC11_IRQ_NUM), true);
    }

    pio_sm_init(c->pio, c->sm, c->offset, &sm_config);
    pio_sm_set_enabled(c->pio, c->sm, true);
}
