# Advanced Programming Concepts, assignment 3

In this assignment you'll practice *dependency injection* and the *dependency inversion principle*. All this to make the design of `logger` more robust and flexible.

## Grading

Doing all the mandatory tasks *correctly** will get you 11 points. There are also two extra-effort tasks:

* [Flexible time format & clock source support for timestamping](#flexible-time-format--clock-source-support-for-timestamping) (3 points)

* Anonymous interface implementations using lambdas (4 points)

## Problem statement

The `logger` that we developed during this week is far from perfect. It's definition looks simple:

```c++
class logger: public loggers::ilogger {
public:
    explicit logger(std::ostream& out) noexcept;
    logger() noexcept;
    void log(const std::string& msg) const override;
private:
    std::ostream& m_out;
    void output_time() const;
};
```

Yet, it breaks at least three important software design rules that give three letters to the [*SOLID*](https://en.wikipedia.org/wiki/SOLID) acronym:

* The [Single Responsibility Principle (S)](https://en.wikipedia.org/wiki/Single-responsibility_principle)
* The [Open-Close Principle (O)](https://en.wikipedia.org/wiki/Open%E2%80%93closed_principle)
* The [Dependency Inversion Principle (D)](https://en.wikipedia.org/wiki/Dependency_inversion_principle)

Why are they broken?

1. The **SRP** is violated because `logger` not only outputs log messages but is also responsible for time-stamping them.

2. The **OCP** is partially violated because the functionality of `logger` cannot be easily extended without changing it in a way that forces recompilation.

3. The **DIP** is violated because `logger` depends strongly on the `<ctime>` header's functions.

There are also some other minor design issues that need refactoring. The most prominent among them is using `std::string` as the type for messages that are passed for logging. As you'll soon see, there are better options.

When doing this assignment you will:

* Get rid of the `<ctime>` dependency in `logger` by creating a new abstract class `itime_source` and its concrete implementation.
* Get rid of the `std::string` usage in `logger` and `ilogger`
* Get rid of the `ostream` dependency in `logger` by creating a new abstract class `itext_writer` and two implementations of it.

## Tasks

### `<ctime>` dependency

Start with the biggest offender: the `<ctime>` header usage (dependency) in `logger`. To remove it, you'll need:

* An interface, `itime_source`, that defines a function(s) that returns a timestamp in a **text form**, e.g. `std::string_view timestamp()`.
  
* An implementation of this interface (e.g. `system_time_source`), this one can (and possibly must) use `<ctime>` in its implementation file.

* A way to inject the concrete time source object into `logger`--this can be done by:
    - Adding a private pointer member to `logger` (`std::unique_ptr<itime_source>`) that will hold a concrete instance of `itime_source`
    - Adding a function to `logger` for setting the time source.

    If in doubt about how to do it, check how this is done for `program` and its private member `m_logger`.


Notice, that by relegating time-stamping to another class we also fixed the **SRP** issue.

BTW, because `logger` uses streams for output, it might be an idea provide a *stream output operator* in `itime_source`. (But you will have to refactor it later again.)

### `std::string` alternatives

By fixing the first problem, we also partially fixed the **OCP** one. Now it's a bit easier to extend `logger` without really modifying it. Time to bring the final touch: `logger` also depends on two other classes: `std::string` and `std::ostream`. 

* Investigate [`std::string_view`](https://en.cppreference.com/w/cpp/string/basic_string_view), and replace usage of `std::string` in `logger` with it. For one thing, `std::string_view` is more generic and offers easy conversions from other string types.
    
### `std::ostream` must go

The dependency on `std::ostream` must go. What we need instead is an interface (abstract class) that exposes functions for writing text to some destination and a concrete implementation of this interface. 

Define the interface `itext_writer` with multiple stream output operator for common built-in types (at least `const char*`, `char`, `int`, `double`).

```c++
struct itext_writer {
    virtual itext_writer& operator<<(std::string_view) = 0;
    virtual ~itext_writer() = default;
};
```

The stream output operator, exposed by this interface should be used by `logger` to send text to an output. This cannot work without a concrete class that implements `itext_writer`, so implement two classes that inherit from `itext_writer`:

- the `console_writer` class that outputs text directly to the console,

- the `stream_writer` class that writes the output text to a file. The name of the file should be passed to the `stream_writer`'s constructor. Naturally, `stream_writer` should open this file for writing.

A concrete instance of `itext_writer` must be *injected* via a unique pointer in the constructor of `logger`. Like this:

```c++
class logger: public loggers::ilogger {
public:
    logger(std::unique_ptr<itext_writer> out);
    /* ~~~ */
private:
    std::unique_ptr<itext_writer> m_writer;
    /* ~~~ */
};

int main() {
    // loger is a pointer to a lib::logger object
    // a unique console_writer pointer is passed to the lib::logger's constructor
    auto logger = std::make_unique<lib::logger>( std::make_unique<writers::console_writer>() );

    // or, more verbose, and now with stream_writer for a change
    auto writer = std::make_unique<writers::stream_writer>("log.txt");
    auto logger = std::make_unique<lib::logger>(std::move(writer));
}
```

## Final tests

When you've implemented everything, and changed `logger` to use the `itime_source` and `itext_writer` abstractions instead of `<ctime>` and `<iostream>`, test your program in the `main` function. You should at least demonstrate:

* Creating a `logger` instance with one of the writers passed to its constructor.
* Setting the time source of `logger` to `system_time_source`.
* Running the `program` class with the `logger` object passed to it.

Your program should work with either `itext_writer` implementation.

## Extra-effort tasks

### Flexible time format & clock source support for timestamping (3 points)

Your implementation of `system_time_source` is hard-coded to use the system clock and a fixed time format. The goal of this extra-effort task is to make the design more flexible by allowing the user to write:

```c++
auto tsource = std::make_unique<time_source<std::chrono::utc_clock>>();
```

Or better yet:

```c++
auto tsource = time_source<std::chrono::utc_clock>::with_format("{:%Y-%m-%d %H:%M:%SS}");
```

#### A simple plan to make it happen

**Use <chrono>**

First of all, if you haven't done so yet, change your `system_time_source` to use the `<chrono> library for getting and formatting the current time. To do this, you'll need to use:

* the `std::chrono::system_clock::now()` function to get the current time point
* the [`std::vformat`](https://en.cppreference.com/w/cpp/utility/format/vformat) function to format it into a string.

> Do not use  `std::format` for formatting. It's easier to use but it will give you a headache later.

By default, your class should use the following format string: `"{:%Y-%m-%d %H:%M:%OS}"`.

**Make your time source a class template***

Rename `system_time_source` to `time_source` and make it a class template with a single template parameter: `Clock`, that defaults to `std::chrono::system_clock`:

```c++
template <typename Clock = std::chrono::system_clock>
class time_source : public itime_source {...};
```

> Remember change the implementation of the `timestamp()` function to use `Clock::now()`.

**Add format support**

You will now make use of a common *creational pattern*: the *static factory method*. A *factory method* is a `static` member function that creates and returns an instance of the class it belongs to. The idea behind it is to provide a simple way of creating an object that would otherwise require a complex constructor or multiple steps. Like this:

```c++
template <typename T>
class MyClass {
public:
    static std::unique_ptr<MyClass> create(/* possibly some parameters */) {
        auto obj = std::make_unique<MyClass>(/* possibly some parameters */);
        // possibly some additional setup steps
        return obj;
    }
private:
    MyClass(/* possibly some parameters */) { /* possibly some setup steps */ }
};

// Usage:
auto my_obj = MyClass<int>::create(/* possibly some parameters */);
```

Your static factory method must be called `with_format` and it must accept a single parameter: a `std::string_view` with a default value of "{:%Y-%m-%d %H:%M:%OS}" representing the format string to be used for formatting timestamps. 

You'll need a `private` member variable in `time_source` to hold the format string. Do not add any public functions for accessing or modifying it. The only way to set it, must be via the `with_format` factory method.

**Show that your code works**

Finally, modify your `main` function to demonstrate that your new `time_source` class template works with different clock sources and format strings:

```c++
auto tsource_utc = time_source<std::chrono::utc_clock>::with_format("{:%Y-%m-%d %H:%M:%SS}");
auto tsource_sys = time_source<std::chrono::system_clock>::with_format("{:%H:%M:%OS}");
```

> You may also define `using` aliases for common clock sources to make your code more readable. For instance:
> ```c++
> using system_time_source = time_source<std::chrono::system_clock>;
> using utc_time_source = time_source<std::chrono::utc_clock>;
> ```
>
> That's exactly what the standard library does with `using string = basic_string<char>;`.

### Anonymous interface implementations using lambdas (4 points)

Some languages, like Java and C#, support anonymous interface implementations. For instance, given an interface `ITimeSource` with a function `getTimestamp()`, you can create an anonymous implementation of this interface in Java on the spot:

```java
ITimeSource timeSource = new ITimeSource() {
    @Override
    public String getTimestamp() {
        return LocalTime.now().format(DateTimeFormatter.ofPattern("HH:mm:ss"));
    }
};
```

C++ does not support this. However, it is flexible enough to allow us to mimic it using the following approach:

```c++
auto time_source = itime_source::with(
        []() -> std::string_view {
            static std::string buffer;
            auto now = std::chrono::system_clock::now();
            return buffer = std::format("{:%Y-%m-%d %H:%M:%OS}", now);
        }
    );
```

Now, it is your time to shine and add this functionality to the `itime_source` interface. You'll also have to implement a special time source using this new feature.

#### A simple plan to make it happen

**Add a static factory function to `itime_source`**

Add a static factory function `with` to the `itime_source` interface that accepts a single parameter: a lambda (or any callable object). The `with` function should return a `std::unique_ptr<itime_source>` that points to an object implementing the `itime_source` interface using the provided lambda for the `timestamp()` function. (You will only be able to fully implement this function in the next step.)

> Hint: this factory function is in fact a *function template* because the type of the lambda is not known in advance.

```c++
template <typename Func>
static std::unique_ptr<itime_source> with(Func&& func) {
    // Code that creates an anonymous implementation of itime_source
}
```

**Implement the anonymous class inside the factory function**

Inside the `with` function, define a local class that inherits from `itime_source` and implements the `timestamp()` function. This class should store the provided lambda (or callable object) in a member variable of type `Func` and use it in the `timestamp()` function. 

Btw, C++ really supports putting a class definition inside a function body:

```c++
// THIS IS NOT AN IMPLEMENTATION OF YOUR EXERCISE / `with` should be a static member of itime_source AND it should be a function template /
// (but you can use it as inspiration)
struct iGreeter
{
    std::string greet() const = 0;
    virtual ~iGreeter() = default;
}

std::unique_ptr<iGreeter> with( std::string(*func_ptr)() ) {
    struct FancyLocalClass : public iGreeter {
        FancyLocalClass( std::string(*fp)() ) : func_ptr_(fp) {}
        
        std::string greet() const override {
            return func_ptr_();
        }            
        std::string(*func_ptr_)();
    }; 
    return std::make_unique<FancyLocalClass>(func_ptr);
}

int main() {
    auto greeter = with( []() -> std::string { return "Hello, World!"; } );
    std::cout << greeter->greet() << std::endl; // Outputs: Hello, World!
}
```

> We say that this class is *anonymous* because it is defined inside the `with` function and is not accessible from outside it. In fact, it must and does have a name (you can choose any valid identifier).


**Show that your code works**

Finally, modify your `main` function to demonstrate that your new `with` factory method works correctly by creating an anonymous implementation of `itime_source` using a lambda function for timestamping (examples at the end of this document).

#### Special timestamper

Demonstrate your `with` factory method by creating a special time source in your `main` function that uses a lambda to return the *running time* of the program in seconds with millisecond precision. You can use `std::chrono::steady_clock` for this purpose. The rest is on you. But keep in mind that:

* It must be a single lambda expression passed to the `with` factory method. No external variables allowed.

* This lambda must be able to store the starting time point of the program (the time when the lambda is created) and use it to calculate the elapsed time whenever `timestamp()` is called.

#### Examples

```c++
auto tsource = itime_source::with(
    []() -> std::string_view {
        static std::string buffer;
        auto now = std::chrono::system_clock::now();
        return buffer = std::format("{:%Y-%m-%d %H:%M:%OS}", now);
    });
```

Or:

```c++
auto tsource = itime_source::with(
    [buffer=std::string{}]() mutable = -> std::string_view {
        auto now = std::chrono::utc_clock::now();
        return buffer = std::format("{%H:%M:%OS}", now);
    });
```