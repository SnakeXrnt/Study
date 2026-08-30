# Advanced Programming Concepts, assignment 4

## Concurrent logger decorator (?? points)

This is a mysterious extra-effort task. Or at least the points you can get for it are mysterious;).

You asked, we giveth. Some of you have been inquiring about whether we'll be doing concurrency. So here we go. A little bit of concurrency to spice things up. And to learn a common *concurrent programming pattern*, a *multiple producer, single consumer queue*.

Perhaps you haven't noticed, but the `logger` implementation is totally not thread-safe. If multiple threads call its `log` function simultaneously, the output will be messy. You can check it with:

```cpp
#include <thread>
#include <vector>
#include <string>
// other includes...

auto cw = std::make_unique<io::writers::console_writer>();
auto log = std::make_unique<logging::logger>( std::move(cw) );
auto decorated = std::make_unique<extensions::runtime_decorator>( std::move(log) );
    
// create 10 threads that each logs 5 messages.
std::vector<std::thread> threads;
for (int i = 0; i < 10; ++i) {
    threads.emplace_back(
        
        [i, &decorated]() {
            for (int j = 0; j < 5; ++j) 
            {
                decorated->log("Hello from thread " + std::to_string(i) + ", this is message number: " + std::to_string(j));
            }
    });
}

for (auto& t : threads) {
    t.join();
}
```

In the code above, 10 threads are created and launched, each logging 5 messages with the shared `decorated` logger. You should probably check it out yourself to see the mangled output.

Your task is to implement a `concurrent_decorator` class in the `extensions` namespace that makes any `ilogger` implementation thread-safe by decorating it. The `concurrent_decorator` should use a *multiple-producer, single-consumer queue* to achieve this.


### Some basic terminology:

* **Concurrency**: The ability of a program to execute multiple tasks simultaneously or in overlapping time periods. In C++, concurrency is often achieved using threads.

* **Thread**: A thread is a separate path of execution within a program. Multiple threads can run concurrently, allowing for parallelism and (hopefully) improved performance.

* **Multiple-Producer, Single-Consumer Queue**: A concurred programming pattern where multiple threads (producers) generate data and put it into a shared queue, while a single thread (consumer) retrieves and processes that data from the queue. This guarantees that data produced by multiple threads is handled sequentially by a single thread, preventing data corruption and ensuring thread safety.

* **Producer**: A thread that produces data (in this case, log messages) and puts it in the queue.

* **Consumer**: A thread that consumes data (in this case, log messages) from the queue.

* **Mutex**: A mutual exclusion object that protects shared data (the queue in our case) from being accessed simultaneously by multiple threads. A mutex can be locked (acquired) and unlocked (released). Only one thread can hold the lock at a time. C++ mutexes, implemented in `std::mutex`, provide `lock` and `unlock` functions for this purpose, but we won't use them directly. Instead we will use:

* **Lock Guard**: A C++ RAII-style mechanism to manage mutex locking and unlocking automatically. Usually, we don't call `lock` and `unlock` directly on a mutex. Instead, we use `std::lock_guard` or `std::unique_lock` to ensure that the mutex is properly released when the lock guard goes out of scope, even if an exception occurs. When created, a lock guard directly acquires the lock on the mutex, and when destroyed, it releases the lock.
  
* **Condition Variable**: A synchronization primitive that allows threads to wait for certain conditions to be met (a message being available in the queue). One thread can wait on a condition variable, while another thread can notify it when the condition is met. It is as simple as two function calls: `wait` for waiting for a condition to occur, and `notify_one` or `notify_all` for notifying waiting threads that the condition has occurred.

* **Worker Thread**: A dedicated thread that runs in the background, and performs tasks. In our case, the worker thread dequeues messages from the queue and forwards them to the wrapped logger.

* **Atomic Variable**: A variable that can be safely accessed and modified by multiple threads without the need for additional synchronization mechanisms like mutexes. In C++, atomic variables are provided by the `std::atomic` template class.

### A bit of explanation

