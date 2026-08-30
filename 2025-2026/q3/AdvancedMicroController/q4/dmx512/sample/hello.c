#include <stdio.h>
#include "pico/stdlib.h"
#include "hardware/pio.h"
#include "hello.pio.h" // Generated header from hello.pio

int main() {
    // Initialize standard I/O for debugging
    stdio_init_all();

    // Select PIO instance and claim a state machine
    PIO pio = pio0;
    uint sm = pio_claim_unused_sm(pio, true);
    
    // Add the program to PIO memory and get its offset
    uint offset = pio_add_program(pio, &dmx_program);
    
    // Define the GPIO pin for DMX data
    const uint DMX_PIN = 14;
    // Explicitly set for Blue LED on YD-RP2040
    const uint LED_PIN = 25; 

    // Initialize the LED pin
    gpio_init(LED_PIN);
    gpio_set_dir(LED_PIN, GPIO_OUT);

    // Initialize the DMX program
    dmx_program_init(pio, sm, offset, DMX_PIN);

    printf("DMX512 PIO Transmitter Initialized on GPIO %d\n", DMX_PIN);

    while (true) {
        // Turn ON the blue LED while we queue data to be sent
        gpio_put(LED_PIN, 1);

        // DMX512 Packet Format:
        // 1. BREAK (handled by PIO)
        // 2. MAB (handled by PIO)
        // 3. Start Code (usually 0x00)
        // 4. Up to 512 Channels of Data

        // Tell the PIO how many total bytes to send in this packet.
        // We send 512 to the OSR because the PIO loop 'jmp y--' will run 513 times.
        // (1 Start Code + 512 Data Channels = 513 total slots)
        pio_sm_put_blocking(pio, sm, 512); 

        // First byte: DMX Start Code (Standard is 0x00)
        pio_sm_put_blocking(pio, sm, 0x00);

        // Following bytes: Channel data
        for (int i = 1; i <= 512; i++) {
            // Send some example data (e.g., 0 to 255)
            // In a real application, you would put your actual light levels here.
            uint8_t level = (uint8_t)(i % 256);
            pio_sm_put_blocking(pio, sm, level);
        }

        // Turn OFF the blue LED after the FIFO has accepted all data
        gpio_put(LED_PIN, 0);

        // DMX typically repeats the packet every ~23ms to ~1s.
        // Waiting 30ms gives a refresh rate of about 33Hz.
        sleep_ms(30);
    }
}
