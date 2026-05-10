#include <stdio.h>
#include <string.h>
#include "pico/stdlib.h"
#include "bsp/board.h"
#include "tusb.h"
#include "class/hid/hid.h"
#include "usb_descriptors.h"
#include "rotary_encoder/ec11/config.h"
#include "rotary_encoder/ec11/program.h"
#include "numpad.h"
#include "ssd1306.h"
#include "font.h"
#include "hardware/i2c.h"

// Pin definitions from memory
#define EC11_PIN_BTN 22
#define EC11_PIN_A 26
#define EC11_PIN_B 18

// I2C definitions for OLED
#define I2C_PORT i2c0
#define I2C_SDA 12
#define I2C_SCL 13

// Encoder state
volatile int8_t vol_change = 0;
volatile bool mute_req = false;
static bool is_muted = false;

// Display state
static ssd1306_t disp;
static uint32_t status_msg_timeout = 0;
static char status_msg[16] = "";
static bool oled_initialized = false;

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

void draw_grid() {
    if (!oled_initialized) return;

    ssd1306_clear(&disp);

    for (int row = 0; row < 3; row++) {
        for (int col = 0; col < 4; col++) {
            int x = (3 - col) * 31;
            int y = (2 - row) * 21;

            bool pressed = numpad_get_key_state(row, col);
            if (pressed) {
                ssd1306_draw_square(&disp, x + 1, y + 1, 30, 20);
            }

            int num = (2 - row) * 4 + col + 1;
            char snum[3];
            sprintf(snum, "%d", num);

            int x_offset = (num < 10) ? 12 : 9;
            ssd1306_draw_string_with_color(&disp, x + x_offset, y + 7, 1, font_8x5, snum, !pressed);
        }
    }

    for(int i=0; i<=4; i++) {
        ssd1306_draw_line(&disp, i*31, 0, i*31, 63);
    }
    for(int i=0; i<=3; i++) {
        ssd1306_draw_line(&disp, 0, i*21, 124, i*21);
    }
    
    if (status_msg_timeout != 0 && to_ms_since_boot(get_absolute_time()) < status_msg_timeout) {
        ssd1306_clear_square(&disp, 20, 15, 88, 34);
        ssd1306_draw_empty_square(&disp, 20, 15, 88, 34);
        ssd1306_draw_string(&disp, 30, 25, 1, status_msg);
    }
    
    ssd1306_show(&disp);
}

void set_status_msg(const char* msg) {
    strncpy(status_msg, msg, sizeof(status_msg)-1);
    status_msg_timeout = to_ms_since_boot(get_absolute_time()) + 1000;
}