Firstly, the `concurrent_decorator` will be just another decorator, inheriting from `extensions::decorator`. However, instead of directly forwarding the `log` calls to the wrapped logger, it will put them in a queue in a thread-safe manner. That's because potentially multiple threads (producers) will be calling `log` simultaneously. You've already seen what happens then. Calls to `log` are interrupted in the middle by other threads, producing a messy output.

So putting the messages in a queue takes care of the message integrity on the producer side. (Naturally, enqueueing a message must be really thread-safe. You will use a `std::mutex` to protect the queue during enqueue operations for this.)

On the consumer side, a single dedicated thread (a so-called *worker thread*) will be running in the background, waiting for messages to appear in the queue. When a message is available, it will dequeue it and forward it to the wrapped logger. Since only one thread (the *worker thread*) is allowed to call the wrapped logger's `log` method, there will be no mangled output.

Again, dequeuing a message must be thread-safe, so the *worker thread* will also use the same `std::mutex` to protect the queue when working with it.

To let the producers communicate with the consumer, you will use a `std::condition_variable`. A condition variable allows a thread to wait until it is notified that something interesting has happened. So the worker thread will wait on the condition to occur (a message has been enqueued), and the producer threads will notify it when the condition happens (when they enqueue a new message). All of this signaling is done with the help of the same `std::mutex` that protects the queue.


### Concurrency for uninitiated

Let's start with the basics. Imagine a simple scenario where one thread (the *producer*) creates a string message, and the other thread (the *consumer*) waits for the message to be available and then prints it to the console. The program skeleton looks like this:

```cpp
#include <iostream>
#include <thread>

void producer()
{
}

void consumer()
{
}

int main()
{
  std::thread prod{ producer };
  std::thread cons{ consumer };

  prod.join();
  cons.join();
}
```

Nothing important is happening just yet. We have two empty functions that are executed in two separate threads. As you can see, launching a thread is as simple as creating it with a function name (or a callable object) as its entry point. Once launched, a thread runs concurrently with the main thread (and other threads). The `join` function at the end of `main` is used to wait for a thread to finish its execution before proceeding.

Let's first work on the producer function. It will create a message and let the consumer know that it's available:

```cpp
#include <thread>
#include <string>
#include <chrono>
#include <mutex>
#include <atomic>

std::mutex mtx{};
std::atomic<bool> available{ false };

// shared message between producer and consumer
std::string message{};

using namespace std::chrono_literals;

void producer()
{
    // Wait for 100 ms
    std::this_thread::sleep_for(100ms);

    mtx.lock();
    message = "Hello from producer!";
    mtx.unlock();

    available = true;
}
```

Lots of things happening here. First, we are using a `std::mutex` to protect access to the shared `message` variable. Remember that only one thread can hold a lock on a mutex at a time. So when the producer locks it, no other thread can acquire the lock until the producer releases (unlocks) it. Once the message is created, the producer unlocks the mutex, allowing other threads to acquire the lock and access the shared message.

We are also using an *atomic* boolean variable to signal to the consumer that the message is ready. Atomic variables can be safely accessed and modified by multiple threads without the need for explicit synchronization with mutexes. You might ask why we didn't use an atomic string for the message. The reason is rather simple -- atomics are a hardware feature and they are only available for fundamental integral types.

Once the producer function ends, the corresponding thread will finish its execution.


Let's do the consumer side now:

```cpp
void consumer()
{
    // wait until the message is available
    while ( !available ) {
        // sleeping for some time
        std::this_thread::sleep_for(10ms);
    }

    mtx.lock();
    std::cout << message << std::endl;
    mtx.unlock();
}
```

This one is simple enough. We wait in an infinite loop until the `available` flag is set to true by the producer. Once the message is available, we lock the mutex, print the message to the console, and unlock.

Again, we are free to access the `available` variable without locking because it is atomic. However, we must lock the mutex before accessing the shared `message` variable to ensure thread safety. (And unlock it afterwards.)

#### Improving the program

We will now improve the program by:

* Getting rid of explicit calls to `lock` and `unlock` on the mutex. 

* Using a `std::condition_variable` for signaling between the producer and consumer instead of the atomic boolean flag and *busy-waiting*.

