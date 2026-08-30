# Advanced Programming Concepts, assignment 4

This week we've talked about the structural patterns: *adapter*, *composite* and *decorator*. Of those three *composite* is usually quite easy to grasp and implement. That leaves *adapter* and *decorator*.

In this assignment you'll implement a class `clogger_adapter` that wraps a C-based logging utility to be used just like any other logger that implements the `ilogger` interface. In the second part, we'll discuss the *decorator* pattern, make some tweaks to the existing code and add a new decorator class.

## Grading

Doing all the mandatory tasks *correctly** will get you 11 points:

* Implementing the [`clogger_adapter` class (5 points)](#adapting-the-c-based-logger-5-points)
* Implementing the [`decorator` base class (1 point)](#the-new-decorator-base-class-1-point)
* Implementing the [`timestamp_decorator` class (2 points)](#refactoring-timestamp_decorator-class-2-points)
* Implementing the [`runtime_decorator` class (3 points)](#the-new-runtime_decorator-class-3-points)

There are just one extra-effort task:

* [Concurrent logger decorator](./README_EXTRA.md) ( points)

## Adapting the C-based logger (5 points)

### logger.h, problem statement

Take a look at the *logger.h* header located at *./clib/clib*. There are three functions of interest there:

```c
extern lg_result_e lg_create(lg_logger_t** log, time_t interval_s);

extern lg_result_e lg_destroy(lg_logger_t** log);

extern lg_result_e lg_log(lg_logger_t*, const char* msg);
```

The naming of all the functions follows a common C convention of prepending a name with an 2-3 letter acronym that's unique to the current module. That's to avoid name collisions.

The `lg_logger` writes messages to a file, using a so-called *rolling log*--it means that files to which messages are logged will automatically change at some fixed interval. This interval (in seconds) is passed to `lg_create` function. For instance, let's say that the interval is set to 10 seconds and `lg_log` is used to log three messages:

1. At t = 0s: "Hello"
2. At t = 8s: "world"
3. At t = 11s: "!"

The first two messages will be logged to a file (e.g. *220907_110500.0*)--they are both within the first 10 seconds. The third message will be logged to a file (e.g. *220907_110500.1*) because the log file will be automatically *rolled* at t = 10s. As you might have noticed, the file names are in a specific format: the day and time of the log creation followed by a number as a file extension.

All the *logger* functions declared in *logger.h* are C functions that return a result code. It is either `lgr_ok` or `lgr_error`. Not very informative but at least we know when something went wrong.

They also take a pointer to `struct lg_logger`, or an address of a pointer, like in the case of the first two functions. `lg_logger` is also `typedef`-ed to `lg_logger_t`, that's just for simplicity. It's a C-code and without this `typedef` we'd always have to use the more explicit:

```c
struct lg_logger* my_logger;
```

instead of shorter:

```c
lg_logger_t* my_logger;
```

As users of *logger.h* we have no idea how `struct lg_logger` looks like - its layout is defined only in the corresponding source file. Such a data type is called an [**opaque data type**](https://en.wikipedia.org/wiki/Opaque_data_type). It's common to hide information about implementation details from a user of library code--this way, the content of such a structure can be easily changed without affecting the API stability.

`lg_logger` is used to keep and pass runtime information about the *logger* state. To log anything using `lg_log` you must first create and initialize an `lg_logger` object. The function that does it (`lg_create`) takes an address of a pointer to `lg_logger` (or simply a pointer to a pointer) as its first argument. It would be an error to do any of:

```c
#include "logger.h"

int main(){
    lg_logger_t log_1 = {};   // create lg_logger on the stack

    lg_result_t result_1 = lg_create(&log_1, 60); // <- ERROR

    lg_logger_t* log_2 = malloc(sizeof(lg_logger_t)); // or on the heap

    lg_result_t result_2 = lg_create(&log_2, 60); // <- ERROR
}
```

Every single line of the code above contains an error. The first approach won't work because we pass a `lg_logger_t*` instead of `lg_logger_t**`. Moreover, we try to create `lg_logger_t` on the stack--this won't work because we don't know (or rather the compiler doesn't know at this point) how much memory `lg_logger` occupies. It's an opaque type--we only know it exists.

The second approach is a bit better, we correctly pass `lg_logger_t**` to `lg_create` but again we fail to observe that we have no idea what the size of `lg_logger_t` is. The compiler doesn't know this neither but that's what we require it to figure out with: `sizeof(lg_logger_t)`. On top of this `lg_create` expects that there is no memory allocated yet for a *logger*. In fact, it's the first check it does:

```c
lg_result_e lg_create(lg_logger_t** log, const char* file_name, time_t interval_s){
    // check that *log == NULL
    lg_result_e result = (*log)? lgr_invalid_argument : lgr_ok;
    /* ~~~ */
    return result
}
```

Thus, the only way to create and initialize an `lg_logger` object is to let `lg_create` take care of this:

```c
// must be NULL, lg_create checks this pre-condition
lg_logger_t* log = NULL;

lg_result_t result = lg_create(&log, 60);
```

We can declare a variable of type `lg_logger_t*` because it's just a pointer like any other--its size is architecture-dependent (usually 64 bits). Then we pass an address of this pointer variable (`&log`) to `lg_create`, which in turn allocates the memory and initializes the structure.

With *logger* initialized the rest is easy:

```c
lg_logger_t* log = NULL;

lg_result_t result = lg_create(&log, 60);

if(lgr_ok == result){
    // the results of lg_log and lg_destroy are not checked for brevity
    // but THEY REALLY SHOULD BE
    lg_log(log, "Hello world");
    lg_log(log, "Hello again");

    lg_destroy(&log);
}
```

Don't forget to destroy the `lg_logger` object with `lg_destroy` when you are done with it! Also, it's most likely a good idea to grab the results of calling all those `lg_` functions to check if they didn't return `lg_error`.

### Class `clogger_adapter`

Your first task it to implement an adapter class `clogger_adapter` that will make the `lg_logger` functionality available via the `logging::ilogger` interface. 

1. This class should belong to the `logging` namespace.

2. The class should implement `ilogger`, and to do so, it must inherit from it and override its functions.

3. It also needs a constructor that will take a *rolling interval* as its argument, and forward it to `lg_create`.

    ```cpp
    logging::clogger_adapter::clogger_adapter(std::chrono::seconds roll_interval);
    ```

    Notice, that the type of the `roll_interval` parameter is not a built-in like `int` or `long`. Figure out how to convert it to a raw number.

4. Finally, you should add a `private` data member to store a **pointer to an `lg_logger_t` object**, just like in the C example code. (I'll call this data member `m_clogger`). Notice that this is a raw pointer, not a smart one. If you were to use a smart pointer (which then would own the raw pointer `m_clogger`), then the smart pointer would release the memory of the `lg_logger` structure by calling `delete` on `m_clogger`, but this would be disastrous. 

5. Implement the constructor of your class. It must initialize `m_clogger`. It should check the result returned by `lg_create` and if it's `lgr_error` it would be a good idea to throw a `std::runtime_error` exception with some useful information.

6. `m_clogger` must be also properly destroyed when no more needed. Add clean-up for `m_logger` where appropriate.


If you've done everything correctly you should be able to check your `clogger_adapter` with:

```cpp
auto log = std::make_unique<logging::clogger_adapter>(std::chrono::seconds{5});
auto decorated = std::make_unique<extensions::timestamp_decorator>(std::move(log));
program prog{ std::move(decorated) };
prog.run();
```

Or take a more straightforward approach if you just want to see the log files being rolled:

```cpp
#include <thread> 

logging::clogger_adapter clog{3};
clog.log("Hello World!");
std::this_thread::sleep_for(std::chrono::seconds{6});
clog.log("Once more hello");
std::this_thread::sleep_for(std::chrono::seconds{6});
clog.log("And the final one");
```

## The new `decorator` base class (1 point)

Your second task will focus on decorators. During this week's lesson we've seen an implementation of `timestamp_decorator`. It had a simple public interface:

```cpp
class timestamp_decorator: public logging::ilogger {
public:
    explicit timestamp_decorator(std::unique_ptr<logging::ilogger> inner) noexcept;
    virtual void log(std::string_view msg) const override;
private:
    std::unique_ptr<logging::ilogger> m_inner;
};
```

And its task was to wrap an `ilogger` object and add timestamping functionality to it:

```cpp
auto writer = std::make_unique<io::writers::stream_writer>("_out1.txt");
auto log = std::make_unique<logging::logger>(std::move(writer));
// decorating logger with timestamping
auto decorated = std::make_unique<extensions::timestamp_decorator>(std::move(log));
program prog{ std::move(decorated) };
prog.run();
```

However, this piece of code is not how decorators are usually coded. Normally, decorators, just like about any other generic utility, start with an *abstract class* or an *interface*. Here, we'll take a similar approach. Since we want to simplify our code, we'll use a *concrete* `decorator` class that will have a piece of common functionality in it. It will serve as a parent class to other decorators. Its functionality is:

* Wrapping an `ilogger` object, just like `timestamp_decorator` does now.

* Implementing the `ilogger` interface. However, instead of modifying the message, `decorator::log` should just pass the message unchanged to the wrapped `ilogger` object.

1. Create a new class `decorator` that implements `logging::ilogger`. It should reside in the `extensions` namespace. 

2. Add a `private` data member, for holding the decorated `ilogger`. If in doubt look into `timestamp_decorator` for hints.

3. Add a constructor that takes the `ilogger` object being decorated.

4. Implement the `decorator::log` override. It should just pass the unchanged message to the decorated `ilogger`'s `log` function.


This barely functional `decorator` class might seem silly, but it provides the basic wrapping/ decorating of another `ilogger`. Consequently, child classes of `decorator` need not to do it.

## Refactoring `timestamp_decorator` class (2 points)

All this work wasn't for nothing. With `decorator` ready you can simplify the implementation of `extensions::timestamp_decorator` a lot.

1. This class should belong to the `extensions` namespace (if it doesn't yet).

2. Remove both the constructor and the private `m_inner` member from `timestamp_decorator`. This functionality is provided by the base `decorator` class.

3. Talking about base classes. Make `timestamp_decorator` inherit from `extensions::decorator` instead of from `logging::ilogger`.

4. By default, a child class doesn't expose its parent class' constructors. So despite `decorator` having a constructor that takes a `std::unique_ptr<logging::ilogger>` argument you won't be able to use it directly when creating a `timestamp_decorator` object. In short, this works:

    ```cpp
    auto writer = std::make_unique<writers::stream_writer>("_out1.txt");
    auto log = std::make_unique<logging::logger>(std::move(writer));

    auto decorated_parent = extensions::decorator{ std::move(log) };
    ```

    But this won't even compile:

    ```cpp
    /* ~~~ */

    auto decorated_child = extensions::timestamp_decorator{ std::move(log) };
    ```

    You can, however, make the parent's constructor available in a child class. This is how it's done:

    ```cpp
    class timestamp_decorator: public decorator {
    public:
        using decorator::decorator;
        /* ~~~ */
    };
    ```

    With this line of code we state that `timestamp_decorator` will be publicly exposing the constructors of its parent class `decorator` (there's only one such constructor actually). With this, the line of code which wouldn't compile before will work just fine.

5. Change the implementation of `timestamp_decorator::log`. In the current implementation we call `log` on the `m_inner` object. This is no longer possible. Instead we should call the parent's function `decorator::log`. If you run into problems, [this *Stackoverflow*'s post should help](https://stackoverflow.com/questions/672373/can-i-call-a-base-classs-virtual-function-if-im-overriding-it).

Congratulations! You just performed one of the many refactorings in your programmer's career.


## The new `runtime_decorator` class (3 points)

In the last part you'll add another decorator to your program: `runningtime_decorator` it will work very similarly to `timestamp_decorator` but instead of adding the time stamp it will be adding the current running time of a program with a nanosecond accuracy. (If your system permits such a thing.)

Requirements:

1. Add a class `runningtime_decorator` that belongs to the `extensions` namespace and inherits from `decorator` (similarly to how `timestamp_decorator` does it).

2. To calculate the current running time you'll need to store the starting time of the program. This is not an easy task. For now, you'll use a simple workaround. you'll store the starting time in a `private` data member. Add such a data member to your class:

    * It must be declared `static inline` (static because we want to have just one *global* startup time) and possibly `const`

    * Its type must be [`std::chrono::time_point<std::chrono::high_resolution_clock>`](https://en.cppreference.com/w/cpp/chrono/high_resolution_clock) --this is the highest precision time measurement available in C++

    * It must be initialized directly inside your class definition in the header file, at the point of its declaration, with `std::chrono::high_resolution_clock::now()`.

3. The only thing that's left is decorating a message with the current running time in the `runningtime_decorator::log` function. To calculate the running time and obtain full seconds and fractional nanoseconds do the following:

    ```cpp
    // s_start_time is the name of the private variable that holds the starting time
    auto running_time = std::chrono::high_resolution_clock::now() - s_start_time;
    
    // full seconds of the running time
    auto seconds = std::chrono::duration_cast<std::chrono::seconds>(running_time);
    running_time -= seconds;
    
    // remaining nanoseconds of the running time
    auto nano = std::chrono::duration_cast<std::chrono::nanoseconds>(running_time);
    ```

4. Be aware of the difference in scale between a nanosecond and a second. If done incorrectly, this can lead to unexpected times printed. For instance if the program is only running for 4242 nanoseconds and you output your time like this:

    ```cpp
    std::ostringstream oss;
    oss << seconds.count() << '.' << nano.count();
    ```
    
    You'll get *"0.4242"* instead of *"0.000004242"*. 
    
    You most likely want to investigate [`std::setfill`](https://en.cppreference.com/w/cpp/io/manip/setfill) and [`std::setw`](https://en.cppreference.com/w/cpp/io/manip/setw) if you want to produce a correct output. 

## Finally

When you are ready, test your program in the `main` function, demonstrating its functionality and working of the new or refactored components.
