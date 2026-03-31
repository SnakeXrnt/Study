// FreeRTOS
#include <FreeRTOS.h>
#include <task.h>

// C
#include <stdbool.h>
#include <stdlib.h>
#include <stdio.h>

// Pico SDK
#include "pico/stdlib.h"
#include "assembly.h"
#include "portmacro.h"
#include "projdefs.h"

egg_t painted_buf[PAINTED_CAPACITY];
int paint_in = 0, paint_out = 0;
SemaphoreHandle_t sem_painted_slots;
SemaphoreHandle_t sem_painted_items;
SemaphoreHandle_t paint_buf_mutex;

egg_t wrapped_buf[WRAPPED_CAPACITY];
int wrap_in = 0, wrap_out = 0;
SemaphoreHandle_t sem_wrapped_slots;
SemaphoreHandle_t sem_wrapped_items;
SemaphoreHandle_t wrap_buf_mutex;

egg_t packed_buf[PACKED_CAPACITY];
int packed_in = 0, packed_out = 0;
SemaphoreHandle_t sem_packed_slots;
SemaphoreHandle_t sem_packed_items;
SemaphoreHandle_t packed_buf_mutex;

volatile uint32_t delay_value_ms = 1000;

void vApplicationStackOverflowHook(TaskHandle_t xTask, char* pcTaskName) {
    panic("Stack overflow. Task: %s\n", pcTaskName);
}

void vApplicationMallocFailedHook() {
    panic("malloc failed");
}

void producer_task(void *pvParameters) {
    static int egg_id = 0;
    while (1) {
        xSemaphoreTake(sem_painted_slots, portMAX_DELAY);

        egg_t new_egg;
        new_egg.id = egg_id++;
        if (new_egg.id % 10 == 0) {
            if (new_egg.id == 0) {
                new_egg.golden = false;
            } else {
                new_egg.golden = true;
            }
        } else {
            new_egg.golden = false;
        }
        new_egg.color = -1; //because its not painted yet
        
        xSemaphoreTake(paint_buf_mutex, portMAX_DELAY);
        painted_buf[paint_in] = new_egg;
        paint_in = (paint_in + 1) % PAINTED_CAPACITY;
        xSemaphoreGive(paint_buf_mutex);
        
        xSemaphoreGive(sem_painted_items);

        vTaskDelay(pdMS_TO_TICKS(1000+ (rand() % 2000)));

    }
}
void painter_task(void *pvParameters){
    color_t my_color = (color_t)pvParameters;
    while(1) {

        xSemaphoreTake(sem_painted_items, portMAX_DELAY);

        xSemaphoreTake(paint_buf_mutex, portMAX_DELAY);
        egg_t egg = painted_buf[paint_out];
        paint_out = (paint_out + 1) % PAINTED_CAPACITY;
        xSemaphoreGive(paint_buf_mutex);
        xSemaphoreGive(sem_painted_slots);

        egg.color = my_color;
        printf("painter %d : painted egg %d and its %s \n", my_color, egg.id, egg.golden? "golden" : "not golden");

        vTaskDelay(pdMS_TO_TICKS(3000 + (rand() % 2000)));

        xSemaphoreTake(sem_wrapped_slots, portMAX_DELAY);
        xSemaphoreTake(wrap_buf_mutex, portMAX_DELAY);
        wrapped_buf[wrap_in] = egg;
        wrap_in = (wrap_in + 1) % WRAPPED_CAPACITY;
        xSemaphoreGive(wrap_buf_mutex);
        xSemaphoreGive(sem_wrapped_items);
        
    }
}
void wrapper_task(void *pvParameters) {
    while(1) {
        xSemaphoreTake(sem_wrapped_items, portMAX_DELAY);

        xSemaphoreTake(wrap_buf_mutex, portMAX_DELAY);
        egg_t egg = wrapped_buf[wrap_out];
        wrap_out = (wrap_out + 1) % WRAPPED_CAPACITY;
        xSemaphoreGive(wrap_buf_mutex);
        xSemaphoreGive(sem_wrapped_slots);

        printf("wrapper now wrapping egg : %d with %d color and its %s \n", egg.id, egg.color, egg.golden ? "golden" : "not golden");
        vTaskDelay(pdMS_TO_TICKS(2000 + (rand() % 2000 )));

        xSemaphoreTake(sem_packed_slots,portMAX_DELAY);
        xSemaphoreTake(packed_buf_mutex, portMAX_DELAY);
        packed_buf[packed_in] = egg;
        packed_in = (packed_in + 1) % PACKED_CAPACITY;
        xSemaphoreGive(packed_buf_mutex);

        xSemaphoreGive(sem_packed_items);
    }
}
void packer_task(void *pvParameters) {
    egg_t basket[BASKET_SIZE];
    int basket_count = 0;
    while(1) {
        xSemaphoreTake(sem_packed_items, portMAX_DELAY);

        xSemaphoreTake(packed_buf_mutex, portMAX_DELAY);
        egg_t egg = packed_buf[packed_out];
        packed_out = (packed_out + 1) % PACKED_CAPACITY;
        xSemaphoreGive(packed_buf_mutex);
        xSemaphoreGive(sem_packed_slots);

        basket[basket_count++] = egg;
        if(basket_count == BASKET_SIZE) {
            printf("basket is full now, bom is here : \n");
            for (int i = 0; i < BASKET_SIZE ; i++) {
                printf("egg %d : color %d and its %s \n", basket[i].id, basket[i].color, basket[i].golden ? "golden" : "not golden" );
            }
            basket_count = 0;
            printf("basket sent to delivety cart \n");
        }

        vTaskDelay(pdMS_TO_TICKS(1000 + (rand() % 1000)));
    }
}

int main() {
    stdio_init_all();
    sleep_ms(2000);

    printf("Starting Hello World FreeRTOS second logbook...\n");

    sem_painted_slots = xSemaphoreCreateCounting(PAINTED_CAPACITY, PAINTED_CAPACITY);
    sem_painted_items = xSemaphoreCreateCounting(PAINTED_CAPACITY, 0);
    paint_buf_mutex = xSemaphoreCreateMutex();

    sem_wrapped_slots = xSemaphoreCreateCounting(WRAPPED_CAPACITY, WRAPPED_CAPACITY);
    sem_wrapped_items = xSemaphoreCreateCounting(WRAPPED_CAPACITY, 0);
    wrap_buf_mutex = xSemaphoreCreateMutex();

    sem_packed_slots = xSemaphoreCreateCounting(PACKED_CAPACITY, PACKED_CAPACITY);
    sem_packed_items = xSemaphoreCreateCounting(PACKED_CAPACITY, 0);
    packed_buf_mutex = xSemaphoreCreateMutex();

    xTaskCreate(producer_task,"Producer",256 ,NULL,2,NULL);
    xTaskCreate(painter_task,"redpainter",256 ,(void*)RED,2,NULL);
    xTaskCreate(painter_task,"greenpainter",256 ,(void*)GREEN,2,NULL);
    xTaskCreate(painter_task,"bluepainter",256 ,(void*)BLUE,2,NULL);
    xTaskCreate(wrapper_task,"wrapper1",256 ,NULL,2,NULL);
    xTaskCreate(wrapper_task,"wrapper2",256 ,NULL,2,NULL);
    xTaskCreate(packer_task,"Packer",256 ,NULL,2,NULL);

    vTaskStartScheduler();
    
    // while (true);
}

