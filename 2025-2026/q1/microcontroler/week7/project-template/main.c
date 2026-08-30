#include "pico/stdlib.h"
#include "hardware/i2c.h"
#include "hardware/spi.h"
#include <stdio.h>
#include <stdint.h>
#include <stdbool.h>

#define LIGHT_ADDR 0x52
#define TEMP_ADDR  0x49
#define BUTTON_PIN 15
#define INT_PIN    14
#define OS_PIN 13

#define PIN_CS   17
#define PIN_MISO 16
#define PIN_MOSI 19
#define PIN_SCK  18
#define PIN_SYNC 20

// -------- APDS-9306 registers --------
#define REG_MAIN_CTRL        0x00
#define REG_ALS_MEAS_RATE    0x04
#define REG_ALS_GAIN         0x05
#define REG_MAIN_STATUS      0x07
#define REG_ALS_DATA_0       0x0D
#define REG_INT_CFG          0x19
#define REG_INT_PERSIST      0x1A
#define REG_ALS_THRES_UP_0   0x21
#define REG_ALS_THRES_UP_1   0x22
#define REG_ALS_THRES_UP_2   0x23
#define REG_ALS_THRES_LOW_0  0x24
#define REG_ALS_THRES_LOW_1  0x25
#define REG_ALS_THRES_LOW_2  0x26

// LM75B registers 
#define REG_TOS 0x03 // upper treshold 
#define REG_THYST 0x02 // lower treshold
#define REG_TEMP 0X00

// temperature sensor writer 

static void lm75b_register_write(uint8_t reg, uint8_t msb, uint8_t lsb) {
    uint8_t buffer[3] = {reg, msb, lsb};
    i2c_write_blocking(i2c_default, TEMP_ADDR, buffer, 3, false);
}

// ---------- Temperature sensor treshold ----------
static void temp_treshold_up(uint32_t value9bit) {
    uint8_t msb = (uint8_t)(value9bit & 0xFF);
    uint8_t lsb = 0x00;
    lm75b_register_write(REG_TOS, msb, lsb);

}


static void temp_treshold_down(uint32_t value9bit) {
    uint8_t msb = (uint8_t)(value9bit & 0xFF);
    uint8_t lsb = 0x00;
    lm75b_register_write(REG_THYST, msb, lsb);

}


// ---------- I2C helpers for APDS ----------
static inline void apds_write_reg(uint8_t reg, uint8_t val) {
    uint8_t buf[2] = {reg, val};
    i2c_write_blocking(i2c_default, LIGHT_ADDR, buf, 2, false);
}
static inline uint8_t apds_read_reg(uint8_t reg) {
    uint8_t v;
    i2c_write_blocking(i2c_default, LIGHT_ADDR, &reg, 1, true);
    i2c_read_blocking(i2c_default, LIGHT_ADDR, &v, 1, false);
    return v;
}

static void write_regs(uint8_t start_reg, const uint8_t *data, size_t len) {
    uint8_t buf[8];
    buf[0] = start_reg;
    for (size_t i = 0; i < len; ++i) buf[i + 1] = data[i];
    i2c_write_blocking(i2c_default, LIGHT_ADDR, buf, len + 1, false);
}

// ====== Threshold functions (20-bit -> 3 bytes) ======
void set_threshold_low(uint32_t value20bit) {
    uint8_t b[3];
    b[0] = (uint8_t)(value20bit & 0xFF);
    b[1] = (uint8_t)((value20bit >> 8) & 0xFF);
    b[2] = (uint8_t)((value20bit >> 16) & 0x0F);
    write_regs(REG_ALS_THRES_LOW_0, b, 3);
}
void set_threshold_up(uint32_t value20bit) {
    uint8_t b[3];
    b[0] = (uint8_t)(value20bit & 0xFF);
    b[1] = (uint8_t)((value20bit >> 8) & 0xFF);
    b[2] = (uint8_t)((value20bit >> 16) & 0x0F);
    write_regs(REG_ALS_THRES_UP_0, b, 3);
}

// ====== Mode/LED state ======
static volatile uint8_t mode_light = 1;      // 1 = show light, 0 = show temperature
static volatile bool mode_changed = false;
static volatile bool flash_request = false;  // set by INT ISR, handled in main()
static uint8_t last_led_byte = 0x00;         // track current IO-expander display

