
#ifndef ASSEMBLY_H
#define ASSEMBLY_H

// this one is only to tell the compiler that there is this shit somewhere, go search for it \
// here it just tell extern, which just tell the compiler there is this somewhere. 
// and here it doesnt alocate any memory
// later in the c file, is where memory is allocated

#include "FreeRTOS.h" 
#include "semphr.h"
#include <stdbool.h>

#define PAINTED_CAPACITY 4
#define WRAPPED_CAPACITY 8
#define BASKET_SIZE 6
#define PACKED_CAPACITY 8 

typedef enum {RED,GREEN,BLUE} color_t;

typedef struct{
    int id;
    color_t color;
    bool golden;
} egg_t;

extern egg_t painted_buf[PAINTED_CAPACITY];
extern int paint_in, paint_out;
extern SemaphoreHandle_t sem_painted_slots;
extern SemaphoreHandle_t sem_painted_items;
extern SemaphoreHandle_t paint_buf_mutex;

extern egg_t wrapped_buf[WRAPPED_CAPACITY];
extern int wrap_in, wrap_out;
extern SemaphoreHandle_t sem_wrapped_slots; 
extern SemaphoreHandle_t sem_wrapped_items;
extern SemaphoreHandle_t wrap_buf_mutex;

extern egg_t packed_buf[PACKED_CAPACITY];
extern int packed_in, packed_out;
extern SemaphoreHandle_t sem_packed_slots;
extern SemaphoreHandle_t sem_packed_items;
extern SemaphoreHandle_t packed_buf_mutex;


#endif 
