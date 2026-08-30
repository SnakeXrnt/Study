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

#define N 5

SemaphoreHandle_t forks[N];

void vPhilosopher(void *num) {
    int id = (int)num;
    int left = id;
    int right = (id + 1) % N;

    vTaskDelay(100);

    while (1) {
        printf("Philosopher %d is thinking...\n", id);
        vTaskDelay((get_rand_32() % 100 + 50));

        printf("Philosopher %d is hungry...\n", id);
        xSemaphoreTake(forks[left], portMAX_DELAY);
        vTaskDelay(200);
        xSemaphoreTake(forks[right], portMAX_DELAY);

        printf("Philosopher %d is eating...\n", id);
        vTaskDelay(100);

        xSemaphoreGive(forks[right]);
        xSemaphoreGive(forks[left]);
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

    printf("Starting Philosophers FreeRTOS Demo...\n");

    for (int i = 0; i < N; i++)
        forks[i] = xSemaphoreCreateMutex();

    for (int i = 0; i < N; i++)
        xTaskCreate(vPhilosopher, "P", 256, (void*)i, 1, NULL);

    vTaskStartScheduler();
}
