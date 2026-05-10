## Step 1: USB Descriptor 

You can edit `usb_descriptors.c` and change the manufacturer and product name so when you plug it in, it doesn't say "TinyUSB Device", but it says whatever you want.

Find the string descriptor section and change:
- Manufacturer: "TinyUSB" -> your desired name
- Product: "Keyboard Device" -> your desired product name

When you plug it in, your custom name shows up. That's the Step 1.

---

# Step 2: Press Button, Get Letter A (TinyUSB Edition)

Now, you can try the program. This is just a button connected to GPIO 18, and when you press it it spits out the letter 'A'.
You can read this and understand what's goin' on to basically make any USB device. 

```c
#include "pico/stdlib.h"
#include "bsp/board.h"
#include "tusb.h"
#include "class/hid/hid.h"
#include "usb_descriptors.h"

#define BUTTON_PIN 18
#define DEBOUNCE_MS 10

static uint32_t last_press_time = 0;
static bool button_pressed = false;

void button_init() {
    gpio_init(BUTTON_PIN);
    gpio_set_dir(BUTTON_PIN, GPIO_IN);
    gpio_pull_up(BUTTON_PIN);
}

bool button_read() {
    bool current = !gpio_get(BUTTON_PIN);  // inverted because pull-up
    uint32_t now = to_ms_since_boot(get_absolute_time());
    
    if (current && !button_pressed && (now - last_press_time) > DEBOUNCE_MS) {
        last_press_time = now;
        button_pressed = true;
        return true;
    }
    
    if (!current) {
        button_pressed = false;
    }
    
    return false;
}

void send_key(uint8_t keycode, bool pressed) {
    uint8_t keycode_arr[6] = {0};
    uint8_t modifier = 0;
    
    if (pressed) {
        keycode_arr[0] = keycode;
    }
    
    tud_hid_keyboard_report(REPORT_ID_KEYBOARD, modifier, keycode_arr);
}

int main() {
    board_init();
    tusb_init();
    button_init();
    
    while (1) {
        tud_task();
        
        if (tud_hid_ready()) {
            if (button_read()) {
                send_key(HID_KEY_A, true);
                sleep_ms(5);
                send_key(0, false);  // release
            }
        }
    }
    
    return 0;
}
```

That's literally it. Button is pressed, and it's sent to the computer.

---

## Step 3: Multiple Buttons, Multiple Letters

Add like 4-5 more buttons on different GPIO pins. Map each to a different letter (B, C, D, E, whatever). 
```c
// Change the code from Step 1:
```

Boom, multi-button chaos. Don't press all buttons at once or weird stuff happens (6-key limitation, look it up if you care).

---

## Step 4 (Optional): Gamepad Mode

Make it a gamepad instead. Use TinyUSB's gamepad HID descriptor and send gamepad reports instead of keyboard reports. Wire up 4 directional buttons and 2 action buttons. Games will see it as a controller.

No code for this one—go figure it out. It's basically swapping the HID report structure from keyboard to gamepad and remapping your buttons.
```c
// TO BE PROVIDED
```
