#include <stdio.h>
#include "pico/stdlib.h"
#include "pico/multicore.h"
#include "hardware/irq.h"

const uint LED1 = 15;
const uint LED2 = 14;

// Global buffer for the message
char message_buffer[128];

void core1_irq_handler() {
    while(multicore_fifo_rvalid()) {
        // Pop the address of the string from the FIFO
        uint32_t addr = multicore_fifo_pop_blocking();
        char *str = (char *)addr;
        
        // Print the received string
        printf("Core 1 Received String: \"%s\"\n", str);
    }
    multicore_fifo_clear_irq();
}

void core1_entry() {
    multicore_fifo_clear_irq();
    irq_set_exclusive_handler(SIO_IRQ_PROC1, core1_irq_handler);
    irq_set_enabled(SIO_IRQ_PROC1, true);

    while(true) {
        gpio_put(LED2, true);
        sleep_ms(100);
        gpio_put(LED2, false);
        sleep_ms(100);
    }
}

int main(){
    stdio_init_all();

    multicore_launch_core1(core1_entry);

    gpio_init(LED1);
    gpio_set_dir(LED1, GPIO_OUT);
    gpio_init(LED2);
    gpio_set_dir(LED2, GPIO_OUT);

    int raw_value;
    int buffer_index = 0;
    const uint32_t timeout = 1000; // 1ms timeout

    printf("Pico Multicore String Example\n");
    printf("Type something and press Enter to send to Core 1:\n");

    while(true) {
        // Heartbeat on Core 0
        static uint32_t last_blink = 0;
        if (absolute_time_diff_us(get_absolute_time(), delayed_by_ms(last_blink, 1000)) < 0) {
            gpio_put(LED1, !gpio_get(LED1));
            last_blink = to_ms_since_boot(get_absolute_time());
        }

        raw_value = stdio_getchar_timeout_us(timeout);
        if(raw_value != PICO_ERROR_TIMEOUT){
            if (raw_value == '\r' || raw_value == '\n') {
                // End of line reached
                if (buffer_index > 0) {
                    message_buffer[buffer_index] = '\0';
                    printf("\nCore 0 Sending: \"%s\"\n", message_buffer);
                    
                    // Push the memory address of our buffer to Core 1
                    multicore_fifo_push_blocking((uint32_t)message_buffer);
                    
                    // Reset buffer index for next message
                    buffer_index = 0;
                }
            } else {
                // Character received, add to buffer if there's space
                if (buffer_index < sizeof(message_buffer) - 1) {
                    message_buffer[buffer_index++] = (char)raw_value;
                    putchar(raw_value); // Echo back to terminal
                }
            }
        }
    }
}