// ====== SPI IO-expander helpers (yours) ======
static inline void cs_select() {
    asm volatile("nop \n nop \n nop");
    gpio_put(PIN_CS, 0);
    asm volatile("nop \n nop \n nop");
}
static inline void cs_deselect() {
    asm volatile("nop \n nop \n nop");
    gpio_put(PIN_CS, 1);
    asm volatile("nop \n nop \n nop");
}
void io_exp_write(uint8_t reg, uint8_t data) {
    uint8_t buf[3];
    buf[0] = 0b01000110; // your device's control/ad dress byte
    buf[1] = reg;
    buf[2] = data;
    cs_select();
    spi_write_blocking(spi0, buf, 3);
    cs_deselect();
    sleep_ms(2);
}

// ====== Button ISR (unchanged) ======
void gpio_callback(uint gpio, uint32_t events) {
    static uint64_t last_us = 0;
    uint64_t now = time_us_64();
    if (gpio == BUTTON_PIN && (events & GPIO_IRQ_EDGE_RISE)) {
        if (now - last_us > 200000) {  // 200 ms debounce
            mode_light ^= 1;
            mode_changed = true;
            last_us = now;
        }
    }
}

// ====== APDS INT ISR (active-low -> falling edge) ======
void gpio_callback_amb(uint gpio, uint32_t events) {
    static uint64_t last_us = 0;
    uint64_t now = time_us_64();

    if (gpio == INT_PIN && (events & GPIO_IRQ_EDGE_FALL)) {
        if (now - last_us > 5000) { // tiny debounce ~5ms
            // Clear INT status by reading MAIN_STATUS
            (void)apds_read_reg(REG_MAIN_STATUS);
            // Request a LED flash in main loop
            flash_request = true;
            last_us = now;
        }
    }
}

// callback temperature 


static inline void lm75b_clear_os(void) {
    uint8_t reg = REG_TEMP;
    uint8_t buf[2];
    i2c_write_blocking(i2c_default, TEMP_ADDR, &reg, 1, true);
    i2c_read_blocking(i2c_default, TEMP_ADDR, buf, 2, false);
}

void gpio_callback_temp(uint gpio, uint32_t events) {
    if (gpio == OS_PIN && (events & GPIO_IRQ_EDGE_FALL)) {
        printf("temperature interupted\n");
        lm75b_clear_os();
        flash_request = true;
        printf("cleared os \n");
    }
}

// ====== Flash helper: blink all LEDs 3x, then restore previous ======
static void flash_leds_3x(void) {
    const uint8_t saved = last_led_byte;
    for (int i = 0; i < 3; ++i) {
        io_exp_write(0x09, 0xFF); // all ON
        sleep_ms(120);
        io_exp_write(0x09, 0x00); // all OFF
        sleep_ms(120);
    }
    io_exp_write(0x09, saved);   // back to previous "normal"
}

// ====== APDS minimal init for threshold interrupt ======
static void apds_setup_thresholds(uint32_t low, uint32_t high, uint8_t persist_n_plus_1) {
    // Resolution/time: 18-bit @100ms -> 0x22
    apds_write_reg(REG_ALS_MEAS_RATE, 0x22);
    // Gain: x3 -> 0x01
    apds_write_reg(REG_ALS_GAIN, 0x01);

    // Program threshold window
    set_threshold_low(low);
    set_threshold_up(high);

    // Persistence (N stored as N-1 in bits [7:4], limit to 0..15)
    uint8_t n = (persist_n_plus_1 == 0) ? 0 : (uint8_t)(persist_n_plus_1 - 1);
    if (n > 0x0F) n = 0x0F;
    apds_write_reg(REG_INT_PERSIST, (uint8_t)(n << 4));

    // INT_CFG: ALS source, threshold mode, enable -> 0x14
    apds_write_reg(REG_INT_CFG, 0x14);

    // Enable ALS engine
    apds_write_reg(REG_MAIN_CTRL, 0x02);

    // Clear any stale interrupt flag
    (void)apds_read_reg(REG_MAIN_STATUS);
}

