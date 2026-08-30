#include "numpad.h"
#include "class/hid/hid.h"

static const uint rowPins[NUM_ROWS] = {2, 4, 6};     
static const uint colPins[NUM_COLS] = {16, 15, 10, 8};         

// Physical Layout Mapping:
// Column 4: [G4: Prev]  [G8: Play]  [G12: Next]
// Column 3: [G3: F1]    [G7: F2]    [G11: F3]   (Shortcuts for Browser, Term, VSCode)
// Column 1&2: Numbers
static const uint8_t keyboard_keymap[NUM_ROWS][NUM_COLS] = {
    {HID_KEY_9, HID_KEY_6, HID_KEY_F1, HID_KEY_NONE}, // Row 0: Grid 1, 2, 3, 4
    {HID_KEY_8, HID_KEY_5, HID_KEY_F2, HID_KEY_NONE}, // Row 1: Grid 5, 6, 7, 8
    {HID_KEY_7, HID_KEY_4, HID_KEY_F3, HID_KEY_NONE}, // Row 2: Grid 9, 10, 11, 12
};

static const uint16_t consumer_keymap[NUM_ROWS][NUM_COLS] = {
    {0, 0, 0, HID_USAGE_CONSUMER_SCAN_PREVIOUS},     // Grid 4
    {0, 0, 0, HID_USAGE_CONSUMER_PLAY_PAUSE},       // Grid 8
    {0, 0, 0, HID_USAGE_CONSUMER_SCAN_NEXT},         // Grid 12
};

static bool key_states[NUM_ROWS][NUM_COLS] = {0};
static bool debounced_states[NUM_ROWS][NUM_COLS] = {0};
static uint32_t last_state_change[NUM_ROWS][NUM_COLS] = {0};
#define DEBOUNCE_MS 20

void numpad_init(void) {
    for (uint i = 0; i < NUM_ROWS; i++) {
        gpio_init(rowPins[i]);
        gpio_set_dir(rowPins[i], GPIO_OUT);
        gpio_put(rowPins[i], 1); 
    }
    
    for (uint i = 0; i < NUM_COLS; i++) {
        gpio_init(colPins[i]);
        gpio_set_dir(colPins[i], GPIO_IN);
        gpio_pull_up(colPins[i]);
    }
}

void numpad_scan(uint8_t* keycodes, uint8_t* keys_pressed, uint16_t* consumer_usage, bool* matrix_changed) {
    *keys_pressed = 0;
    *consumer_usage = 0;
    *matrix_changed = false;
    uint32_t now = to_ms_since_boot(get_absolute_time());

    for (uint row = 0; row < NUM_ROWS; row++) {
        gpio_put(rowPins[row], 0);
        sleep_us(10);
        
        for (uint col = 0; col < NUM_COLS; col++) {
            bool raw_pressed = !gpio_get(colPins[col]);

            if (raw_pressed != key_states[row][col]) {
                key_states[row][col] = raw_pressed;
                last_state_change[row][col] = now;
            } else if (raw_pressed != debounced_states[row][col]) {
                if (now - last_state_change[row][col] >= DEBOUNCE_MS) {
                    debounced_states[row][col] = raw_pressed;
                    *matrix_changed = true;
                }
            }

            if (debounced_states[row][col]) {
                if (consumer_keymap[row][col] != 0) {
                    *consumer_usage = consumer_keymap[row][col];
                } else if (keyboard_keymap[row][col] != HID_KEY_NONE) {
                    if (*keys_pressed < 6) {
                        keycodes[*keys_pressed] = keyboard_keymap[row][col];
                        (*keys_pressed)++;
                    }
                }
            }
        }
        gpio_put(rowPins[row], 1);
    }
}

bool numpad_get_key_state(uint8_t row, uint8_t col) {
    if (row >= NUM_ROWS || col >= NUM_COLS) return false;
    return debounced_states[row][col];
}
