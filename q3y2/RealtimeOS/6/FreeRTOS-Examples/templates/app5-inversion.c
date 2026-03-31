// FreeRTOS
#include <FreeRTOS.h>
#include <task.h>
#include <queue.h>
#include <semphr.h>

// C
#include <stdbool.h>
#include <stdlib.h>
#include <stdio.h>

// Pico SDK
#include "pico/stdlib.h"
#include "pico/rand.h"

SemaphoreHandle_t sharedMutex;

void lowTask(void *p) {
    while (1)
    {
        xSemaphoreTake(sharedMutex, portMAX_DELAY);
        printf("Low: holding mutex\n");
        vTaskDelay(2000);   // simulate long work
        printf("Low: releasing mutex\n");
        xSemaphoreGive(sharedMutex);
        vTaskDelay(1000);
    }
}

void mediumTask(void *p) {
    while (1)
    {
        printf("Medium: running\n");
        vTaskDelay(500);
    }
}

void highTask(void *p) {
    vTaskDelay(500); // let low grab mutex first

    while (1)
    {
        printf("High: wants mutex\n");
        xSemaphoreTake(sharedMutex, portMAX_DELAY);
        printf("High: got mutex\n");
        xSemaphoreGive(sharedMutex);
        vTaskDelay(1000);
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

    printf("Starting Inversion FreeRTOS Demo...\n");

    sharedMutex = xSemaphoreCreateBinary();

    xTaskCreate(lowTask,    "Low",    256, NULL, 1, NULL);
    xTaskCreate(mediumTask, "Medium", 256, NULL, 2, NULL);
    xTaskCreate(highTask,   "High",   256, NULL, 3, NULL);

    vTaskStartScheduler();
}