// ====== Temperature & light reads (yours) ======
float read_temperature(void) {
    uint8_t reg = 0x00;
    uint8_t buf[2];
    i2c_write_blocking(i2c_default, TEMP_ADDR, &reg, 1, true);
    i2c_read_blocking(i2c_default,  TEMP_ADDR, buf, 2, false);
    int16_t raw = (int16_t)((buf[0] << 8) | buf[1]);
    raw >>= 5;
    if (raw & 0x0400) raw |= 0xF800;
    return raw * 0.125f;
}

uint32_t read_light_raw(void) {
    uint8_t reg = REG_ALS_DATA_0;
    uint8_t data[3];
    i2c_write_blocking(i2c_default, LIGHT_ADDR, &reg, 1, true);
    i2c_read_blocking(i2c_default,  LIGHT_ADDR, data, 3, false);
    uint32_t value = ((uint32_t)(data[2] & 0x0F) << 16) | ((uint32_t)data[1] << 8) | (uint32_t)data[0];
    return value;
}

int main(void) {
    stdio_init_all();

    // I2C on GP4/GP5
    i2c_init(i2c_default, 400 * 1000);
    gpio_set_function(4, GPIO_FUNC_I2C);
    gpio_set_function(5, GPIO_FUNC_I2C);
    gpio_pull_up(4);
    gpio_pull_up(5);

    // SPI for IO expander
    spi_init(spi0, 500 * 1000);
    gpio_set_function(PIN_MISO, GPIO_FUNC_SPI);
    gpio_set_function(PIN_SCK,  GPIO_FUNC_SPI);
    gpio_set_function(PIN_MOSI, GPIO_FUNC_SPI);
    gpio_init(PIN_CS);
    gpio_set_dir(PIN_CS, GPIO_OUT);
    gpio_put(PIN_CS, 1);

    // Example IO-expander init
    io_exp_write(0x00, 0x00); // configure as outputs if that's your device's IODIR

    // --- APDS threshold interrupt setup ---
    // choose a window; adjust after observing raw counts
    apds_setup_thresholds(/*low*/100, /*high*/160000, /*persist N+1*/4);

    // Button (rising-edge)
    gpio_init(BUTTON_PIN);
    gpio_set_dir(BUTTON_PIN, GPIO_IN);
    gpio_pull_down(BUTTON_PIN);
    gpio_set_irq_enabled_with_callback(BUTTON_PIN, GPIO_IRQ_EDGE_RISE, true, &gpio_callback);

    // INT pin: open-drain active-low -> input + pull-up, IRQ on falling edge
    gpio_init(INT_PIN);
    gpio_set_dir(INT_PIN, GPIO_IN);
    gpio_pull_up(INT_PIN);
    gpio_set_irq_enabled_with_callback(INT_PIN, GPIO_IRQ_EDGE_FALL, true, &gpio_callback_amb);


    gpio_init(OS_PIN);
    gpio_set_dir(OS_PIN, GPIO_IN);
    gpio_pull_up(OS_PIN);  // OS is open-drain
    gpio_set_irq_enabled_with_callback(OS_PIN, GPIO_IRQ_EDGE_FALL, true, &gpio_callback_temp);

    temp_treshold_up(0x3C);
    temp_treshold_down(0x32);

    printf("Mode: LIGHT (press button on GPIO 15 to toggle). Waiting for APDS INT…\n");

    while (true) {
        // Handle pending flash request outside the ISR
        if (flash_request) {
            flash_request = false;
            printf("Light interrupt -> FLASH LEDs\n");
            flash_leds_3x();
        }

        if (mode_changed) {
            mode_changed = false;
            printf("Mode: %s\n", mode_light ? "LIGHT" : "TEMPERATURE");
        }

        if (mode_light) {
            uint32_t light = read_light_raw();
            printf("Light raw: %lu\n", (unsigned long)light);
            last_led_byte = (uint8_t)light;       // store for restore
            io_exp_write(0x09, last_led_byte);    // display something

        } else {
            float temp = read_temperature();
            printf("Temperature: %.3f C\n", temp);
            last_led_byte = (uint8_t)temp;        // store for restore
            io_exp_write(0x09, last_led_byte);
        }

        sleep_ms(300);
    }
}
