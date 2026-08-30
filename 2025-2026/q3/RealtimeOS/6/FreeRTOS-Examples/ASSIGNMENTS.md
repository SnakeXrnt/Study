---
geometry: margin=2cm
colorlinks: true
linkcolor: blue
urlcolor: blue
---

# RTOS Logbook Assignments

Document all your work in a logbook, including code snippets, screenshots, and explanations of your thought process. This will help you understand the concepts better and provide a reference for future projects. You are free in how you document your work, but make sure you can bring it to the assessment to receive points for it!

All documentation needed can be found on the [freeRTOS Website](https://www.freertos.org/Documentation/00-Overview).

## Setup and Tasks:

1. Clone this [repository](https://github.com/felixhartlieb/FreeRTOS-Examples) and set up the development environment as per the instructions in the README. If you work with a different microcontroller, follow online ressources to set up a FreeRTOS project for your specific hardware.

2. Compile and run the sample "App1-Helloworld" FreeRTOS project. Start a second instance of the hello task, so that you have two tasks running at the same time. Observe the behavior on the serial monitor and describe what you see.

3. Answer the following questions (research if needed):
   1. Where is task context stored?
   2. What happens during a context switch?
   3. Why must task functions never return?

## Task Creation and Management:

### Creation:

4. For the following exercises use "App2-blink" example project as a starting point. Go through the code and understand it. Then build up your microcontroller board with two LEDs (protected with a resistor) and connect them to the appropriate GPIO pins. Compile and run the project to see the LEDs blinking.

5. Modify the project to print a message every time an LED is toggled. The message must contain the name of the task that toggled the LED. Instead of hardcoding the delay time for the LED toggling, pass it as a parameter to the task function. Reduce the code duplication by creating a single task function that can handle both LEDs with different parameters. There must be two tasks running at the same time, each controlling a different LED with a different delay time!

6. Answer the following questions:
   1. What happens exactly if your stack size is too small for a task?
   2. Which states can a task be in in FreeRTOS? How can a task transition between these states?
   3. What is different if you create tasks with `xTaskCreateStatic()` instead of `xTaskCreate()`?
   4. What is the idle task?
   5. What is the difference between xTaskDelay() and vTaskDelayUntil()? Which one is more appropriate for periodic tasks and why?

### Destruction/Suspension:

7. Continue with the "App1-Helloworld" example project. Make sure to print meaningful debug statements. Make another task that deletes one of the hello tasks after 20 seconds.

8. Create a third task that prints a message after 10 seconds and then kills itself.

9. Create another task that suspends one of the other tasks for 5 seconds and then resumes it, print a message before and after the suspension to observe the behavior.

10. Answer the following questions:
    1.  What is a task handle? What data type is it and what does it mean?
    2.  What happens if a task function returns?

## Inter-task Communication (queues):

11. Create three tasks that communicate with each other using queues. Two tasks should send a message to the third task every second, and the receiving task should print the messages to the serial monitor. Use exactly one queue. You can use the "App3-Queue" example project as a starting point.

12. Answer the following questions:
    1.  Why should we use queues for inter-task communication instead of global variables?
    2.  What happens if you try to send to a full queue or receive from an empty queue?
    3.  What does timeout mean in the context of queues?
    4.  How could you implement the same behavior with counting semaphores instead of queues? (explanation is enough, no need to implement it)
    5.  Why are semaphores often used for synchronization between tasks and ISRs?

## Interrupt Handling:

13. In microcontrollers we learned that Interrupt Service Routines (ISRs) should be as short as possible. Modify "App3-Queue" to use a button interrupt to enable print "The button was pressed!" on the serial monitor every time the button is pressed. Make sure to do this in a way that the ISR is not doing any heavy work and is just signaling a task to do the actual printing. You can use one of the following methods to signal the task from the ISR:
    1.  Use a binary semaphore to signal the task from the ISR.
    2.  Suspend and wake the task from the ISR.
    3.  Use a direct to task notification to signal the task from the ISR. 

## Mutual Exclusion:

14. Fix the "App1-Helloworld" from the beginning of the assignment to use a mutex to protect the shared resource (the serial console) instead of just printing directly from the tasks. Explain why this is necessary!
   
15. Run the "App4-Philosophers" example. Fix the deadlock with the 3 versions we have discussed in class:
    1.  Assymetric solution: One philosopher picks up the left fork first, while the other two pick up the right fork first.
    2.  Room limit solution: Limit the number of philosophers using a counting semaphore.
    3.  Backoff solution: If a philosopher cannot pick up both forks in a defined time, they put down the one they have and try again after a random delay.

16. Answer the following questions:
    1.  What is a semaphore and how does it differ from a mutex?
    2.  In what situations is a mutex more appropriate than a semaphore?

## Scheduling:

17. Find out what the maximum and minimum task priorities are in FreeRTOS. Create three tasks with different priorities (2 at the same lower and one at max priority) that print messages at different intervals. Observe the behavior and explain how the scheduler is working in this case. Show an example where the higher priority task starves the lower priority tasks and explain how to fix it.

18. Take the project "App5-Inversion" and explain the problem of priority inversion. Fix the problem by using a mutex (that supports priority inheritance) instead of a binary semaphore. Why does this work, explain in your own words.

19. Answer the following questions:
    1.  What is the difference between preemptive and cooperative scheduling?
    2.  What scheduling algorithm does FreeRTOS use? What are the advantages and disadvantages of this algorithm?

## Timers

20. Create a software timer that prints every 2 seconds. You can add this to one of your existing projects or create a new one.

21. Answer the following questions:
    1.  What is the difference between a software timer and a hardware timer?
    2.  How do software timers work in FreeRTOS? Where are they executed?
    3.  What is a timer callback function and when called?
    4.  What happens if a timer callback function takes too long to execute?

## Extras (for higher grade)

22. Investigate the following freeRTOS features and implement a sample project for each. Explain the use case for each feature and how it can be used in real-world applications in detail:
    1.  Thread local storage
    2.  Direct to task notifications
    3.  Event groups
