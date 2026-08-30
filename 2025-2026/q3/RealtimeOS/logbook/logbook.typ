#let font_size = 12pt

#set text(
  font: "New Computer Modern",
  size: font_size,
)
#set par(justify: true)
#set heading(numbering: "1.")

#show link: set text(blue)
#show link: underline

#set page(
  paper: "us-letter",
  header: align(right)[
    Kiril Strezikozin 561982
  ],
)

#align(
  horizon,
  [
    #align(
      center,
      text(2.5 * font_size)[
        *Logbook*
      ],
    )

    #align(center)[
      RTOS Q3 L.31948
    ]
  ],
)

#pagebreak()

#outline()

= Manuals
- FreeRTOS Book: #link(
    "https://freertos.org/Documentation/02-Kernel/07-Books-and-manual/01-RTOS_book",
    [Mastering the FreeRTOS Real-Time Kernel v1.0],
  ) #footnote[#link(
    "https://freertos.org/Documentation/02-Kernel/07-Books-and-manual/01-RTOS_book",
    [Mastering-the-FreeRTOS-Real-Time-Kernel.v1.0.pdf],
  )]<manual>


#pagebreak()

= Setup and Tasks

== Step 1

Below is the code of step 1 which runs two tasks concurrently, each printing a
message every second. The tasks are created with the same priority, so they will
be scheduled in a round-robin manner by the FreeRTOS scheduler.

I modified the code slightly to print the message which includes the task name.

```c
// FreeRTOS
#include <FreeRTOS.h>
#include <pico/platform/compiler.h>
#include <task.h>

/* C */
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>

/* Pico SDK */
#include "pico/stdlib.h"

static volatile TickType_t xTicksDelayMs = pdMS_TO_TICKS(1000);

void vHelloTask(void *unused_arg) {
    const char *pcTaskName = pcTaskGetTaskName(NULL);

    printf("Starting %s...\n", pcTaskName);
    while (true) {
        char pcBuffer[100];

        int _ok = snprintf(
            pcBuffer,
            count_of(pcBuffer),
            "This is the %s saying: Hello, world!\n",
            pcTaskName
        );
        if (_ok < 0) {
            printf("Error formatting string for %s\n", pcTaskName);
            vTaskDelay(xTicksDelayMs);
            continue;
        }

        /* Print character by character. */
        for (int i = 0; i < count_of(pcBuffer) && pcBuffer[i] != '\0'; i++) {
            printf("%c", pcBuffer[i]);
        }

        vTaskDelay(xTicksDelayMs);
    }
}

void vApplicationStackOverflowHook(TaskHandle_t xTask, char *pcTaskName) {
    panic("Stack overflow. Task: %s\n", pcTaskName);
}

void vApplicationMallocFailedHook() {
    panic("malloc failed");
}

int main() {
    stdio_init_all();
    sleep_ms(2000);

    printf("Starting Hello World FreeRTOS Demo...\n");

    BaseType_t result1 =
        xTaskCreate(vHelloTask, "HELLO_TASK_1", 512, NULL, 1, NULL);
    BaseType_t result2 =
        xTaskCreate(vHelloTask, "HELLO_TASK_2", 512, NULL, 1, NULL);

    if ((result1 != pdPASS) || (result2 != pdPASS)) {
        printf("Task creation FAILED!\n");
        while (1)
            ;
    } else {
        printf("Task creation SUCCESS!\n");
    }

    vTaskStartScheduler();

    while (true) {
        printf("Running main..\n");
        sleep_ms(2000);
    }
}
```


== Step 2

Here is the sample of output visible in the serial monitor:

```
Starting HELLO_TASK_1...
Starting HELLO_TASK_2...
ThisThis is th ise HEL the HELLOLO_TASK_TASK_2 s_1 saaying: Hello, worldying: Hel!
lo, world!
This is the HELLO_TASK_1 saying: HThis is the HELello, world!
LO_TASK_2 saying: Hello, world!
This is the HELLO_TASK_1 saThis is the HELLying: HelloO_TASK_2 saying: Hello, world,!
 world!
This is thThis is the HELLO_TASK_1 saying: Hello, world!
e HELLO_TASK_2 saying: Hello, world!
This is the HELLO_TASK_1 saying:This is the H Hello, wELLO_TASK_2 saying: Horld!ello, world!
```

Because the two tasks are printing to `stdout` concurrently without synchronization,
their outputs are interleaved.

== Step 3

1. *Where is task context stored?*

  Task context is stored on the task's stack. #link("https://freertos.org/Documentation/02-Kernel/05-RTOS-implementation-tutorial/02-Building-blocks/09-Saving-the-RTOS-task-context", [Saving the RTOS task context]).