Generally speaking, unless necessary, you should avoid calling `lock` and `unlock` directly on a mutex. Instead, use *lock guards* in the form of `std::lock_guard` or `std::unique_lock`. These are classes that automatically lock a mutex when created and unlock it when they go out of scope. So instead of writing:

```cpp
mtx.lock();
// critical section
mtx.unlock();
```

You can do:

```cpp
{
    // creating a lock_guard automatically locks the mutex
    std::lock_guard<std::mutex> lock{ mtx };
    // critical section
} // lock is automatically released here when going out of scope
```

This sounds pretty simple, and you should already know how it can be implemented under the hood with RAII. 

Most often you will use `std::lock_guard`, unless you need fine-grained control. In that case you should turn to `std::unique_lock`.

The second improvement is getting rid of the atomic flag signaling and this ugly loop:

```cpp
while ( !available ) {
    // sleeping for some time
    std::this_thread::sleep_for(10ms);
}
```

It is ugly because we unnecessarily wake up the consumer thread every 10 ms to check the flag. Such a piece of ugliness is called *busy-waiting* and is very much frowned upon. Instead of it, we will use a `std::condition_variable` to let the consumer wait until notified by the producer that the message is available.

The consumer waits for a notification that something has happened (the message is available), and the producer notifies the consumer when it has produced the message. This is expressed with simple:

```cpp
std::condition_variable cv{};

// consumer side
cv.wait(lock, predicate); // consumer waits here

// producer side
cv.notify_one();          // producer notifies here
```

The producer implementation that uses a condition variable is straightforward. Instead of setting a boolean flag, it calls `cv.notify_one()`.

```cpp
#include <condition_variable>

std::condition_variable cv{};

void producer()
{
    // Wait for 100 ms
    std::this_thread::sleep_for(100ms);
    
    std::lock_guard<std::mutex> lock{ mtx };
    message = "Hello from producer!";
    
    // notify the consumer that the message is available
    cv.notify_one();
}
```

It is not strictly necessary to have the mutex locked when calling `notify_one`, and often you will see programs that don't do it:

```cpp
void producer()
{
    // Wait for 100 ms
    std::this_thread::sleep_for(100ms);
    
    // create a local scope so that the lock_guard releases the lock when going out of scope
    {
        std::lock_guard<std::mutex> lock{ mtx };
        message = "Hello from producer!";
    }

    // notify the consumer, the mtx is already unlocked here
    cv.notify_one();
}
```

On the consumer side of things, the code will be a wee more complex. Here, the condition variable works together with a mutex (or rather with a lock guard that manages the mutex). Let's spell it out first and then explain:

```cpp
void consumer()
{
    std::unique_lock<std::mutex> lock{ mtx };
    // wait until notified by the producer and the message is available
    cv.wait(lock, []{ return !message.empty(); });
    std::cout << message << std::endl;
}
```

First, we use a `std::unique_lock` instead of a `std::lock_guard`. The reason is simple: the condition variable requires it. 
Now, you might be surprised why we lock the mutex when we are not accessing the shared `message` yet. Two understand it, you need to know what the condition variable does under the hood. We call `cv.wait(lock, predicate)` and then:

1. The condition variable checks the predicate. If it returns `true`, the wait function returns immediately, and the mutex remains locked.

    * This is good - the lock is still held and we go to the next line where we can safely access the shared message and print it.
  
2. If the predicate returns `false` (there is no message yet), the condition variable *unlocks* the mutex and puts the thread to sleep until notified by the producer with `cv.notify_one()`.

    * This is also good - the mutex is unlocked, allowing the producer to acquire the lock and set the message.

3. Once the producer notifies with `cv.notify_one()`, the condition variable wakes up the consumer thread, *re-locks* the mutex, and checks the predicate again.

    * If the predicate now returns `true` (the message is available), the wait function returns, and we can safely access the shared message.

    * If the predicate still returns `false` (might happen for weird concurrent reasons), the wait function goes back to step 2.

So whatever happens, we are happy. The consumer thread sleeps until notified by the producer. The mutex is properly locked and unlocked as needed, and we can safely access the shared message.

As a final touch. We might do something like this:

