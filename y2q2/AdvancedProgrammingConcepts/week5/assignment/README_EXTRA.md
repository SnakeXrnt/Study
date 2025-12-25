# Advanced Programming Concepts, assignment 5

## Default logger factory (4 + 2 + 2 points)

Concurrency is a fascinating topic. And so is [*lazy initialization*](https://stackoverflow.com/questions/978759/what-is-lazy-initialization-and-why-is-it-useful) of shared resources in multi-threaded environments. Take a look at the following class:

```cpp
class logger_factory_unsafe {
public:

    /// Get the singleton instance of the logger factory
    static logger_factory_unsafe& get() {
        static logger_factory_unsafe factory;
        return factory;
    }

    /// Get the default logger from the factory
    logging::ilogger& default_logger()
    {
        if (!m_logger)
        {
            // Logger is lazily created on first use
            m_logger = builders::default_builder()
                .with_console_output()
                .get();

            // if you have implemented concurrent_decorator in the previous assignment, you can add it here as well
            // m_logger = std::make_unique<extensions::concurrent_decorator>(std::move(m_logger));
        }
        return *m_logger;
    }
private:
    std::unique_ptr<logging::ilogger> m_logger;
};
```

It seems simple enough. A singleton factory class that can provide a default logger instance. The logger is created on first use. It's safely kept in a `std::unique_ptr` and returned by reference as needed. What can go wrong? As always, it's enough to have multiple threads trying to access the `default_logger()` at the same time and all hell breaks loose:

```cpp
#include <thread>
#include <vector>
#include "extra/logger_factory_unsafe.hpp"

int main()
{
    std::vector<std::thread> threads;
    for (auto i = 0; i < 10; ++i)
    {
        threads.emplace_back([](){
            auto& logger = extra::logger_factory_unsafe::get().default_logger();
            logger.log("Logging from thread unsafe factory");
        });
    }

    for (auto& thread : threads)
    {
        thread.join();
    }
} 
```

This innocent-looking program will likely crash, surely if compiled with the *address sanitizer* enabled. The reason for it is a [*race condition*](https://en.wikipedia.org/wiki/Race_condition) on the `m_logger` member variable. (In C++ lingo also known as a *data race*). Multiple threads can enter the `if (!m_logger)` check at the same time, all see that the logger is not yet created, and all try to create it. What's worse, this can happen:

```
        Thread A                    Thread B
            |                           |
1.   if (!m_logger)                     |
            |---------------------------|
            |                           |
2.          |                    if (!m_logger)
            |                           |
            |                     m_logger = ...
            |                           |
            |                   return *m_logger;
            |                           |
3.          |                     auto& logger =
            |---------------------------|
            |                           |
4.       m_logger = ...                 |
            |---------------------------|
            |                           |
5.          |                    logger.log(...)
            |                           X
```

In this scenario, thread A checks the `m_logger` variable (step 1) and sees it's not yet initialized. However, before it can create the logger thread B jumps in (step 2), checks the same variable, and creates the logger. Thread B then obtains a reference to the logger with the intention to use it for logging (step 3). However, before it can do so, thread A gets its turn again (step 4) and creates a new logger instance, overwriting the pointer in `m_logger`. Now when thread B tries to use its reference to the logger (step 5), it ends up accessing an object that just has been deleted (replaced by Thread A in step 4), leading to undefined behavior and likely a crash.

Your first task(s) is to create a new, safe version of the *logger factory* that avoids this race condition. 
You will do it in two different ways, however the idea is the same. Only one thread should be ever allowed to execute the line of code that starts with ` m_logger = builders::default_builder()...`. Other threads trying to access the `default_logger()` method while the logger is being created should wait until the logger is fully created.

### logger_factory_safe (2 points)

The first approach will use `std::call_once` and `std::once_flag` from the `<mutex>` header. The changes that you will need to make are miniscule, but you will have to research how `std::call_once` works and how to use it.

Thus, implement a new class `logger_factory_safe` in a header file `logger_factory_safe.hpp` that uses `std::call_once` and `std::once_flag` to ensure that the logger can be created only once, even when multiple threads try to call `default_logger()` simultaneously. 

/* Yes, you will have to find information about how `std::call_once` works and how to use it on your own. These 2 points are not coming for free;) */

The best source of information about `std::call_once` is possibly section 3.3 *Alternative facilities for protecting shared data* in the book *C++ Concurrency in Action* by Anthony Williams. If you don't have access to that book, you can also check [cppreference](https://en.cppreference.com/w/cpp/thread/call_once). Or perhaps Anthony's [old blog post about it](http://www.justsoftwaresolutions.co.uk/threading/multithreading-in-c++0x-part-6-double-checked-locking.html). Just be aware, it's not *https* :)

### logger_factory_safer (2 points)

Hopefully, the previous task wasn't that hard. Now, we'll be stepping up the game a bit. Another way of protecting shared data during initialization are mutexes and locks. The idea is rather similar, only one thread should be allowed to execute the code that creates the logger instance. And it's done like this:

```cpp
class logger_factory_safer {
public:

    logging::ilogger& default_logger()
    {
        std::lock_guard<std::mutex> lock(m_mutex);
        if (!m_logger)
        {
            m_logger = builders::default_builder()
                .with_console_output()
                .get();
        }
        return *m_logger;
    }

private:
    std::unique_ptr<logging::ilogger> m_logger;
    std::mutex m_mutex;
};
```

There is a single `std::mutex` that's always locked when entering the `default_logger()` function. Nothing really can go wrong with this implementation, because only a single thread can be inside `default_logger()` at any given time. However, this implementation has a performance drawback -- even when the logger is already created, every thread trying to access it will have to wait for the mutex to be locked. This is unnecessary, and a rather big overhead. To avoid this, good folks of the Java tribe came up with a pattern called [*double-checked locking*](https://en.wikipedia.org/wiki/Double-checked_locking). The idea is to first check if the resource is already created without locking the mutex. Only if it's not yet created, we lock the mutex and check again. If it's still not there (another thread might have created it in the meantime), we finally instantiate it. Checking without locking is very cheap, so we don't have to worry about the extra runtime overhead. Like this:

```cpp
class logger_factory_safer {
public:
    logging::ilogger& default_logger()
    {
        // First check without locking
        if (m_logger) {
            return *m_logger;
        }

        // If we are here, the first check failed, so we lock the mutex
        std::lock_guard<std::mutex> lock(m_mutex);

        // And check again! In case another thread created the logger in the meantime
        if (!m_logger)
        {
            m_logger = builders::default_builder()
                .with_console_output()
                .get();
        }
        return *m_logger;
    }
private:
    std::unique_ptr<logging::ilogger> m_logger;
    std::mutex m_mutex;
};
```

However, C++ is not Java, and this implementation comes with a built-in *race condition*. When one thread is reading the `m_logger` variable in the first `if (m_logger)` check, another thread might be writing to it in the `m_logger = builders::default_builder()...` line. Under the C++ memory model, despite the lack of apparent consequences, this is still *undefined behavior*. (No apparent consequences because this particular check won't really lead to any serious issues, even if the read happens during a write.) And *undefined behavior* means one thing, a possible crash. Consequently, the *double-checked locking* cannot be implemented like this in C++. What we need instead is an `std::atomic` data member (e.g., `m_initialized`) that will indicate whether the logger has been initialized or not. The atomic variable can be safely read and written to by multiple threads without synchronization issues, so any potential *race conditions* are avoided.

**Your task** is to implement the `logger_factory_safer` class in a header file `logger_factory_safer.hpp` using the *double-checked locking* pattern with a `std::atomic<bool>` member variable to indicate whether the logger has been initialized. Make sure that your implementation is thread-safe and avoids unnecessary locking once the logger is created.

### logger_factory_safest (2 + 2 points)

This is black magic territory. If you have made it this far, congratulations! We will now actively break your *double-checked locking* implementation. By adding a new function to the `logger_factory_safer` class:

```cpp
void set_default_logger(std::unique_ptr<logging::ilogger> logger)
{
    std::lock_guard<std::mutex> lock(m_mutex);
    m_logger = std::move(logger);
    m_initialized = true; // you should have it already
}
```

With this tiny addition we are back to square one. The `default_logger()` function is no longer thread-safe. Or actually not safe whatsoever. Can you see why?

<spoilers>

The `default_logger()` function returns a reference to a logger instance that's held in the `m_logger` member variable. However, if one thread obtains a reference to the logger via `default_logger()`, and then another thread calls `set_default_logger()` to replace the logger `m_logger` object, the first thread will be left with a dangling reference. This is because the original logger instance doesn't exist anymore. This, once again leads to *undefined behavior* when the first thread tries to use its reference. Or simply a crash.

This can be demonstrated with the following sequence of events:

```cpp
std::vector<std::thread> threads;
for (auto i = 0; i < 5; ++i)
{
    for (auto j = 0; j < 10; ++j)
    {
        // This if fine - we already protect against race conditions in default_logger()
        threads.emplace_back([](){
            auto& logger = extra::logger_factory_safest::get().default_logger();
            logger.log("Logging from thread safer factory");
        });
    }

    for (auto j = 0; j < 2; ++j)
    {
        // But this is bad. While all the other threads from the previous loop are using a logger instance through a reference to it,
        // we just replace that instance with a new one. Here be dangling references!
        threads.emplace_back([](){
            auto custom_logger = builders::default_builder()
                .with_console_output()
                .make_concurrent()
                .get();
            extra::logger_factory_safest::get().set_default_logger( std::move(custom_logger) );
        });
    }    
}

for (auto& thread : threads)
{
    thread.join();
}
```

</spoilers>

There are two parts to the solution:

1. You need to replace the `std::unique_ptr<logging::ilogger> m_logger;` member variable with a `std::shared_ptr<logging::ilogger>`.
    
2. Instead of returning a reference to a logger in `default_logger()`, you should return a `std::shared_ptr<logging::ilogger>` *by value*. Shared pointers are made for this kind of scenarios - multiple threads (owners) can each have its own copy of the shared pointer pointing to the same resource. As long as at least one owner exists (there is at least one `std::shared_ptr` pointing to the same object), the resource remains valid.

Notice that you don't need to change the argument type of `set_default_logger()` - it can still take a `std::unique_ptr<logging::ilogger>`. It will be automatically converted to a `std::shared_ptr<logging::ilogger>` when assigned to `m_logger`.

#### Addendum  (this is the +2 points part)

If you really want to ace it, you can replace both the `std::atomic<bool> m_initialized` and the `std::unique_ptr<logging::ilogger>`  member variable with a single `std::atomic<std::shared_ptr<logging::ilogger>> m_logger`. In this case, the implementation of `set_default_logger()` will barely change. However the `default_logger()` function will need to explicitly `load` and `store` the atomic shared pointer. So instead of checking `if (!m_initialized)` you will need to do something like:

```cpp
if (auto logger = m_logger.load(); !logger) {
    // ...
}
```

Your `default_logger()` must still return a `std::shared_ptr<logging::ilogger>` by value, not a `std::atomic<std::shared_ptr<logging::ilogger>>`.

Oh yes, you are on your own with this one. Good luck;)

### Finally

You might find the following page very enlightening: https://preshing.com/20130930/double-checked-locking-is-fixed-in-cpp11/
Or very confusing, depending on your point of view;).