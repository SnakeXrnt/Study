// FreeRTOS
#include <FreeRTOS.h>
#include <task.h>

// C
#include <stdbool.h>
#include <stdlib.h>
#include <stdio.h>

// Pico SDK
#include "pico/stdlib.h"

void vBlink1(void* unused_arg) {

    while (true) {
        gpio_put(12, 1);
        vTaskDelay(1000);
        gpio_put(12, 0);
        vTaskDelay(1000);
    }
}

void vBlink2(void* unused_arg) {

    while (true) {
        gpio_put(13, 1);
        vTaskDelay(123);
        gpio_put(13, 0);
        vTaskDelay(123);
    }
}

void vApplicationStackOverflowHook(TaskHandle_t xTask, char* pcTaskName) {
    panic("Stack overflow. Task: %s\n", pcTaskName);
}

void vApplicationMallocFailedHook() {
    panic("malloc failed");
}

int main() {
    stdio_init_all();

    gpio_init(12);
    gpio_init(13);
    gpio_set_dir(12, GPIO_OUT);
    gpio_set_dir(13, GPIO_OUT);

    sleep_ms(2000);

    printf("Starting Blink FreeRTOS Demo...\n");

    xTaskCreate(vBlink1, "BLINK_1_TASK", 512, NULL, 1, NULL);
    xTaskCreate(vBlink2, "BLINK_2_TASK", 512, NULL, 1, NULL);
    
    vTaskStartScheduler();

    while (true) {
        // Empty loop
    }
}