```cpp
void consumer()
{
    std::unique_lock<std::mutex> lock{ mtx };
    // wait until notified by the producer and the message is available
    cv.wait(lock, []{ return !message.empty(); });
    
    // while lock is held, move the message to a local variable
    std::string local_message = std::move(message);

    // unlock the mutex as we are done with the shared message
    lock.unlock();
    std::cout << local_message << std::endl;
    lock.lock(); // re-lock if needed later
}
```

This is a total overkill here, but in scenarios where multiple producers are fighting for a shared resource (here the shared message), it might be a good idea to hold the lock for as little time as possible. This way we don't block other threads for too long.

### Example program

To understand the basics of locking with `std::mutex` and signaling with `std::condition_variable`, with multiple producers and a message queue, take a look (and run) the following program. Also read the comments;)

```cpp
#include <iostream>
#include <thread>
#include <mutex>
#include <condition_variable>
#include <chrono>
#include <queue>

// mutex that protects access to the shared queue
std::mutex mtx{};

// condition variable for signaling between producers and consumer
std::condition_variable cv{};

// SHARED queue between producers and consumer - it cannot be modified simultaneously by multiple threads
std::queue<int> data_queue{};

// Producer thread function - enqueues 10 integers with some delay 
// and notifies the consumer each time a new integer is added with the condition variable.
void producer() {
    for (int i = 0; i < 10; ++i) {
        // Sleep for a while to simulate work
        std::this_thread::sleep_for(std::chrono::milliseconds(100));
        
        // We must lock the mutex before accessing the shared queue
        // Using lock_guard is the C++ way to ensure the mutex is properly released (unlocked)
        // when the lock_guard goes out of scope
        // Try not to call lock/unlock directly on the mutex (at least not yet)
        std::lock_guard<std::mutex> lock{ mtx };

        // Lock has been acquired, no other thread can acquire the lock until this scope ends
        // So it is safe to access the shared queue
        data_queue.push(i);

        // Notify the consumer that new data is available
        cv.notify_one();
    }
}

void consumer() 
{
    while (true) 
    {
        // Lock the mutex - it is needed for the condition variable to be able to wait for a signal
        // condition_variable::wait works only with unique_lock!
        // (unique_lock is just a more powerful version of lock_guard)
        std::unique_lock<std::mutex> lock{ mtx };

        // a bit weird, but cv will now unlock the mutex and then put this thread to sleep until
        // notified by the producer (with notify_one) AND the queue is not empty
        // unlocking the mutex is necessary to allow the producer to acquire the lock and enqueue new data
        cv.wait(lock, []{ return !data_queue.empty(); });
        // at this point, the notification has been received and the queue is not empty
        // cv WILL RE-LOCK the mutex before returning from wait, so it is safe to perform queue operations

        // we can safely manipulate the shared queue here. Lock on the mtx has just been re-acquired by the cv
        // in case there are multiple items in the queue, we will consume them all in a loop
        while (! data_queue.empty()) 
        {
            int data = data_queue.front();
            data_queue.pop();

            // Not strictly necessary here, but we can unlock the mutex earlier to allow 
            // the producer(s) to enqueue new data in the meantime.
            // Notice that we are just done with the shared queue at this point.
            // Yeah, I know we said never use lock/unlock directly on the mutex, but this is a valid use-case.
            // (and it's optional, certainly not required for the assignment)
            lock.unlock();

            std::cout << "Consumed: " << data << std::endl;

            // Re-lock the mutex for the next iteration (not necessary if we haven't unlocked it earlier)
            lock.lock();
        }
    }
}

int main() 
{
    // Ok, still one producer, but just spawn more if you want
    std::thread prod{ producer };
    std::thread cons{ consumer };

    // join waits for the threads to finish
    // formally, join "joins" the thread with the calling thread (main thread in this case)
    prod.join();
    cons.join();
}
```

### Concurrent decorator implementation (spare) details