int main() {
    board_init();
    tusb_init();
    sleep_ms(100);

    i2c_init(I2C_PORT, 400 * 1000);
    gpio_set_function(I2C_SDA, GPIO_FUNC_I2C);
    gpio_set_function(I2C_SCL, GPIO_FUNC_I2C);
    gpio_pull_up(I2C_SDA);
    gpio_pull_up(I2C_SCL);

    disp.external_vcc = false;
    if (ssd1306_init(&disp, 128, 64, 0x3C, I2C_PORT)) {
        oled_initialized = true;
        ssd1306_clear(&disp);
        ssd1306_draw_string(&disp, 10, 10, 2, "MacroPad");
        ssd1306_draw_string(&disp, 10, 35, 1, "by Kiwi X 1728NW");
        ssd1306_show(&disp);
        sleep_ms(4000);
        draw_grid();
    }

    numpad_init();
    static ec11_rotary_encoder_config ec11_conf;
    ec11_rotary_encoder_apply_default_config(&ec11_conf, EC11_PIN_A, EC11_PIN_B);
    ec11_rotary_encoder_config_set_pin_btn(&ec11_conf, EC11_PIN_BTN);
    ec11_rotary_encoder_config_set_scroll_up_handler(&ec11_conf, scroll_up_handler);
    ec11_rotary_encoder_config_set_scroll_down_handler(&ec11_conf, scroll_down_handler);
    ec11_rotary_encoder_config_set_pressed_handler(&ec11_conf, btn_handler);
    ec11_rotary_encoder_program_init(&ec11_conf, true);
    
    gpio_init(EC11_PIN_BTN);
    gpio_pull_up(EC11_PIN_BTN);
    gpio_set_irq_enabled_with_callback(EC11_PIN_BTN, GPIO_IRQ_EDGE_FALL, true, btn_handler);

    uint16_t last_consumer_report = 0;
bool needs_display_update = false;
uint32_t last_display_update_time = 0;
bool consumer_release_pending = false;  // renamed for clarity

while (true) {
    tud_task();
    uint32_t now = to_ms_since_boot(get_absolute_time());

    if (status_msg_timeout != 0 && now >= status_msg_timeout) {
        status_msg_timeout = 0;
        needs_display_update = true;
    }

    if (needs_display_update && (now - last_display_update_time > 50)) {
        draw_grid();
        last_display_update_time = now;
        needs_display_update = false;
    }

    if (!tud_mounted()) continue;

    if (tud_hid_ready()) {
        uint8_t keycodes[6] = {0};
        uint8_t keys_pressed = 0;
        uint16_t matrix_consumer_usage = 0;
        bool matrix_changed = false;

        numpad_scan(keycodes, &keys_pressed, &matrix_consumer_usage, &matrix_changed);

        // --- Keyboard report ---
        if (matrix_changed) {
            uint8_t modifier = 0;
            for (int i = 0; i < keys_pressed; i++) {
                if (keycodes[i] == HID_KEY_F1 || keycodes[i] == HID_KEY_F2 || keycodes[i] == HID_KEY_F3) {
                    modifier = KEYBOARD_MODIFIER_LEFTCTRL | KEYBOARD_MODIFIER_LEFTALT | KEYBOARD_MODIFIER_LEFTSHIFT;
                    break;
                }
            }
            tud_hid_keyboard_report(REPORT_ID_KEYBOARD, modifier, keycodes);
            needs_display_update = true;
        }

        // --- Consumer report ---
        uint16_t current_consumer_report = 0;

        if (consumer_release_pending) {
            // Send zero (release) after any consumer key press
            current_consumer_report = 0;
            consumer_release_pending = false;
        }
        // Matrix media keys: only fire on key-down edge (matrix_changed + non-zero usage)
        else if (matrix_changed && matrix_consumer_usage != 0) {
            current_consumer_report = matrix_consumer_usage;
            consumer_release_pending = true;  // release next loop

            if (matrix_consumer_usage == HID_USAGE_CONSUMER_SCAN_NEXT)     set_status_msg("NEXT");
            if (matrix_consumer_usage == HID_USAGE_CONSUMER_SCAN_PREVIOUS) set_status_msg("PREV");
            if (matrix_consumer_usage == HID_USAGE_CONSUMER_PLAY_PAUSE)    set_status_msg("PLAY/PAUSE");
            needs_display_update = true;
        }
        else if (vol_change > 0) {
            current_consumer_report = HID_USAGE_CONSUMER_VOLUME_INCREMENT;
            set_status_msg("VOL +");
            needs_display_update = true;
            vol_change--;
            consumer_release_pending = true;
        }
        else if (vol_change < 0) {
            current_consumer_report = HID_USAGE_CONSUMER_VOLUME_DECREMENT;
            set_status_msg("VOL -");
            needs_display_update = true;
            vol_change++;
            consumer_release_pending = true;
        }
        else if (mute_req) {
            current_consumer_report = HID_USAGE_CONSUMER_MUTE;
            is_muted = !is_muted;
            set_status_msg(is_muted ? "MUTE" : "UNMUTE");
            needs_display_update = true;
            mute_req = false;
            consumer_release_pending = true;
        }

        // Only send if report changed
        if (current_consumer_report != last_consumer_report) {
            tud_hid_report(REPORT_ID_CONSUMER_CONTROL, &current_consumer_report, sizeof(current_consumer_report));
            last_consumer_report = current_consumer_report;
        }
    }
}    return 0;
}

uint16_t tud_hid_get_report_cb(uint8_t instance, uint8_t report_id, hid_report_type_t report_type, uint8_t* buffer, uint16_t reqlen) {
    (void) instance; (void) report_id; (void) report_type; (void) buffer; (void) reqlen;
    return 0;
}

void tud_hid_set_report_cb(uint8_t instance, uint8_t report_id, hid_report_type_t report_type, uint8_t const* buffer, uint16_t bufsize) {
    (void) instance; (void) report_id; (void) report_type; (void) buffer; (void) bufsize;
}
