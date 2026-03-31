// FreeRTOS
#include <FreeRTOS.h>
#include <task.h>

// C
#include <stdbool.h>
#include <stdlib.h>
#include <stdio.h>

// Pico SDK
#include "pico/stdlib.h"

volatile uint32_t delay_value_ms = 1000;

void vHelloTask(void* unused_arg) {

    printf("Starting Hello Task...\n");
    while (true) {
        char buffer[100] = "This is the hello_task saying: Hello, world!\n";
        
        // Print character by character
        for (int i = 0; i < 100 && buffer[i] != '\0'; i++) {
            printf("%c", buffer[i]);
        }

        vTaskDelay(delay_value_ms);
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
    sleep_ms(2000);

    printf("Starting Hello World FreeRTOS Demo...\n");

    BaseType_t result = xTaskCreate(vHelloTask, "HELLO_TASK", 512, NULL, 1, NULL);

    if (result != pdPASS) {
        printf("Task creation FAILED!\n");
        while (1);
    } else {
        printf("Task creation SUCCESS!\n");
    }
    
    vTaskStartScheduler();

    while (true) {
        printf("Running main..\n");
        sleep_ms(2000);
    }
}