2. *What happens during a context switch?*

  Entire execution context needs to be saved. This includes:
  - 32 general purpose processor registers
  - Status register (affect instruction execution)
  - Program counter (to continue execution from where it left off)
  - The two stack pointer registers (to restore the task's stack)

3. *Why must task functions never return?*

  `vTaskDelete(NULL)` can be called to delete the task. Otherwise,
  if a task function returns, its stack remains allocated and
  the task is not cleaned up.

= Task Creation and Management

== Creation

=== Step 4

The program spins two concurrent tasks that blink LEDs at different rates.

=== Step 5

Code:

```c
// FreeRTOS
#include <FreeRTOS.h>
#include <FreeRTOSConfig.h>
#include <task.h>

// C
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>

// Pico SDK
#include "pico/stdlib.h"

typedef struct {
    uint uPin;
    TickType_t xDelay;
} BlinkTaskParams;

void vBlinkTask(void *pvParameters) {

    const char *pcTaskName        = pcTaskGetName(NULL);
    const BlinkTaskParams *params = (const BlinkTaskParams *)pvParameters;

    configASSERT(params != NULL);
    configASSERT(params->xDelay > 0);

    while (true) {
        gpio_put(params->uPin, 1);
        vTaskDelay(params->xDelay);
        gpio_put(params->uPin, 0);
        printf("%s: toggled pin %u\n", pcTaskName, params->uPin);
        vTaskDelay(params->xDelay);
    }
}

void vApplicationStackOverflowHook(TaskHandle_t xTask, char *pcTaskName) {
    panic("Stack overflow. Task: %s\n", pcTaskName);
}

void vApplicationMallocFailedHook() {
    panic("malloc failed");
}

int main() {
    stdio_init_all();

    BlinkTaskParams *params1 = malloc(sizeof(BlinkTaskParams));
    params1->uPin            = 12;
    params1->xDelay          = pdMS_TO_TICKS(1000);

    BlinkTaskParams *params2 = malloc(sizeof(BlinkTaskParams));
    params2->uPin            = 13;
    params2->xDelay          = pdMS_TO_TICKS(123);

    gpio_init(params1->uPin);
    gpio_init(params2->uPin);
    gpio_set_dir(params1->uPin, GPIO_OUT);
    gpio_set_dir(params2->uPin, GPIO_OUT);

    sleep_ms(2000);

    printf("Starting Blink FreeRTOS Demo...\n");

    xTaskCreate(vBlinkTask, "BLINK_1_TASK", 512, params1, 1, NULL);
    xTaskCreate(vBlinkTask, "BLINK_2_TASK", 512, params2, 1, NULL);

    vTaskStartScheduler();

    while (true) {
        // Empty loop
    }

    free(params1);
    free(params2);

    return 0;
}
```

Output:

```
BLINK_2_TASK: toggled pin 13
BLINK_2_TASK: toggled pin 13
BLINK_2_TASK: toggled pin 13
BLINK_2_TASK: toggled pin 13
BLINK_2_TASK: toggled pin 13
BLINK_1_TASK: toggled pin 12*
BLINK_2_TASK: toggled pin 13
BLINK_2_TASK: toggled pin 13
BLINK_2_TASK: toggled pin 13
BLINK_2_TASK: toggled pin 13
BLINK_2_TASK: toggled pin 13
BLINK_2_TASK: toggled pin 13
BLINK_2_TASK: toggled pin 13
BLINK_2_TASK: toggled pin 13
BLINK_1_TASK: toggled pin 12*
```

=== Step 6

Answer the following questions:

1. *What happens exactly if your stack size is too small for a task?*

  If the stack size is too small, the task will raise a stack overflow error. \
  In case with Pico W, it just crashes.

2. *Which states can a task be in in FreeRTOS? How can a task transition between these states?*

  #link("https://freertos.org/Documentation/02-Kernel/02-Kernel-features/01-Tasks-and-co-routines/02-Task-states", [Task states]):

  - *Running*: \ The task is currently executing on the CPU.
  - *Ready*: \ The task is ready to run but is not currently executing. It is waiting for the scheduler to select it for execution.
  - *Blocked*: \ The task is waiting for a blocking event or a resource. It cannot run until the event occurs or the resource becomes available.
  - *Suspended*: \ The task was manually suspended and will not be scheduled until it is resumed.

  *Transitions*:
  - *Running* -> *Ready*: \ When a higher priority task becomes ready, the currently running task may be preempted and moved to the ready state.
  - *Ready* -> *Running*: \ When the scheduler selects a task from the ready state, it transitions to running.
  - *Running* -> *Blocked*: \ When a task waits for an event or resource, it transitions to blocked.
  - *Blocked* -> *Ready*: \ When the event occurs or the resource becomes available, the blocked task transitions back to ready.
  - *Running* -> *Suspended*: \ A task can be manually suspended by calling `vTaskSuspend()`.
  - *Suspended* -> *Ready*: \ A suspended task can be manually resumed by calling `vTaskResume()`.

3. *What is different if you create tasks with xTaskCreateStatic() instead of xTaskCreate()?*

  #link("https://www.freertos.org/Documentation/02-Kernel/04-API-references/01-Task-creation/02-xTaskCreateStatic", [xTaskCreateStatic]):

  With `xTaskCreateStatic()`, task's stack can be allocated statically and provided by the user.
  With, `xTaskCreate()`, RTOS dynamically allocates memory for the task's stack from its heap.

4. *What is the idle task?*

  #link("https://freertos.org/Documentation/02-Kernel/02-Kernel-features/01-Tasks-and-co-routines/15-Idle-task", [Idle task]):

  The idle task has the lowest priority and is created automatically by the scheduler.
  It is responsible for freeing memory of deleted tasks.

5. *What is the difference between xTaskDelay() and vTaskDelayUntil()? Which one is more appropriate for periodic tasks and why?*

  `xTaskDelay()` causes the task to enter the blocked state for a specified number of tick periods.
  `vTaskDelayUntil()` causes the task to enter the blocked state until a specified time. \

  `vTaskDelayUntil()` is more appropriate for periodic tasks because it allows to maintain a constant execution frequency compared to `xTaskDelay()`,
  which may get affected by interrupts and other blocking activity.


== Destruction / Suspension

=== Step 7, 8, 9

Code below includes implementation for steps 7, 8, and 9. I added a time logger
task to demonstrate that suspending a task does not affect the `vTaskDelay()`
function of other tasks, as they are still unblocked after the specified delay,
regardless of whether they were suspended during that delay or not.

This is, however, not the case if code tries to resume and suspend the task
immediately without letting that other task to run.

```c
// FreeRTOSConfig.h
#define configMAX_TASK_NAME_LEN 24
```

---

```c
// main.c
// FreeRTOS
#include <FreeRTOS.h>
#include <pico/platform/compiler.h>
#include <stdint.h>
#include <task.h>

/* C */
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>

/* Pico SDK */
#include "pico/stdlib.h"
#include "projdefs.h"

#define HELLO_WORLD_1_TASK_NAME "HELLO_TASK_1"
#define HELLO_WORLD_2_TASK_NAME "HELLO_TASK_2"
#define DELETER_TASK_NAME       "HELLO_TASK_DELETER"
#define HELLO_WORLD_TASK_NAME   "HELLO_WORLD_TASK"
#define SUSPENDER_TASK_NAME     "HELLO_TASK_SUSPENDER"
#define TIME_LOGGER_TASK_NAME   "TIME_LOGGER_TASK"

static volatile TickType_t xTicksDelayMs = pdMS_TO_TICKS(1000);

void vHelloTask(void *pvParameters) {
    const char *pcTaskName = pcTaskGetTaskName(NULL);

    printf("Starting %s...\n", pcTaskName);
    while (true) {
        char pcBuffer[100];

        int _ok = snprintf(
            pcBuffer,
            count_of(pcBuffer),
            "This is the %s saying: Hello, world!\n",
            pcTaskName
        );
        if (_ok < 0) {
            printf("Error formatting string for %s\n", pcTaskName);
            vTaskDelay(xTicksDelayMs);
            continue;
        }

        /* Print character by character. */
        for (int i = 0; i < count_of(pcBuffer) && pcBuffer[i] != '\0'; i++) {
            printf("%c", pcBuffer[i]);
        }

        vTaskDelay(xTicksDelayMs);
    }
}

void vHelloTaskDeleter(void *pvParameters) {
    const char *pcTaskName = pcTaskGetTaskName(NULL);
    printf("Starting %s...\n", pcTaskName);

    while (true) {
        vTaskDelay(pdMS_TO_TICKS(20000)); /* 20 seconds. */

        /* Get one of the hello tasks. */
        /* BUG: doing like below is dangerous if hello tasks also delete themselves. */
        TaskHandle_t xTaskToDelete = xTaskGetHandle(HELLO_WORLD_1_TASK_NAME);
        if (xTaskToDelete == NULL) {
            xTaskToDelete = xTaskGetHandle(HELLO_WORLD_2_TASK_NAME);
        }
        if (xTaskToDelete == NULL) {
            printf("Could not find task to delete!\n");
            vTaskDelete(NULL);
            return;
        }

        pcTaskName = pcTaskGetTaskName(xTaskToDelete);
        printf("Deleting task %s\n", pcTaskName);
        vTaskDelete(xTaskToDelete);
        printf("Deleted task %s\n", pcTaskName);
    }
}

void vHelloWorldTask(void *pvParameters) {
    const char *pcTaskName = pcTaskGetTaskName(NULL);
    printf("Starting %s...\n", pcTaskName);

    vTaskDelay(pdMS_TO_TICKS(10000)); /* 10 seconds. */
    printf("This is the %s saying: Hello, world!\n", pcTaskName);

    printf("%s is now deleting itself.\n", pcTaskName);
    vTaskDelete(NULL); /* Kill ourselves. */
}

void vTaskSuspender(void *pvParameters) {
    const char *pcTaskName = pcTaskGetTaskName(NULL);
    printf("Starting %s...\n", pcTaskName);

    while (true) {
        vTaskDelay(pdMS_TO_TICKS(5000)); /* 5 seconds. */
        TaskHandle_t xTaskToSuspend = xTaskGetHandle(HELLO_WORLD_TASK_NAME);
        if (xTaskToSuspend == NULL) {
            printf("Could not find task to suspend!\n");
            vTaskDelete(NULL);
            return;
        }

        pcTaskName = pcTaskGetTaskName(xTaskToSuspend);
        printf("Suspending task %s\n", pcTaskName);
        vTaskSuspend(xTaskToSuspend);
        printf("Suspended task %s\n", pcTaskName);
        vTaskDelay(pdMS_TO_TICKS(5000)); /* 5 seconds. */

        /* BUG: below is also dangerous if context switch occurs at `xTaskGetHandle()`
         * and without the `vTaskDelay()` in the beginning of the loop above. */
        if (eTaskGetState(xTaskToSuspend) == eDeleted) {
            printf("Task to resume %s is gone!\n", pcTaskName);
            continue;
        }

        printf("Resuming task %s\n", pcTaskName);
        vTaskResume(xTaskToSuspend);
        printf("Resumed task %s\n", pcTaskName);
    }
}

void vTimeLoggerTask(void *pvParameters) {
    const char *pcTaskName = pcTaskGetTaskName(NULL);
    printf("Starting %s...\n", pcTaskName);

    while (true) {
        TickType_t xTickCount = xTaskGetTickCount();
        uint32_t ulMs         = pdTICKS_TO_MS(xTickCount);
        printf(
            "Tick count: %u, time since scheduler start: %u ms\n",
            xTickCount,
            ulMs
        );
        vTaskDelay(pdMS_TO_TICKS(1000)); /* 1 second. */
    }
}

void vApplicationStackOverflowHook(TaskHandle_t xTask, char *pcTaskName) {
    panic("Stack overflow. Task: %s\n", pcTaskName);
}

void vApplicationMallocFailedHook() {
    panic("malloc failed");
}

int main() {
    stdio_init_all();
    sleep_ms(2000);

    printf("Starting Hello World FreeRTOS Demo...\n");

    BaseType_t result1 =
        xTaskCreate(vHelloTask, HELLO_WORLD_1_TASK_NAME, 512, NULL, 1, NULL);
    BaseType_t result2 =
        xTaskCreate(vHelloTask, HELLO_WORLD_2_TASK_NAME, 512, NULL, 1, NULL);

    BaseType_t result3 =
        xTaskCreate(vHelloTaskDeleter, DELETER_TASK_NAME, 512, NULL, 1, NULL);

    BaseType_t result4 =
        xTaskCreate(vHelloWorldTask, HELLO_WORLD_TASK_NAME, 512, NULL, 1, NULL);

    BaseType_t result5 =
        xTaskCreate(vTaskSuspender, SUSPENDER_TASK_NAME, 512, NULL, 1, NULL);

    BaseType_t result6 =
        xTaskCreate(vTimeLoggerTask, TIME_LOGGER_TASK_NAME, 512, NULL, 1, NULL);

    if ((result1 != pdPASS) || (result2 != pdPASS) || (result3 != pdPASS)
        || (result4 != pdPASS) || (result5 != pdPASS) || (result6 != pdPASS)) {
        printf("Task creation FAILED!\n");
        while (1)
            ;
    } else {
        printf("Task creation SUCCESS!\n");
    }

    vTaskStartScheduler();

    while (true) {
        printf("Running main..\n");
        sleep_ms(2000);
    }
}
```

Output:

```
Starting Hello World FreeRTOS Demo...
Task creation SUCCESS!
Starting HELLO_TASK_1...
TStarting HELLO_WORLD_TASK...
Starting HELLO_TASK_DELETER...
hStarting HELLO_TASK_2...
ThStarting HELLO_TASK_SUSPENDER...
Starting TIME_LOGGER_TASK...
Tick count: 4, time since scheduler start: 4 ms
is is the HELLOis is_TASK_1 saying: Hello, the world!
 HELLO_TASK_2 saying: Hello, world!
Tick count: 1004, time since scheduler start: 1004 ms
This is the HELLO_TASK_1 saying: Hello, Thiworld!
s is the HELLO_TASK_2 saying: Hello, world!
Tick count: 2004, time since scheduler start: 2004 ms
This is the HELLO_TASK_1 saying: Hello, world!
This is the HELLO_TASK_2 saying: Hello, world!
Tick count: 3004, time since scheduler start: 3004 ms
This is the HELLO_TASK_1 saying: Hello, world!
This is the HELLO_TASK_2 saying: Hello, world!
Tick count: 4004, time since scheduler start: 4004 ms
This is the HELLO_TASK_1 saying: Hello, world!This is
 the HELLO_TASK_2 saying: Hello, world!
Suspending task HELLO_WORLD_TASK
Suspended task HELLO_WORLD_TASK
Tick count: 5004, time since scheduler start: 5004 ms
This is the HELLO_TASK_1 saying: Hello, worThis isld!
 the HELLO_TASK_2 saying: Hello, world!
Tick count: 6004, time since scheduler start: 6004 ms
This is the HELLO_TASK_1 saying: Hello, world!
This is the HELLO_TASK_2 saying: Hello, world!
Tick count: 7004, time since scheduler start: 7004 ms
This is the HELLO_TASK_1 saying: Hello, world!
This is the HELLO_TASK_2 saying: Hello, world!
Tick count: 8004, time since scheduler start: 8004 ms
This is the HELLO_TASK_1 saying: Hello, world!
This is the HELLO_TASK_2 saying: Hello, world!
Tick count: 9004, time since scheduler start: 9004 ms
This is the HELLO_TASK_1 saying: Hello, world!
This is the HELLO_TASK_2 saying: Hello, world!
Resuming task HELLO_WORLD_TASK
Resumed task HELLO_WORLD_TASK
This is the HELLO_WORLD_TASK saying: Hello, world!
HELLO_WORLD_TASK is now deleting itself.
Tick count: 10004, time since scheduler start: 10004 ms
This is the HELLO_TASK_1 saying: Hello, world!
This is the HELLO_TASK_2 saying: Hello, world!
Tick count: 11004, time since scheduler start: 11004 ms
This is the HELLO_TASK_1 saying: Hello, world!
This is the HELLO_TASK_2 saying: Hello, world!
Tick count: 12004, time since scheduler start: 12004 ms
This is the HELLO_TASK_1 saying: Hello, world!
This is the HELLO_TASK_2 saying: Hello, world!
Tick count: 13004, time since scheduler start: 13004 ms
This is the HELLO_TASK_1 saying: Hello, world!
This is the HELLO_TASK_2 saying: Hello, world!
Tick count: 14004, time since scheduler start: 14004 ms
This is the HELLO_TASK_1 saying: Hello, world!
This is the HELLO_TASK_2 saying: Hello, world!
Could not find task to suspend!
Tick count: 15004, time since scheduler start: 15004 ms
This is the HELLO_TASK_1 saying: Hello, world!This i
s the HELLO_TASK_2 saying: Hello, world!
Tick count: 16004, time since scheduler start: 16004 ms
This is the HELLO_TASK_1 saying: This is the HHello,E world!
LLO_TASK_2 saying: Hello, world!
Tick count: 17004, time since scheduler start: 17004 ms
This is the HELLO_TASK_1 sayThis ising:  Hello, wthe HELLO_TASK_2orld! sayin
g: Hello, world!
Tick count: 18004, time since scheduler start: 18004 ms
This isThis i ts thhe He HEELLO_TLLO_TAASK_SK_2 say1 sayiing: Hello, worlng: Held!
lo, world!
Tick count: 19004, time since scheduler start: 19004 ms
This is the HELLO_ThTASKis_2 sa is the ying: HELLO_HelTlo, worlASK_1 sayid!
ng: Hello, world!
Deleting task HELLO_TASK_1
Deleted task HELLO_TASK_1
Tick count: 20004, time since scheduler start: 20004 ms
This is the HELLO_TASK_2 saying: Hello, world!
Tick count: 21004, time since scheduler start: 21004 ms
This is the HELLO_TASK_2 saying: Hello, world!
Tick count: 22004, time since scheduler start: 22004 ms
This is the HELLO_TASK_2 saying: Hello, world!
Tick count: 23004, time since scheduler start: 23004 ms
This is the HELLO_TASK_2 saying: Hello, world!
Tick count: 24004, time since scheduler start: 24004 ms
This is the HELLO_TASK_2 saying: Hello, world!
Tick count: 25004, time since scheduler start: 25004 ms
This is the HELLO_TASK_2 saying: Hello, world!
Tick count: 26004, time since scheduler start: 26004 ms
This is the HELLO_TASK_2 saying: Hello, world!
Tick count: 27004, time since scheduler start: 27004 ms
This is the HELLO_TASK_2 saying: Hello, world!
Tick count: 28004, time since scheduler start: 28004 ms
This is the HELLO_TASK_2 saying: Hello, world!
Tick count: 29004, time since scheduler start: 29004 ms
This is the HELLO_TASK_2 saying: Hello, world!
Tick count: 30004, time since scheduler start: 30004 ms
This is the HELLO_TASK_2 saying: Hello, world!
Tick count: 31004, time since scheduler start: 31004 ms
This is the HELLO_TASK_2 saying: Hello, world!
Tick count: 32004, time since scheduler start: 32004 ms
This is the HELLO_TASK_2 saying: Hello, world!
Tick count: 33004, time since scheduler start: 33004 ms
This is the HELLO_TASK_2 saying: Hello, world!
Tick count: 34004, time since scheduler start: 34004 ms
This is the HELLO_TASK_2 saying: Hello, world!
Tick count: 35004, time since scheduler start: 35004 ms
This is the HELLO_TASK_2 saying: Hello, world!
Tick count: 36004, time since scheduler start: 36004 ms
This is the HELLO_TASK_2 saying: Hello, world!
Tick count: 37004, time since scheduler start: 37004 ms
This is the HELLO_TASK_2 saying: Hello, world!
Tick count: 38004, time since scheduler start: 38004 ms
This is the HELLO_TASK_2 saying: Hello, world!
Tick count: 39004, time since scheduler start: 39004 ms
This is the HELLO_TASK_2 saying: Hello, world!
Deleting task HELLO_TASK_2
Deleted task HELLO_TASK_2
Tick count: 40004, time since scheduler start: 40004 ms
Tick count: 41004, time since scheduler start: 41004 ms
Tick count: 42004, time since scheduler start: 42004 ms
Tick count: 43004, time since scheduler start: 43004 ms
Tick count: 44004, time since scheduler start: 44004 ms
Tick count: 45004, time since scheduler start: 45004 ms
Tick count: 46004, time since scheduler start: 46004 ms
Tick count: 47004, time since scheduler start: 47004 ms
Tick count: 48004, time since scheduler start: 48004 ms
Tick count: 49004, time since scheduler start: 49004 ms
Tick count: 50004, time since scheduler start: 50004 ms
Tick count: 51004, time since scheduler start: 51004 ms
Tick count: 52004, time since scheduler start: 52004 ms
Tick count: 53004, time since scheduler start: 53004 ms
Tick count: 54004, time since scheduler start: 54004 ms
Tick count: 55004, time since scheduler start: 55004 ms
Tick count: 56004, time since scheduler start: 56004 ms
Tick count: 57004, time since scheduler start: 57004 ms
Tick count: 58004, time since scheduler start: 58004 ms
Tick count: 59004, time since scheduler start: 59004 ms
Could not find task to delete!
Tick count: 60004, time since scheduler start: 60004 ms
Tick count: 61004, time since scheduler start: 61004 ms
Tick count: 62004, time since scheduler start: 62004 ms
Tick count: 63004, time since scheduler start: 63004 ms
```

=== Step 10

Answer the following questions:

1. *What is a task handle? What data type is it and what does it mean?*

  Task handle is a reference to task's control block (TCB). Type is `TaskHandle_t`,
  stores pointer to top of the task's stack, linkage to core, task state, priority, and name.

  Task handle can be used to refer to a task when performing operations on it, such as deleting, suspending, or resuming the task.

2. *What happens if a task function returns?*

  If a task function returns, the task is not deleted and its stack remains allocated. This can lead to memory leaks and undefined behavior if the task is not properly cleaned up.

== Inter-task Communication (queues)

=== Step 11 <step_11>

Code:

```c
// FreeRTOS
#include <FreeRTOS.h>
#include <queue.h>
#include <task.h>

// C
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>

// Pico SDK
#include "pico/rand.h"
#include "pico/stdlib.h"
#include "portmacro.h"
#include "projdefs.h"

// Hardware button interrupt handler
void vButtonHandler(uint gpio, uint32_t events) {
    // This function will be called when the button is pressed
}

#define MESSAGE_SIZE 64

void vProducerTask(void *pvParameters) {
    QueueHandle_t xQueue   = (QueueHandle_t)pvParameters;
    const char *pcTaskName = pcTaskGetTaskName(NULL);

    int xSendI = 0;
    for (;;) {
        /* Was here originally: */
        /* vTaskDelay(((get_rand_32() % 1000) + 500)); */
        vTaskDelay(pdMS_TO_TICKS(1000));

        /* Produce an item. */
        char pcMessage[MESSAGE_SIZE];
        int _ok = snprintf(
            pcMessage, count_of(pcMessage), "%s ping %d", pcTaskName, xSendI
        );
        if (_ok < 0) {
            printf("Error formatting string for %s\n", pcTaskName);
            continue;
        }

        /* No-wait send to the queue. */
        if (xQueueSend(xQueue, (void *)pcMessage, (TickType_t)0) != pdPASS) {
            printf("Failed to send message to queue: full\n");
            continue;
        }

        xSendI++;
    }
}

void vConsumerTask(void *pvParameters) {
    QueueHandle_t xQueue   = (QueueHandle_t)pvParameters;
    const char *pcTaskName = pcTaskGetTaskName(NULL);

    int xRecvI = 0;
    for (;;) {
        char pcMessage[MESSAGE_SIZE];

        /* Wait indefinitely for an item to be received from the queue. */
        if (xQueueReceive(xQueue, (void *)pcMessage, portMAX_DELAY) == pdPASS) {
            printf("%s received: %s (msg %d)\n", pcTaskName, pcMessage, xRecvI);
            xRecvI++;
        } else {
            printf(
                "%s failed to receive message from queue: empty\n", pcTaskName
            );
        }
    }
}

void vApplicationStackOverflowHook(TaskHandle_t xTask, char *pcTaskName) {
    panic("Stack overflow. Task: %s\n", pcTaskName);
}

void vApplicationMallocFailedHook() {
    panic("malloc failed");
}

int main() {

    stdio_init_all();

    sleep_ms(2000);

    printf("Starting Queue FreeRTOS Demo...\n");

    QueueHandle_t xQueue = xQueueCreate(10, MESSAGE_SIZE);

    xTaskCreate(vProducerTask, "PRODUCER_TASK", 512, (void *)xQueue, 1, NULL);
    xTaskCreate(vProducerTask, "PRODUCER_TASK", 512, (void *)xQueue, 1, NULL);

    xTaskCreate(vConsumerTask, "CONSUMER_TASK", 512, (void *)xQueue, 1, NULL);

    vTaskStartScheduler();

    for (;;) {
        // Empty loop
    }
}
```

Output:

```
Starting Queue FreeRTOS Demo...
CONSUMER_TASK received: PRODUCER_TASK ping 0 (msg 0)
CONSUMER_TASK received: PRODUCER_TASK ping 0 (msg 1)
CONSUMER_TASK received: PRODUCER_TASK ping 1 (msg 2)
CONSUMER_TASK received: PRODUCER_TASK ping 1 (msg 3)
CONSUMER_TASK received: PRODUCER_TASK ping 2 (msg 4)
CONSUMER_TASK received: PRODUCER_TASK ping 2 (msg 5)
CONSUMER_TASK received: PRODUCER_TASK ping 3 (msg 6)
CONSUMER_TASK received: PRODUCER_TASK ping 3 (msg 7)
CONSUMER_TASK received: PRODUCER_TASK ping 4 (msg 8)
CONSUMER_TASK received: PRODUCER_TASK ping 4 (msg 9)
CONSUMER_TASK received: PRODUCER_TASK ping 5 (msg 10)
CONSUMER_TASK received: PRODUCER_TASK ping 5 (msg 11)
CONSUMER_TASK received: PRODUCER_TASK ping 6 (msg 12)
CONSUMER_TASK received: PRODUCER_TASK ping 6 (msg 13)
CONSUMER_TASK received: PRODUCER_TASK ping 7 (msg 14)
CONSUMER_TASK received: PRODUCER_TASK ping 7 (msg 15)
```

=== Step 12

#link("https://www.freertos.org/Documentation/02-Kernel/04-API-references/06-Queues/00-QueueManagement", [Queue management]).

Answer the following questions:

1. *Why should we use queues for inter-task communication instead of global variables?*

  Operations on a FreeRTOS queue are thread-safe, while operations on global variables
  are not by default and must manually synchronized.

2. *What happens if you try to send to a full queue or receive from an empty queue?*

  `xQueueSend()` has a wait parameter. If the wait time is exceeded, it returns `errQUEUE_FULL`.
  `xQueueReceive()` also has a wait parameter. If the wait time is exceeded, it returns `errQUEUE_EMPTY`.

3. *What does timeout mean in the context of queues?*

  Timeout is the maximum time a task will wait for a queue operation to complete before it returns with an error.
  Using `portMAX_DELAY` will cause the task to wait indefinitely.

4. *How could you implement the same behavior with counting semaphores instead of queues? (explanation is enough, no need to implement it)*

  A counting semaphore can be used to signal the availability of items produced by the producer task. The producer task would give the semaphore each time it produces an item, and the consumer task would take the semaphore before consuming an item.
  This allows for implementation of 1-to-1 and 1-to-many producer-consumer relationships.

5. *Why are semaphores often used for synchronization between tasks and ISRs?*

  Semaphores are often used for synchronization between tasks and ISRs because they allow to
  signal consumers and producers about changes to the queue data without them having to busy-block
  and hold the CPU.

== Interrupt Handling

=== Step 13

Direct to task notification was used (Page 270 of FreeRTOS Manual@manual).

Code:

```c
// FreeRTOS
#include <FreeRTOS.h>
#include <queue.h>
#include <stdint.h>
#include <task.h>

// C
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>

// Pico SDK
#include "pico/rand.h"
#include "pico/stdlib.h"
#include "portmacro.h"
#include "projdefs.h"

#define MESSAGE_SIZE 64
#define BUTTON_PIN   0

TaskHandle_t xButtonProducerTaskHandle = NULL;

// Hardware button interrupt handler
void vButtonHandler(uint gpio, uint32_t events) {
    // This function will be called when the button is pressed
    if (gpio == BUTTON_PIN && (events & GPIO_IRQ_EDGE_FALL)
        && xButtonProducerTaskHandle != NULL) {
        /* Page 270 of Mastering-the-FreeRTOS-Real-Time-Kernel.v1.0.pdf. */
        BaseType_t xHigherPriorityTaskWoken = pdFALSE;
        vTaskNotifyGiveFromISR(
            xButtonProducerTaskHandle, &xHigherPriorityTaskWoken
        );
        portYIELD_FROM_ISR(xHigherPriorityTaskWoken);
    }
}

void vButtonProducerTask(void *pvParameters) {
    QueueHandle_t xQueue   = (QueueHandle_t)pvParameters;
    const char *pcTaskName = pcTaskGetTaskName(NULL);

    for (;;) {
        /* Wait for a notification from the button interrupt handler. */
        uint32_t ulEventsToProcess = ulTaskNotifyTake(pdTRUE, portMAX_DELAY);
        if (ulEventsToProcess == 0) {
            printf("%s: No events to process, spurious wakeup?\n", pcTaskName);
            continue;
        }

        /* Produce an item. */
        char pcMessage[MESSAGE_SIZE];
        int _ok = snprintf(
            pcMessage, count_of(pcMessage), "%s button pressed", pcTaskName
        );
        if (_ok < 0) {
            printf("Error formatting string for %s\n", pcTaskName);
            continue;
        }

        /* No-wait send to the queue. */
        if (xQueueSend(xQueue, (void *)pcMessage, (TickType_t)0) != pdPASS) {
            printf("Failed to send message to queue: full\n");
            continue;
        }
    }
}

void vProducerTask(void *pvParameters) {
    QueueHandle_t xQueue   = (QueueHandle_t)pvParameters;
    const char *pcTaskName = pcTaskGetTaskName(NULL);

    int xSendI = 0;
    for (;;) {
        /* Was here originally: */
        /* vTaskDelay(((get_rand_32() % 1000) + 500)); */
        vTaskDelay(pdMS_TO_TICKS(1000));

        /* Produce an item. */
        char pcMessage[MESSAGE_SIZE];
        int _ok = snprintf(
            pcMessage, count_of(pcMessage), "%s ping %d", pcTaskName, xSendI
        );
        if (_ok < 0) {
            printf("Error formatting string for %s\n", pcTaskName);
            continue;
        }

        /* No-wait send to the queue. */
        if (xQueueSend(xQueue, (void *)pcMessage, (TickType_t)0) != pdPASS) {
            printf("Failed to send message to queue: full\n");
            continue;
        }

        xSendI++;
    }
}

void vConsumerTask(void *pvParameters) {
    QueueHandle_t xQueue   = (QueueHandle_t)pvParameters;
    const char *pcTaskName = pcTaskGetTaskName(NULL);

    int xRecvI = 0;
    for (;;) {
        char pcMessage[MESSAGE_SIZE];

        /* Wait indefinitely for an item to be received from the queue. */
        if (xQueueReceive(xQueue, (void *)pcMessage, portMAX_DELAY) == pdPASS) {
            printf("%s received: %s (msg %d)\n", pcTaskName, pcMessage, xRecvI);
            xRecvI++;
        } else {
            printf(
                "%s failed to receive message from queue: empty\n", pcTaskName
            );
        }
    }
}

void vApplicationStackOverflowHook(TaskHandle_t xTask, char *pcTaskName) {
    panic("Stack overflow. Task: %s\n", pcTaskName);
}

void vApplicationMallocFailedHook() {
    panic("malloc failed");
}

int main() {

    stdio_init_all();

    gpio_init(BUTTON_PIN);
    gpio_set_dir(BUTTON_PIN, GPIO_IN);
    gpio_pull_up(BUTTON_PIN);

    gpio_set_irq_enabled_with_callback(
        BUTTON_PIN, GPIO_IRQ_EDGE_FALL, true, &vButtonHandler
    );

    sleep_ms(2000);

    printf("Starting Queue FreeRTOS Demo...\n");

    QueueHandle_t xQueue = xQueueCreate(10, MESSAGE_SIZE);

    xTaskCreate(vProducerTask, "PRODUCER_TASK", 512, (void *)xQueue, 1, NULL);
    xTaskCreate(vProducerTask, "PRODUCER_TASK", 512, (void *)xQueue, 1, NULL);
    xTaskCreate(
        vButtonProducerTask,
        "BUTTON_PRODUCER_TASK",
        512,
        (void *)xQueue,
        1,
        &xButtonProducerTaskHandle
    );

    xTaskCreate(vConsumerTask, "CONSUMER_TASK", 512, (void *)xQueue, 1, NULL);

    vTaskStartScheduler();

    for (;;) {
        // Empty loop
    }
}
```

Output:

```
Starting Queue FreeRTOS Demo...
CONSUMER_TASK received: PRODUCER_TASK ping 0 (msg 0)
CONSUMER_TASK received: PRODUCER_TASK ping 0 (msg 1)
CONSUMER_TASK received: BUTTON_PRODUCER_TASK button pressed (msg 2)
CONSUMER_TASK received: BUTTON_PRODUCER_TASK button pressed (msg 3)
CONSUMER_TASK received: BUTTON_PRODUCER_TASK button pressed (msg 4)
CONSUMER_TASK received: BUTTON_PRODUCER_TASK button pressed (msg 5)
CONSUMER_TASK received: PRODUCER_TASK ping 1 (msg 6)
CONSUMER_TASK received: PRODUCER_TASK ping 1 (msg 7)
CONSUMER_TASK received: BUTTON_PRODUCER_TASK button pressed (msg 8)
CONSUMER_TASK received: PRODUCER_TASK ping 2 (msg 9)
CONSUMER_TASK received: PRODUCER_TASK ping 2 (msg 10)
CONSUMER_TASK received: BUTTON_PRODUCER_TASK button pressed (msg 11)
CONSUMER_TASK received: BUTTON_PRODUCER_TASK button pressed (msg 12)
CONSUMER_TASK received: BUTTON_PRODUCER_TASK button pressed (msg 13)
CONSUMER_TASK received: BUTTON_PRODUCER_TASK button pressed (msg 14)
CONSUMER_TASK received: BUTTON_PRODUCER_TASK button pressed (msg 15)
CONSUMER_TASK received: PRODUCER_TASK ping 3 (msg 16)
CONSUMER_TASK received: PRODUCER_TASK ping 3 (msg 17)
CONSUMER_TASK received: PRODUCER_TASK ping 4 (msg 18)
CONSUMER_TASK received: PRODUCER_TASK ping 4 (msg 19)
CONSUMER_TASK received: PRODUCER_TASK ping 5 (msg 20)
CONSUMER_TASK received: PRODUCER_TASK ping 5 (msg 21)
```

== Mutual Exclusion

=== Step 14

Code:

```c
// FreeRTOS
#include <FreeRTOS.h>
#include <pico/platform/compiler.h>
#include <semphr.h>
#include <task.h>

/* C */
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>

/* Pico SDK */
#include "pico/stdlib.h"

static volatile TickType_t xTicksDelayMs = pdMS_TO_TICKS(1000);

void vHelloTask(void *pvParameters) {
    const char *pcTaskName       = pcTaskGetTaskName(NULL);
    SemaphoreHandle_t xSemaphore = (SemaphoreHandle_t)pvParameters;

    printf("Starting %s...\n", pcTaskName);
    while (true) {
        char pcBuffer[100];

        int _ok = snprintf(
            pcBuffer,
            count_of(pcBuffer),
            "This is the %s saying: Hello, world!\n",
            pcTaskName
        );
        if (_ok < 0) {
            printf("Error formatting string for %s\n", pcTaskName);
            vTaskDelay(xTicksDelayMs);
            continue;
        }

        /* Print character by character. */
        xSemaphoreTake(xSemaphore, portMAX_DELAY);
        for (int i = 0; i < count_of(pcBuffer) && pcBuffer[i] != '\0'; i++) {
            printf("%c", pcBuffer[i]);
        }
        xSemaphoreGive(xSemaphore);

        vTaskDelay(xTicksDelayMs);
    }
}

void vApplicationStackOverflowHook(TaskHandle_t xTask, char *pcTaskName) {
    panic("Stack overflow. Task: %s\n", pcTaskName);
}

void vApplicationMallocFailedHook() {
    panic("malloc failed");
}

int main() {
    stdio_init_all();
    sleep_ms(2000);

    printf("Starting Hello World FreeRTOS Demo...\n");

    SemaphoreHandle_t xSemaphore = xSemaphoreCreateMutex();
    if (xSemaphore == NULL) {
        printf("Failed to create mutex!\n");
        while (1)
            ;
    }

    BaseType_t result1 =
        xTaskCreate(vHelloTask, "HELLO_TASK_1", 512, xSemaphore, 1, NULL);
    BaseType_t result2 =
        xTaskCreate(vHelloTask, "HELLO_TASK_2", 512, xSemaphore, 1, NULL);

    if ((result1 != pdPASS) || (result2 != pdPASS)) {
        printf("Task creation FAILED!\n");
        while (1)
            ;
    } else {
        printf("Task creation SUCCESS!\n");
    }

    vTaskStartScheduler();

    while (true) {
        printf("Running main..\n");
        sleep_ms(2000);
    }
}
```

Output:

```
Starting Hello World FreeRTOS Demo...
Task creation SUCCESS!
Starting HELLO_TASK_1...
ThStarting HELLO_TASK_2...
is is the HELLO_TASK_1 saying: Hello, world!
This is the HELLO_TASK_2 saying: Hello, world!
This is the HELLO_TASK_1 saying: Hello, world!
This is the HELLO_TASK_2 saying: Hello, world!
This is the HELLO_TASK_1 saying: Hello, world!
This is the HELLO_TASK_2 saying: Hello, world!
This is the HELLO_TASK_1 saying: Hello, world!
This is the HELLO_TASK_2 saying: Hello, world!
This is the HELLO_TASK_1 saying: Hello, world!
This is the HELLO_TASK_2 saying: Hello, world!
This is the HELLO_TASK_1 saying: Hello, world!
This is the HELLO_TASK_2 saying: Hello, world!
```

=== Step 15

==== Asymmetric solution

Code:

```c
void vPhilosopher(void *num) {
    int id    = (int)num;
    int left  = id;
    int right = (id + 1) % N;

    vTaskDelay(100);

    while (1) {
        printf("Philosopher %d is thinking...\n", id);
        vTaskDelay((get_rand_32() % 100 + 50));

        printf("Philosopher %d is hungry...\n", id);
        if (id == 0) {
            xSemaphoreTake(forks[left], portMAX_DELAY);
            vTaskDelay(200);
            xSemaphoreTake(forks[right], portMAX_DELAY);
        } else {
            xSemaphoreTake(forks[right], portMAX_DELAY);
            vTaskDelay(200);
            xSemaphoreTake(forks[left], portMAX_DELAY);
        }

        printf("Philosopher %d is eating...\n", id);
        vTaskDelay(100);

        xSemaphoreGive(forks[right]);
        xSemaphoreGive(forks[left]);
    }
}
```

Output:

```
Starting Philosophers FreeRTOS Demo...
Philosopher 0 is thinking...
Philosopher 1 is thinking...
Philosopher 3 is thinking...
Philosopher 4 is thinking...
Philosopher 2 is thinking...
Philosopher 3 is hungry...
Philosopher 2 is hungry...
Philosopher 4 is hungry...
Philosopher 1 is hungry...
Philosopher 0 is hungry...
Philosopher 1 is eating...
Philosopher 1 is thinking...
Philosopher 2 is eating...
Philosopher 2 is thinking...
Philosopher 3 is eating...
Philosopher 1 is hungry...
Philosopher 3 is thinking...
Philosopher 4 is eating...
Philosopher 2 is hungry...
Philosopher 3 is hungry...
Philosopher 4 is thinking...
Philosopher 1 is eating...
Philosopher 4 is hungry...
Philosopher 1 is thinking...
```

==== Room limit solution

Code:

```c
SemaphoreHandle_t room;

#define ROOM_LIMIT (N - 1)

void vPhilosopher(void *num) {
    int id    = (int)num;
    int left  = id;
    int right = (id + 1) % N;

    vTaskDelay(100);

    while (1) {
        xSemaphoreTake(room, portMAX_DELAY);

        printf("Philosopher %d is thinking...\n", id);
        vTaskDelay(((get_rand_32() % 100) + 50));

        printf("Philosopher %d is hungry...\n", id);
        xSemaphoreTake(forks[left], portMAX_DELAY);
        vTaskDelay(200);
        xSemaphoreTake(forks[right], portMAX_DELAY);

        printf("Philosopher %d is eating...\n", id);
        vTaskDelay(100);

        xSemaphoreGive(forks[right]);
        xSemaphoreGive(forks[left]);

        xSemaphoreGive(room);
        portYIELD(); /* IMPORTANT: otherwise the same philosopher immediately
                        grabs the semaphore and can starve others. */
    }
}
```

Output:

```
Starting Philosophers FreeRTOS Demo...
Philosopher 0 is thinking...
Philosopher 1 is thinking...
Philosopher 2 is thinking...
Philosopher 3 is thinking...
Philosopher 1 is hungry...
Philosopher 0 is hungry...
Philosopher 3 is hungry...
Philosopher 2 is hungry...
Philosopher 3 is eating...
Philosopher 2 is eating...
Philosopher 4 is thinking...
Philosopher 4 is hungry...
Philosopher 1 is eating...
Philosopher 3 is thinking...
Philosopher 3 is hungry...
Philosopher 0 is eating...
Philosopher 2 is thinking...
Philosopher 4 is eating...
Philosopher 1 is thinking...
Philosopher 2 is hungry...
Philosopher 3 is eating...
Philosopher 0 is thinking...
Philosopher 1 is hungry...
Philosopher 0 is hungry...
```

==== Back-off solution

Code:

```c
#define ACQUIRE_TIMEOUT pdMS_TO_TICKS(100)

void vPhilosopher(void *num) {
    int id    = (int)num;
    int left  = id;
    int right = (id + 1) % N;

    vTaskDelay(100);

    while (1) {
        printf("Philosopher %d is thinking...\n", id);
        vTaskDelay(((get_rand_32() % 100) + 50));

        printf("Philosopher %d is hungry...\n", id);
        while (1) {
            if (xSemaphoreTake(forks[left], ACQUIRE_TIMEOUT) == pdFALSE) {
                printf("Philosopher %d FAIL left fork. Retrying...\n", id);
                vTaskDelay(((get_rand_32() % 100) + 50));
                continue;
            }

            vTaskDelay(200);
            if (xSemaphoreTake(forks[right], ACQUIRE_TIMEOUT) == pdFALSE) {
                printf(
                    "Philosopher %d FAIL right fork. Releasing left and "
                    "retrying...\n",
                    id
                );
                xSemaphoreGive(forks[left]);
                vTaskDelay(((get_rand_32() % 100) + 50));
                continue;
            }

            break;
        }

        printf("Philosopher %d is eating...\n", id);
        vTaskDelay(100);

        xSemaphoreGive(forks[right]);
        xSemaphoreGive(forks[left]);
    }
}
```

Output:

```
Starting Philosophers FreeRTOS Demo...
Philosopher 0 is thinking...
Philosopher 1 is thinking...
Philosopher 2 is thinking...
Philosopher 3 is thinking...
Philosopher 4 is thinking...
Philosopher 2 is hungry...
Philosopher 4 is hungry...
Philosopher 1 is hungry...
Philosopher 3 is hungry...
Philosopher 0 is hungry...
Philosopher 2 FAIL right fork. Releasing left and retrying...
Philosopher 1 is eating...
Philosopher 4 FAIL right fork. Releasing left and retrying...
Philosopher 3 is eating...
Philosopher 0 FAIL right fork. Releasing left and retrying...
Philosopher 1 is thinking...
Philosopher 3 is thinking...
Philosopher 3 is hungry...
Philosopher 1 is hungry...
Philosopher 0 FAIL right fork. Releasing left and retrying...
Philosopher 4 is eating...
Philosopher 2 FAIL right fork. Releasing left and retrying...
Philosopher 1 is eating...
```

=== Step 16

Answer the following questions:

1. *What is a semaphore and how does it differ from a mutex?*

  A semaphore is a synchronization primitive that can be used to control access
  to a shared resource.

  A mutex is a special type of binary semaphore that is used to control access
  to a resource that is shared between two or more tasks (Page 205 of FreeRTOS Manual @manual).
  The difference from a binary semaphore is that a mutex has a concept of ownership,
  meaning that the task that takes the mutex is the only one that can give it back. This prevents priority inversion and ensures that the resource is released properly.

2. *In what situations is a mutex more appropriate than a semaphore?*

  A mutex is more appropriate than a semaphore when you need to protect a shared resource that can only be accessed by *one* task at a time, and you want to prevent priority inversion. Mutex in FreeRTOS has built-in priority inheritance mechanism that helps to prevent priority inversion, while a binary semaphore does not have this feature.

== Scheduling

=== Step 17

The lowest priority is 0, and the highest priority is `configMAX_PRIORITIES - 1` (Page 58 of FreeRTOS Manual @manual).

Code:

```c
// FreeRTOS
#include <FreeRTOS.h>
#include <pico/platform/compiler.h>
#include <semphr.h>
#include <task.h>

/* C */
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>

/* Pico SDK */
#include "pico/stdlib.h"

static volatile TickType_t xTicksDelayMs = pdMS_TO_TICKS(1000);

void vHelloTask(void *pvParameters) {
    const char *pcTaskName       = pcTaskGetTaskName(NULL);
    SemaphoreHandle_t xSemaphore = (SemaphoreHandle_t)pvParameters;

    printf("Starting %s...\n", pcTaskName);
    while (true) {
        char pcBuffer[100];

        int _ok = snprintf(
            pcBuffer,
            count_of(pcBuffer),
            "This is the %s saying: Hello, world!\n",
            pcTaskName
        );
        if (_ok < 0) {
            printf("Error formatting string for %s\n", pcTaskName);
            vTaskDelay(xTicksDelayMs);
            continue;
        }

        /* Print character by character. */
        xSemaphoreTake(xSemaphore, portMAX_DELAY);
        for (int i = 0; i < count_of(pcBuffer) && pcBuffer[i] != '\0'; i++) {
            printf("%c", pcBuffer[i]);
        }
        _ok = fflush(stdout);
        configASSERT(_ok == 0);
        xSemaphoreGive(xSemaphore);

        // vTaskDelay(xTicksDelayMs);
    }
}

void vHelloTaskGreedy(__attribute__((unused)) void *pvParameters) {
    const char *pcTaskName = pcTaskGetTaskName(NULL);

    printf("Starting %s...\n", pcTaskName);
    while (1)
        ;
}

void vApplicationStackOverflowHook(TaskHandle_t xTask, char *pcTaskName) {
    panic("Stack overflow. Task: %s\n", pcTaskName);
}

void vApplicationMallocFailedHook() {
    panic("malloc failed");
}

int main() {
    stdio_init_all();
    sleep_ms(2000);

    printf("Starting Hello World FreeRTOS Demo...\n");

    SemaphoreHandle_t xSemaphore = xSemaphoreCreateMutex();
    if (xSemaphore == NULL) {
        printf("Failed to create mutex!\n");
        while (1)
            ;
    }

    TaskHandle_t t1 = NULL;
    TaskHandle_t t2 = NULL;
    TaskHandle_t t3 = NULL;

    BaseType_t result1 =
        xTaskCreate(vHelloTask, "HELLO_TASK_1", 512, xSemaphore, 1, &t1);
    BaseType_t result2 =
        xTaskCreate(vHelloTask, "HELLO_TASK_2", 512, xSemaphore, 1, &t2);
    BaseType_t result3 = xTaskCreate(
        vHelloTask,
        "HELLO_TASK_3",
        512,
        xSemaphore,
        configMAX_PRIORITIES - 1,
        &t3
    );

    if ((result1 != pdPASS) || (result2 != pdPASS) || (result3 != pdPASS)) {
        printf("Task creation FAILED!\n");
        while (1)
            ;
    } else {
        printf("Task creation SUCCESS!\n");
    }

    vTaskCoreAffinitySet(t1, 1 << 0);  // Run on core 0
    vTaskCoreAffinitySet(t2, 1 << 0);  // Run on core 0
    vTaskCoreAffinitySet(t3, 1 << 0);  // Run on core 0

    vTaskStartScheduler();

    while (true) {
        // printf("Running main..\n");
        // sleep_ms(2000);
    }
}
```

Output:

```
This is the HELLO_TASK_3 saying: Hello, world!
This is the HELLO_TASK_3 saying: Hello, world!
This is the HELLO_TASK_3 saying: Hello, world!
This is the HELLO_TASK_3 saying: Hello, world!
This is the HELLO_TASK_3 saying: Hello, world!
This is the HELLO_TASK_3 saying: Hello, world!
This is the HELLO_TASK_3 saying: Hello, world!
This is the HELLO_TASK_3 saying: Hello, world!
This is the HELLO_TASK_3 saying: Hello, world!
This is the HELLO_TASK_3 saying: Hello, world!
This is the HELLO_TASK_3 saying: Hello, world!
This is the HELLO_TASK_3 saying: Hello, world!
This is the HELLO_TASK_3 saying: Hello, world!
This is the HELLO_TASK_3 saying: Hello, world!
This is the HELLO_TASK_3 saying: Hello, world!
This is the HELLO_TASK_3 saying: Hello, world!
This is the HELLO_TASK_3 saying: Hello, world!
This is the HELLO_TASK_3 saying: Hello, world!
This is the HELLO_TASK_3 saying: Hello, world!
This is the HELLO_TASK_3 saying: Hello, world!
This is the HELLO_TASK_3 saying: Hello, world!
This is the HELLO_TASK_3 saying: Hello, world!
```

==== How to fix starvation

Starvation above only occurs if all tasks run on one core (or there are 2 highest priority tasks), and
the highest priority task(s) run either `vHelloTask()` or `vHelloTaskGreedy()`.

- If the highest priority task runs `vHelloTask()`, then adding a delay after printing the message will allow lower priority tasks to run and print their messages as well.
- Using multiple cores and setting core affinity of the greedy task to a different core than the other tasks will allow the other tasks to run on their core without being preempted by the greedy task.
- Wake up the highest priority task(s) only when needed.
- Using priority inheritance.

=== Step 18

At first, I fixed an issues that the binary semaphore was initially in the locked
state, and neither low or high priority task could take it.

Code:

```c
// FreeRTOS
#include <FreeRTOS.h>
#include <queue.h>
#include <semphr.h>
#include <task.h>

// C
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>

// Pico SDK
#include "pico/rand.h"
#include "pico/stdlib.h"

SemaphoreHandle_t sharedMutex;

void lowTask(void *p) {
    while (1) {
        xSemaphoreTake(sharedMutex, portMAX_DELAY);
        printf("Low: holding mutex\n");
        vTaskDelay(2000);  // simulate long work
        printf("Low: releasing mutex\n");
        xSemaphoreGive(sharedMutex);
        vTaskDelay(1000);
    }
}

void mediumTask(void *p) {
    while (1) {
        printf("Medium: running\n");
        vTaskDelay(10000);
    }
}

void highTask(void *p) {
    vTaskDelay(500);  // let low grab mutex first

    while (1) {
        printf("High: wants mutex\n");
        xSemaphoreTake(sharedMutex, portMAX_DELAY);
        printf("High: got mutex\n");
        xSemaphoreGive(sharedMutex);
        vTaskDelay(1000);
    }
}

void vApplicationStackOverflowHook(TaskHandle_t xTask, char *pcTaskName) {
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
    xSemaphoreGive(sharedMutex);  // start as available

    xTaskCreate(lowTask, "Low", 256, NULL, 1, NULL);
    xTaskCreate(mediumTask, "Medium", 256, NULL, 2, NULL);
    xTaskCreate(highTask, "High", 256, NULL, 3, NULL);

    vTaskStartScheduler();
}
```

Output:

```
Starting Inversion FreeRTOS Demo...
Medium: running
Low: holding mutex
High: wants mutex
Medium: running
Medium: running
Medium: running
Medium: running
Low: releasing mutex
High: got mutex
```

The output demonstrates priority inversion, where:

1. Low grabs the semaphore.
2. High blocks because low holds the semaphore.
3. Medium runs and does not let the low task to release the semaphore. Even though high is in the Ready state, if medium ran an operation that blocks for a long time, high would not be able to run until medium finishes, which can lead to unbounded priority inversion.
4. Eventually, low releases the semaphore and high can acquire it.

This breaks the real-time guarantees of the system, as the high priority task is blocked for an unbounded amount of time when it is already in the Ready state.

To fix this, we can use priority inheritance by creating the mutex with `xSemaphoreCreateMutex()`, which will automatically boost the priority of the low task to that of the high task when the high task is blocked on the mutex. Thus, the amount of time that priority inversion exists is minimized (From page 227 of FreeRTOS Manual @manual).

```c
// sharedMutex = xSemaphoreCreateBinary();
// xSemaphoreGive(sharedMutex);  // start as available
sharedMutex = xSemaphoreCreateMutex();
```

=== Step 19

Answer the following questions:

1. *What is the difference between preemptive and cooperative scheduling?*

  In cooperative scheduling, a context switch only occurs when the Running state
  task enters the Blocked state, or the Running state task explicitly yields.
  Tasks are never preempted by the scheduler (Page 101 of FreeRTOS Manual @manual).

  In preemptive scheduling, a context switch can occur at any time, and the scheduler can preempt the Running state task to switch to another task that has a higher priority or is in the Ready state. These properties are defined by `configUSE_PREEMPTION` and `configUSE_TIME_SLICING` configuration options in FreeRTOS.

2. *What scheduling algorithm does FreeRTOS use? What are the advantages and disadvantages of this algorithm?*

  FreeRTOS uses a Fixed Priority Preemptive Scheduling with Time Slicing. There
  are configuration options to enable or disable preemption and time slicing
  (`configUSE_PREEMPTION` and `configUSE_TIME_SLICING`).

  A task with the highest priority is always selected to run or round-robin
  scheduling is used if there are multiple tasks in the ready state with the same priority.

  Advantages:
  - Allows for real-time behavior by ensuring that high-priority tasks can preempt lower-priority tasks.
  Disadvantages:
  - Can lead to priority inversion if a high-priority task is waiting for a resource held by a lower-priority task (consequence of combining priority preemption and semaphores, more a nuance than a disadvantage).
  - Can lead to starvation of lower-priority tasks if higher-priority tasks are always ready to run.

== Timers

=== Step 20

Code:

```c
void vTimerCallback(TimerHandle_t xExpiredTimer) {
    printf(
        "Timer callback, timer id is %d\n",
        (int)(intptr_t)pvTimerGetTimerID(xExpiredTimer)
    );
}

int main() {
    // ...

    TimerHandle_t xTimer = xTimerCreate(
        "HelloTimer", pdMS_TO_TICKS(2000), pdTRUE, NULL, vTimerCallback
    );
    xTimerStart(xTimer, 0);

    // ...
}
```

Output:

```
Starting Hello World FreeRTOS Demo...
Starting HELLO_TASK_1...
TStarting HELLO_TASK_2...
his is the HELLO_TASK_1 saying: Hello, world!
This is the HELLO_TASK_2 saying: Hello, world!
This is the HELLO_TASK_1 saying: Hello, world!
This is the HELLO_TASK_2 saying: Hello, world!
Timer callback, timer id is 0
This is the HELLO_TASK_1 saying: Hello, world!
This is the HELLO_TASK_2 saying: Hello, world!
This is the HELLO_TASK_1 saying: Hello, world!
This is the HELLO_TASK_2 saying: Hello, world!
Timer callback, timer id is 0
```

=== Step 21

Answer the following questions:

1. *What is the difference between a software timer and a hardware timer?*

  Software timers are fully implemented in the FreeRTOS kernel and do not require
  hardware support (counters or HW timers).

2. *How do software timers work in FreeRTOS? Where are they executed?*

  Software timers in FreeRTOS are implemented using a timer (daemon) task that is created
  automatically and runs at `configTIMER_TASK_PRIORITY` priority. The timer task maintains a list of active timers and checks for expired timers at regular intervals.

3. *What is a timer callback function and when called?*

  When a timer expires, the timer task executes the associated callback function.
  The callback function is a C function with return type `void` and a single parameter of type `TimerHandle_t`. The callback function is called in the context of the timer task, so it should not block or perform long-running operations.

4. *What happens if a timer callback function takes too long to execute?*

  If a timer callback function takes too long to execute or blocks (and therefore blocks the daemon task), it can delay the execution of other timers and potentially cause missed deadlines, since the timer task is responsible for checking and executing timers.

Reference: Software Time Management at Page 143 of FreeRTOS Manual @manual.

== Extras (for higher grade)

=== Step 22. Thread local storage

Reference: Page 94 of FreeRTOS Manual @manual.

Thread Local Storage (TLS) allows a task to store arbitrary data in its TCB, which can be accessed by the task itself and is not shared with other tasks. This can be useful for libraries that need to maintain state on a per-task basis without requiring the user to manage that state explicitly.

Common use-case is a library that uses global variables to store its state, but we want to use that library in multiple tasks with different configurations, where using the library directly is not thread-safe. By using TLS, each task can have its own instance of the library's state without interfering with each other.

In the example below I took a portion of the #link("https://gitlab.com/epelas/ecava/-/blob/master/include/lcd/jhd1804.h", [JHD1804 LCD library from the Ecava project]) and modified it to use TLS for storing the LCD configuration. The original library source code uses an LCD config argument for each function call, but in this scenario one could imagine the authors simply used a global variables to store a shared LCD configuration, which would make it impossible to use multiple LCD displays.

Code:

```c
/*
 * Code referencing parts of the JHD1804 library,
 * namely the config and write logic, is licensed under Apache-2.0,
 * Copyright 2025 Kiril V. Strezikozin, Zurab Kvachadze, the Ecava project.
 * Source available at <https://gitlab.com/epelas/ecava>.
 */

// FreeRTOS
#include <FreeRTOS.h>
#include <semphr.h>
#include <task.h>

/* C */
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>

/* Pico SDK */
#include "hardware/i2c.h"
#include "pico/stdlib.h"

#define LCD_TLS_INDEX 0

/* JHD1804 LCD configuration. */
typedef struct {
    i2c_inst_t *i2c;
    uint8_t addr;
} jhd1804_lcd_config;

/* (Mocked) Write the given byte into the JHD1804 LCD I2C bus. */
void jhd1804_lcd_putc(char c) {
    /* Reach into the current task's TLS to find the config. */
    jhd1804_lcd_config *pxConfig = (jhd1804_lcd_config *)
        pvTaskGetThreadLocalStoragePointer(NULL, LCD_TLS_INDEX);

    if (pxConfig != NULL) {
        /* Mocked I2C write with a `printf`. */
        printf(
            "[I2C-%d at 0x%02X] LCD Char: %c\n",
            i2c_get_index(pxConfig->i2c),
            pxConfig->addr,
            c
        );
    } else {
        printf("[ERROR] No LCD Config found in TLS for current task!\n");
    }
}

/* Write the given array of bytes into the JHD1804 LCD I2C bus.
 *
 * Use this function to write strings.
 *
 * \param data Pointer to the data array.
 */
static inline void jhd1804_lcd_puts(const char *data) {
    uint8_t byte = 0;
    while ((byte = *data++)) {
        jhd1804_lcd_putc(byte);
    }
}

void vLCDPutTask(void *pvParameters) {
    /* Receive the initial config via task parameters. */
    jhd1804_lcd_config *pxMyConfig = (jhd1804_lcd_config *)pvParameters;
    const char *pcTaskName         = pcTaskGetTaskName(NULL);

    /* Store this pointer in this task's private TLS slot.
     * All future calls to the library will now use configuration of this task.
     */
    vTaskSetThreadLocalStoragePointer(NULL, LCD_TLS_INDEX, (void *)pxMyConfig);

    printf("Starting %s (Targeting 0x%02X)...\n", pcTaskName, pxMyConfig->addr);

    while (true) {
        /* Call the library with the fixed API.
         * The library will automatically use the correct I2C address. */
        jhd1804_lcd_puts(pcTaskName);

        vTaskDelay(pdMS_TO_TICKS(2000));
    }
}

void vApplicationStackOverflowHook(TaskHandle_t xTask, char *pcTaskName) {
    panic("Stack overflow. Task: %s\n", pcTaskName);
}

void vApplicationMallocFailedHook() {
    panic("malloc failed");
}

int main() {
    stdio_init_all();
    sleep_ms(2000);

    printf("Starting TLS LCD Dispatcher Demo...\n");

    /* Create two different configurations for two different physical LCDs */
    static jhd1804_lcd_config xLcdConfig1 = {.i2c = i2c0, .addr = 0x3E};
    static jhd1804_lcd_config xLcdConfig2 = {.i2c = i2c1, .addr = 0x3F};

    xTaskCreate(vLCDPutTask, "LCD_1", 512, &xLcdConfig1, 1, NULL);
    xTaskCreate(vLCDPutTask, "LCD_2", 512, &xLcdConfig2, 1, NULL);

    vTaskStartScheduler();

    for (;;)
        ;
}
```

Output:

```
Starting TLS LCD Dispatcher Demo...
Starting LCD_1 (Targeting 0x3E)...
[I2C-0 at 0x3E] LCD Char: L
[I2C-0 at 0x3E] LCD Char: C
[I2C-0 at 0x3E] LCD Char: D
[I2C-0 at 0x3E] LCD Char: _
Starting LCD_2 (Targeting 0x3F)...
[I2C-1 at 0x3F] LCD Char: L
[I2C-1 at 0x3F] LCD Char: C
[I2C-1 at 0x3F] LCD Char: D
[I2C-1 at 0x3F] LCD Char: _
[I2C-1 at 0x3F] LCD Char: 2
[I2C-0 at 0x3E] LCD Char: 1
[I2C-1 at 0x3F] LCD Char: L
[I2C-1 at 0x3F] LCD Char: C
[I2C-1 at 0x3F] LCD Char: D
[I2C-1 at 0x3F] LCD Char: _
[I2C-1 at 0x3F] LCD Char: 2
[I2C-0 at 0x3E] LCD Char: L
[I2C-0 at 0x3E] LCD Char: C
[I2C-0 at 0x3E] LCD Char: D
[I2C-0 at 0x3E] LCD Char: _
[I2C-0 at 0x3E] LCD Char: 1
[I2C-1 at 0x3F] LCD Char: L
[I2C-1 at 0x3F] LCD Char: C
[I2C-1 at 0x3F] LCD Char: D
[I2C-1 at 0x3F] LCD Char: _
[I2C-1 at 0x3F] LCD Char: 2
[I2C-0 at 0x3E] LCD Char: L
[I2C-0 at 0x3E] LCD Char: C
[I2C-0 at 0x3E] LCD Char: D
[I2C-0 at 0x3E] LCD Char: _
[I2C-0 at 0x3E] LCD Char: 1
```

=== Step 23. Direct to task notifications

Direct to task notifications provide a lightweight and significantly faster way for tasks to send notifications
to each other without the need for an extra data structure like a queue or semaphore.

When enabled, each task has an array of `configTASK_NOTIFICATION_ARRAY_ENTRIES` 32-bit notification values that can be used to send notifications to the task. Each notification value can be used for different purposes, such as counting events, sending data, or signaling between tasks.

Limitations:
- Data can be sent from an ISR, but not to an ISR.
- Notification can only be processed by the task it was sent to (generally not a problem).
- Task's notification can only hold a single value at a time (no buffering).
- For counting events, a queue or semaphore is more appropriate.

Code sample below provides an implementation of a task dispatcher (#link("https://refactoring.guru/design-patterns/mediator", [Mediator pattern at refactoring.guru])) that uses direct to task notifications to coordinate between a sensor calibration task and a sensor data acquisition task. The dispatcher task receives notifications from both tasks and decides when to start calibration and when to acquire data.

This demonstrates an effortless event-driven architecture without the need for complex synchronization primitives, allowing for efficient loosely-coupled communication between tasks.

Code:

```c
// FreeRTOS
#include <FreeRTOS.h>
#include <stdint.h>
#include <task.h>

// C
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>

// Pico SDK
#include "pico/stdlib.h"

#define EVENT_START_CALIBRATION    (1 << 0)
#define EVENT_CALIBRATION_COMPLETE (1 << 1)

TaskHandle_t xDispatcherHandle  = NULL;
TaskHandle_t xCalibrationHandle = NULL;
TaskHandle_t xAcquireDataHandle = NULL;

void vSensorCalibrationTask(__attribute__((unused)) void *pvParameters) {
    const char *pcTaskName = pcTaskGetTaskName(NULL);

    for (;;) {
        /* Wait for dispatcher to signal start of calibration. */
        ulTaskNotifyTake(pdTRUE, portMAX_DELAY);

        printf("[%s] Starting calibration (2s)...\n", pcTaskName);
        vTaskDelay(pdMS_TO_TICKS(2000));
        printf("[%s] Calibration finished.\n", pcTaskName);

        /* Notify dispatcher that we are done. */
        xTaskNotify(xDispatcherHandle, EVENT_CALIBRATION_COMPLETE, eSetBits);
    }
}

void vSensorAcquireDataTask(__attribute__((unused)) void *pvParameters) {
    const char *pcTaskName = pcTaskGetTaskName(NULL);

    vTaskSuspend(NULL); /* Start suspended until calibration is done. */

    for (;;) {
        for (int i = 0; i < 5; i++) {
            printf("[%s] Acquiring sensor data...\n", pcTaskName);
            vTaskDelay(pdMS_TO_TICKS(1000));
        }

        /* Request calibration after acquiring data for a while. */
        xTaskNotify(xDispatcherHandle, EVENT_START_CALIBRATION, eSetBits);
    }
}

void vDispatcherTask(__attribute__((unused)) void *pvParameters) {
    uint32_t ulNotifiedValue = 0;
    const char *pcTaskName   = pcTaskGetTaskName(NULL);

    /* Initial trigger: start calibration. */
    xTaskNotify(xDispatcherHandle, EVENT_START_CALIBRATION, eSetBits);

    for (;;) {
        /* Wait for any bit to be set. */
        xTaskNotifyWait(
            (uint32_t)(0),          /* Clear no bits on entry. */
            (uint32_t)(UINT32_MAX), /* Clear all bits on exit. */
            &ulNotifiedValue,
            portMAX_DELAY
        );

        if (ulNotifiedValue & EVENT_START_CALIBRATION) {
            printf("[%s] EVENT: Start Calibration Received.\n", pcTaskName);

            /* Stop data acquisition when calibrating. */
            vTaskSuspend(xAcquireDataHandle);
            /* Trigger calibration task. */
            xTaskNotifyGive(xCalibrationHandle);
        }

        if (ulNotifiedValue & EVENT_CALIBRATION_COMPLETE) {
            printf("[%s] EVENT: Calibration Complete.\n", pcTaskName);

            /* Resume data acquisition. */
            vTaskResume(xAcquireDataHandle);
        }
    }
}

void vApplicationStackOverflowHook(TaskHandle_t xTask, char *pcTaskName) {
    panic("Stack overflow. Task: %s\n", pcTaskName);
}

void vApplicationMallocFailedHook() {
    panic("malloc failed");
}

int main() {
    stdio_init_all();
    sleep_ms(2000);
    printf("Task Dispatcher Demo\n");

    xTaskCreate(
        vSensorAcquireDataTask, "ACQUIRE", 512, NULL, 1, &xAcquireDataHandle
    );
    xTaskCreate(
        vSensorCalibrationTask, "CALIBRATE", 512, NULL, 1, &xCalibrationHandle
    );
    xTaskCreate(
        vDispatcherTask, "DISPATCHER", 512, NULL, 2, &xDispatcherHandle
    );

    vTaskStartScheduler();

    for (;;)
        ;
}
```

Output:

```
Task Dispatcher Demo
[DISPATCHER] EVENT: Start Calibration Received.
[CALIBRATE] Starting calibration (2s)...
[CALIBRATE] Calibration finished.
[DISPATCHER] EVENT: Calibration Complete.
[ACQUIRE] Acquiring sensor data...
[ACQUIRE] Acquiring sensor data...
[ACQUIRE] Acquiring sensor data...
[ACQUIRE] Acquiring sensor data...
[ACQUIRE] Acquiring sensor data...
[ACQUIRE] Acquiring sensor data...
[DISPATCHER] EVENT: Start Calibration Received.
[CALIBRATE] Starting calibration (2s)...
[CALIBRATE] Calibration finished.
[DISPATCHER] EVENT: Calibration Complete.
[ACQUIRE] Acquiring sensor data...
[ACQUIRE] Acquiring sensor data...
[ACQUIRE] Acquiring sensor data...
[ACQUIRE] Acquiring sensor data...
[ACQUIRE] Acquiring sensor data...
[DISPATCHER] EVENT: Start Calibration Received.
[CALIBRATE] Starting calibration (2s)...
[CALIBRATE] Calibration finished.
[DISPATCHER] EVENT: Calibration Complete.
[ACQUIRE] Acquiring sensor data...
[ACQUIRE] Acquiring sensor data...
[ACQUIRE] Acquiring sensor data...
[ACQUIRE] Acquiring sensor data...
[ACQUIRE] Acquiring sensor data...
[DISPATCHER] EVENT: Start Calibration Received.
[CALIBRATE] Starting calibration (2s)...
```

=== Step 24. Event groups

Unlike queues and semaphores, event groups allow tasks to wait for multiple events (bits) to be set in a single synchronization primitive. Tasks can specify whether they want to wait for all bits to be set or any bit to be set, and whether the bits should be cleared automatically when the task is unblocked.

Use-cases:
- Synchronizing multiple tasks that need to wait for a combination of events before proceeding.
- Broadcasting events to multiple tasks.

An event group is a set of boolean event flags.

Code below demonstrates an expansion of the previous task dispatcher example.
While direct to task notifications are essentially one-to-one, event groups allow for one-to-many communication, where multiple tasks can wait on the same event group and be unblocked when the relevant bits are set.

In the example below we have two calibration tasks and two acquisition tasks, and the dispatcher waits for all calibration tasks to complete before starting acquisition, and waits for all acquisition tasks to complete before starting the next round of calibration.

Code:

```c
// FreeRTOS
#include <FreeRTOS.h>
#include <event_groups.h>
#include <task.h>

// C
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>

// Pico SDK
#include "pico/stdlib.h"

#define BIT_CALIB_1_DONE (1 << 0)
#define BIT_CALIB_2_DONE (1 << 1)
#define BIT_ACQ_1_DONE   (1 << 2)
#define BIT_ACQ_2_DONE   (1 << 3)

#define ALL_CALIB_BITS (BIT_CALIB_1_DONE | BIT_CALIB_2_DONE)
#define ALL_ACQ_BITS   (BIT_ACQ_1_DONE | BIT_ACQ_2_DONE)

EventGroupHandle_t xSystemEvents;
TaskHandle_t xDispatcherHandle = NULL;
TaskHandle_t xCalib1Handle, xCalib2Handle;
TaskHandle_t xAcq1Handle, xAcq2Handle;

void vCalibrationTask(void *pvParameters) {
    uint32_t delay     = (uint32_t)pvParameters;
    uint32_t myBit     = (delay == 2000) ? BIT_CALIB_1_DONE : BIT_CALIB_2_DONE;
    const char *pcName = pcTaskGetTaskName(NULL);

    for (;;) {
        ulTaskNotifyTake(pdTRUE, portMAX_DELAY);
        printf("[%s] Calibrating for %dms...\n", pcName, delay);

        vTaskDelay(pdMS_TO_TICKS(delay));

        printf("[%s] Done.\n", pcName);
        xEventGroupSetBits(xSystemEvents, myBit);
    }
}

void vAcquisitionTask(void *pvParameters) {
    uint32_t delay     = (uint32_t)pvParameters;
    uint32_t myBit     = (delay == 1000) ? BIT_ACQ_1_DONE : BIT_ACQ_2_DONE;
    const char *pcName = pcTaskGetTaskName(NULL);

    for (;;) {
        vTaskSuspend(NULL); /* Start suspended. */

        printf("[%s] Acquiring data (%dms)...\n", pcName, delay);
        vTaskDelay(pdMS_TO_TICKS(delay));

        printf("[%s] Data point acquired.\n", pcName);
        xEventGroupSetBits(xSystemEvents, myBit);
    }
}

void vDispatcherTask(void *pvParameters) {
    const char *pcName = pcTaskGetTaskName(NULL);

    for (;;) {
        /* Start calibration phase. */
        printf("\n[%s] PHASE: CALIBRATION\n", pcName);
        xTaskNotifyGive(xCalib1Handle);
        xTaskNotifyGive(xCalib2Handle);

        /* Wait for all calibration to complete. */
        xEventGroupWaitBits(
            xSystemEvents, ALL_CALIB_BITS, pdTRUE, pdTRUE, portMAX_DELAY
        );
        printf("[%s] All calibrations complete.\n", pcName);

        /* Start acquisition phase. */
        printf("[%s] PHASE: ACQUISITION\n", pcName);
        vTaskResume(xAcq1Handle);
        vTaskResume(xAcq2Handle);

        /* Wait for all data to be acquired. */
        xEventGroupWaitBits(
            xSystemEvents, ALL_ACQ_BITS, pdTRUE, pdTRUE, portMAX_DELAY
        );
        printf("[%s] All data acquired successfully.\n", pcName);

        vTaskDelay(pdMS_TO_TICKS(1000));
    }
}

void vApplicationStackOverflowHook(TaskHandle_t xTask, char *pcTaskName) {
    panic("Stack overflow. Task: %s\n", pcTaskName);
}

void vApplicationMallocFailedHook() {
    panic("malloc failed");
}

int main() {
    stdio_init_all();
    sleep_ms(2000);

    xSystemEvents = xEventGroupCreate();

    xTaskCreate(
        vCalibrationTask, "CAL_1", 512, (void *)2000, 1, &xCalib1Handle
    );
    xTaskCreate(
        vCalibrationTask, "CAL_2", 512, (void *)3000, 1, &xCalib2Handle
    );

    xTaskCreate(vAcquisitionTask, "ACQ_1", 512, (void *)1000, 1, &xAcq1Handle);
    xTaskCreate(vAcquisitionTask, "ACQ_2", 512, (void *)1500, 1, &xAcq2Handle);

    xTaskCreate(vDispatcherTask, "DISPATCH", 512, NULL, 2, &xDispatcherHandle);

    vTaskStartScheduler();

    for (;;)
        ;
}
```

Output:

```
[DISPATCH] PHASE: CALIBRATION
[CAL_1] Calibrating for 2000ms...
[CAL_2] Calibrating for 3000ms...
[CAL_1] Done.
[CAL_2] Done.
[DISPATCH] All calibrations complete.
[DISPATCH] PHASE: ACQUISITION
[ACQ_1] Acquiring data (1000ms)...
[ACQ_2] Acquiring data (1500ms)...
[ACQ_1] Data point acquired.
[ACQ_2] Data point acquired.
[DISPATCH] All data acquired successfully.

[DISPATCH] PHASE: CALIBRATION
[CAL_1] Calibrating for 2000ms...
[CAL_2] Calibrating for 3000ms...
[CAL_1] Done.
[CAL_2] Done.
[DISPATCH] All calibrations complete.
[DISPATCH] PHASE: ACQUISITION
[ACQ_1] Acquiring data (1000ms)...
[ACQ_2] Acquiring data (1500ms)...
[ACQ_1] Data point acquired.
[ACQ_2] Data point acquired.
[DISPATCH] All data acquired successfully.
```
