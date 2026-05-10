#include <stdio.h>
#include <string.h>
#include "pico/stdlib.h"
#include "bsp/board.h"
#include "tusb.h"
#include "class/hid/hid.h"
#include "usb_descriptors.h"
#include "rotary_encoder/ec11/config.h"
#include "rotary_encoder/ec11/program.h"

#define NUM_ROWS 3
#define NUM_COLS 4

// Pin definitions from memory
#define EC11_PIN_BTN 22
#define EC11_PIN_A 26
#define EC11_PIN_B 18

const uint rowPins[NUM_ROWS] = {2, 4, 6};     
const uint colPins[NUM_COLS] = {16, 15, 10, 8};         
const uint8_t keyboard_keymap[NUM_ROWS][NUM_COLS] = {
    {HID_KEY_9, HID_KEY_6, HID_KEY_3, HID_KEY_NONE},
    {HID_KEY_8, HID_KEY_5, HID_KEY_2, HID_KEY_NONE},
    {HID_KEY_7, HID_KEY_4, HID_KEY_1, HID_KEY_NONE},
};

const uint16_t consumer_keymap[NUM_ROWS][NUM_COLS] = {
    {0, 0, 0, HID_USAGE_CONSUMER_SCAN_NEXT},
    {0, 0, 0, HID_USAGE_CONSUMER_PLAY_PAUSE},
    {0, 0, 0, HID_USAGE_CONSUMER_SCAN_PREVIOUS},
};

// Track current key states
bool key_states[NUM_ROWS][NUM_COLS] = {0};

// Encoder state
volatile int8_t vol_change = 0;
volatile bool mute_req = false;

// Encoder handlers
void scroll_up_handler(void) {
    vol_change--;
}

void scroll_down_handler(void) {
    vol_change++;
}

void btn_handler(uint gpio, uint32_t events) {
    static uint32_t last_press_time = 0;
    uint32_t current_time = to_ms_since_boot(get_absolute_time());
    
    if (events & GPIO_IRQ_EDGE_FALL) { // Press (Active low)
        if (current_time - last_press_time > 200) { // 200ms debounce
            mute_req = true;
            last_press_time = current_time;
        }
    }
}

int main() {
    board_init();
    tusb_init();

    // Initialize Matrix Pins
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

    // Initialize EC11 Encoder
    static ec11_rotary_encoder_config ec11_conf;
    ec11_rotary_encoder_apply_default_config(&ec11_conf, EC11_PIN_A, EC11_PIN_B);
    ec11_rotary_encoder_config_set_pin_btn(&ec11_conf, EC11_PIN_BTN);
    ec11_rotary_encoder_config_set_scroll_up_handler(&ec11_conf, scroll_up_handler);
    ec11_rotary_encoder_config_set_scroll_down_handler(&ec11_conf, scroll_down_handler);
    ec11_rotary_encoder_config_set_pressed_handler(&ec11_conf, btn_handler);
    
    ec11_rotary_encoder_program_init(&ec11_conf, true);
    
    // Custom button init to ensure FALL edge (press) triggers for pull-up configuration
    gpio_init(EC11_PIN_BTN);
    gpio_pull_up(EC11_PIN_BTN);
    gpio_set_irq_enabled_with_callback(EC11_PIN_BTN, GPIO_IRQ_EDGE_FALL, true, btn_handler);

    uint16_t last_consumer_report = 0;
    bool encoder_active = false;

    while (true) {
        tud_task();

        if (!tud_mounted()) continue;

        if (tud_hid_ready()) {
            bool current_states[NUM_ROWS][NUM_COLS] = {0};
            uint8_t keycodes[6] = {0}; 
            uint8_t keys_pressed = 0;
            uint16_t consumer_usage = 0;
            bool matrix_changed = false;

            // Scan matrix
            for (uint row = 0; row < NUM_ROWS; row++) {
                gpio_put(rowPins[row], 0);
                sleep_us(10);
                
                for (uint col = 0; col < NUM_COLS; col++) {
                    bool pressed = !gpio_get(colPins[col]);
                    current_states[row][col] = pressed;

                    if (pressed) {
                        if (consumer_keymap[row][col] != 0) {
                            consumer_usage = consumer_keymap[row][col];
                        } else if (keys_pressed < 6) {
                            keycodes[keys_pressed] = keyboard_keymap[row][col];
                            keys_pressed++;
                        }
                    }

                    if (pressed != key_states[row][col]) {
                        matrix_changed = true;
                    }
                }
                gpio_put(rowPins[row], 1);
            }

            if (matrix_changed) {
                tud_hid_keyboard_report(REPORT_ID_KEYBOARD, 0, keycodes);
                for (uint row = 0; row < NUM_ROWS; row++) {
                    for (uint col = 0; col < NUM_COLS; col++) {
                        key_states[row][col] = current_states[row][col];
                    }
                }
            }

            // Combine Matrix and Encoder consumer reports
            uint16_t current_consumer_report = consumer_usage;

            if (current_consumer_report == 0) {
                if (encoder_active) {
                    // Send release report
                    current_consumer_report = 0;
                    encoder_active = false;
                } else if (vol_change > 0) {
                    current_consumer_report = HID_USAGE_CONSUMER_VOLUME_INCREMENT;
                    vol_change--;
                    encoder_active = true;
                } else if (vol_change < 0) {
                    current_consumer_report = HID_USAGE_CONSUMER_VOLUME_DECREMENT;
                    vol_change++;
                    encoder_active = true;
                } else if (mute_req) {
                    current_consumer_report = HID_USAGE_CONSUMER_MUTE;
                    mute_req = false;
                    encoder_active = true;
                }
            }

            if (current_consumer_report != last_consumer_report || encoder_active) {
                tud_hid_report(REPORT_ID_CONSUMER_CONTROL, &current_consumer_report, sizeof(current_consumer_report));
                last_consumer_report = current_consumer_report;
            }
        }
    }
    return 0;
}

// HID Callbacks
uint16_t tud_hid_get_report_cb(uint8_t instance, uint8_t report_id, hid_report_type_t report_type, uint8_t* buffer, uint16_t reqlen) {
    (void) instance; (void) report_id; (void) report_type; (void) buffer; (void) reqlen;
    return 0;
}

void tud_hid_set_report_cb(uint8_t instance, uint8_t report_id, hid_report_type_t report_type, uint8_t const* buffer, uint16_t bufsize) {
    (void) instance; (void) report_id; (void) report_type; (void) buffer; (void) bufsize;
}