The `concurrent_decorator` class will inherit from `extensions::decorator`. Its `log` function will enqueue the received message into a shared queue, protected by a `std::mutex`. After enqueueing the message, it will notify the worker thread using a `std::condition_variable`. Basically, it will do exactly the same as the `producer` function in the example above (except it will enqueue strings instead of integers, and it won't have a loop or sleep).

Your class will also need a private `process` function that will implement the consumer logic. Again, this is mostly the same as the `consumer` function in the example above.

> You have to refactor `logging::ilogger::log` and make it non-`const` in order to implement the `concurrent_decorator`. This is because the `log` function will need to modify the internal state of the `concurrent_decorator` (the shared queue), and thus cannot be `const`.

There are also some other caveats:

#### Member variables

You will need a couple of private members in your `concurrent_decorator` class (**in this order**):

* A boolean flag (e.g., `m_done` or `m_should_stop`) to let the *worker thread* know that the `concurrent_decorator` is being destroyed, so it should exit its loop and finish.
* A `std::mutex` to protect access to the shared queue.
* A `std::condition_variable` for signaling between producer threads and the worker thread.
* A `std::queue<std::string>` to hold the log messages.
* A `std::thread` for the worker thread.

The `bool` flag ** must be** of type `std::atomic<bool>` to ensure proper synchronization between threads when checking or setting its value. This flag plays a crucial role in making sure that the worker thread running the `process` knows when to stop processing messages and exit gracefully. `m_done` will be set by the destructor of the `concurrent_decorator` to signal the worker thread to finish its work and exit. (naturally, the *worker thread* will check this flag in its processing loop to determine when to stop AND also check it as part of the condition variable `wait` predicate, as explained below).

#### Starting the worker thread in the constructor

The constructor of `concurrent_decorator` will initialize its members and start the worker thread by simply creating a `std::thread` object with the `process` function as its entry point:

```cpp
// part of the constructor initializer list
m_worker_thread(&concurrent_decorator::process, this)
```

The creation of the thread must be the last thing done in the constructor initializer list, to ensure that all other members are properly initialized before the worker thread starts executing. That's why the order of the member variables is important.

#### The process function

The `process` function will run in a loop until the `m_done` flag is set to true. You can achieve this by checking the flag in the loop condition (it is atomic, so it is always safe to do). Inside the loop, it is important to change the condition variable `wait` predicate. In the example above the predicate checked only whether `!data_queue.empty()`. This predicate guaranteed that the worker thread didn't wake up unnecessarily when there was no data to process. However, in your case, you will also need to make sure that the worker thread can wake up when the queue is empty but the `concurrent_decorator` is being destroyed (its destructor has been called). Imagine a situation where the `concurrent_decorator` is already destroyed but the *worker thread* is still waiting in the background on the condition variable. That would be a disaster, but it could happen if the predicate only checked for `!data_queue.empty()`. Consequently, you also must check the `m_done` flag as part of your `wait` predicate. This way, when the destructor sets the `m_done` flag and notifies the condition variable, the worker thread will wake up, see that `m_done` is true, perhaps still process some messages and, finally, exit its loop gracefully.

#### Stopping the worker thread in the destructor and cleaning up

Finally, don't forget to properly stop the worker thread in the destructor of the `concurrent_decorator`. This is done by:

* first setting the boolean `m_done` flag,

* then notifying the worker thread using the condition variable to wake it up if it's waiting,
 
* finally, by joining the worker thread to ensure it has finished executing before the destructor completes.

## Wrapping up

If you manage to implement the `concurrent_decorator` correctly, you will impress us greatly. It is a challenging task and requires some extra research. What's more, there are a few extra things to consider:

* What about the messages that get enqueued but not yet processed when the `concurrent_decorator` is being destroyed? Yes, it is possible that just when you are finishing with the `process` loop a new message arrives. Make sure that all messages are processed before the destructor completes.

* Should the producers be allowed to enqueue new messages after the `concurrent_decorator` destructor has started? Probably not. Can you prevent that from happening? How will you do it? (There are two options to consider: either prevent new messages from being enqueued after destruction starts, or allow it but log them immediately, skipping the queue.)

Do not forget to test your implementation thoroughly. You can use the example program from the beginning of this document and modify it by decorating the already decorated logger once more with your `concurrent_decorator`.

