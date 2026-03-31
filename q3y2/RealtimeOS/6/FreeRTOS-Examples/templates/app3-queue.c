// FreeRTOS
#include <FreeRTOS.h>
#include <task.h>
#include <queue.h>

// C
#include <stdbool.h>
#include <stdlib.h>
#include <stdio.h>

// Pico SDK
#include "pico/stdlib.h"
#include "pico/rand.h"

// Hardware button interrupt handler
void vButtonHandler(uint gpio, uint32_t events) {
    // This function will be called when the button is pressed
}

void vProducerTask(void* unused_arg) {

    while (true) {
        // Produce an item
        printf("Produced an item\n");
        vTaskDelay((get_rand_32() % 1000 + 500));
    }
}

void vConsumerTask(void* unused_arg) {

    while (true) {
        // Consume an item
        printf("Consumed an item\n");
        vTaskSuspend(NULL);
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

    printf("Starting Queue FreeRTOS Demo...\n");

    xTaskCreate(vProducerTask, "PRODUCER_TASK", 512, NULL, 1, NULL);
    xTaskCreate(vConsumerTask, "CONSUMER_TASK", 512, NULL, 1, NULL);

    vTaskStartScheduler();

    while (true) {
        // Empty loop
    }
}