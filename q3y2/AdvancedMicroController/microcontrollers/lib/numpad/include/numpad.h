#ifndef NUMPAD_H
#define NUMPAD_H

#include <stdint.h>
#include <stdbool.h>
#include "pico/stdlib.h"

#define NUM_ROWS 3
#define NUM_COLS 4

void numpad_init(void);
void numpad_scan(uint8_t* keycodes, uint8_t* keys_pressed, uint16_t* consumer_usage, bool* matrix_changed);
bool numpad_get_key_state(uint8_t row, uint8_t col);

#endif
