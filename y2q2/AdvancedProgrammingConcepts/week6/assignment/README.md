# Advanced Programming Concepts, assignment 6

## Before you start

The structure and semantics of `iobserver` and `iobservable` interfaces are a bit different from what has been discussed in the class. Specifically:

* There is a new library `libobs` that contains the observer pattern related code. It's linked to the `assignment_week_6` target automatically.

* Most of the classes are located in [`libobs/observers/observers.hpp`](libobs/observers/observers.hpp) header file.

* The `observable_decorator` can be found in `include/decorators` and `src/decorators` directories. It's a part of the logger implementation.

* The `iobserver` and `iobservable` interfaces are templated. Both take a single template parameter that represents the type of the event data. For example, `iobserver<int>` is an observer that can receive notifications with an `int` parameter. This makes the interfaces more reusable.

## Overview

In this assignment, you'll work with the *observer* pattern and elevate its implementation to a C#++ level. Really. If you've used *events* in C# -- this is exactly what you'll be trying to achieve. If not, take a look at the following C# snippet:

```csharp
public class Button {
    
    // This is an event declaration, events can be subscribed to
    // In C++, we used iobservable interface for similar purposes
    public event EventHandler Clicked;

    
    protected virtual void OnClicked(EventArgs e) {
        // Notify the subscribers (observers) about the event
        Clicked?.Invoke(this, e);
    }
    public void SimulateClick() {
        OnClicked(EventArgs.Empty);
    }
}

public class Program {
    public static void Main() {
        Button button = new Button();

        // This is how you subscribe to an event (register a callback)
        button.Clicked += Button_Clicked;
        button.SimulateClick();
    }

    // This is the event callback - also known as event handler in the C# lingo
    private static void Button_Clicked(object sender, EventArgs e) {
        Console.WriteLine("Button was clicked!");
    }
}
```

In C#, *events* are a built-in language feature. An event is like the `iobservable` interface. It allows for adding and removing *observers* (subscribers) and notifying them when something happens. The syntax is a bit different, but the idea is the same.

For instance, adding observers/ subscribers in C++ was done with:

```c++
class observable : iobservable<int>;

class observer : iobserver<int> {
    void notify(int data) override {
        // handle the event
    }
};

// Adding an observer
auto subscriber = std::make_unique<observer>();
auto observed = std::make_unique<observable>();

observed->add_observer( subscriber.get() );
```

This is different from C# syntax, where a subscriber is allowed to be a free function (instead of a class implementing a specific interface) and the syntax for adding a subscriber is different:

```c#
observed += subscriber;
```

### C++ event equivalent

But there's where the power of C++ comes in. You can created your own C#-like events in C++! And it isn't even that much programming. Once you've completed your implementation, the following C++ program should work:

```c++
#include <iostream>
#include "observers/events.hpp"

void button_clicked_handler(int how_many) {
    std::cout << "Button was clicked " << how_many << " times!\n";
}

struct Button {
    observers::event<Button, int> clicked;

    void simulate_click(int how_many) {
        // Notify the subscribers about the click event
        clicked(how_many);
    }
};

int main() {
    Button button;
    
    // Subscribe to the event with a free function
    button.clicked += button_clicked_handler;
    
    // Simulate a button click by notifying the subscribers
    button.simulate_click(42);
}
```

## Grading

Doing all the mandatory tasks *correctly** will get you 11 points:

* Writing correct [*type aliases* (1 point)](#type-aliases-1-point)
* Subscribing and unsubscribing [callback (*4 points*)](#subscribing-and-unsubscribing-4-points)
* Invoking the event [(*2 points*)](#invoking-the-event-2-points)
* Making [*invoking the event is `private`!* (1 point)](#invoking-the-event-is-private-1-point)
* Handling legacy [*iobserver interface* (3 points)](#handling-legacy-iobserver-interface-3-points)

There are just one extra-effort task:

* [Concurrent events](./README_EXTRA.md) (many points)

## Before you start

You need a short introduction to C++ `std::function` and *variadic templates*.


### std::function

`std::function` is a part of the C++ Standard Library. It resides in the `<functional>` header. To cut straight to the chase, `std::function` is the C++ way of storing and using *callable* objects in a type-safe manner. A *callable* object is anything that can be called like a function, including:

* Regular (free) functions.
* Member functions of classes.
* Lambda expressions.
* Function objects (objects of classes that overload the `operator()`).

And you can do things like this with it:

```c++
#include <functional>

int add(int a, int b) {
    return a + b;
}

std::function adder = add; // store the `add` function in a std::function

int main()
{
    std::cout << "It seems like 2 + 3 still equals " << adder(2, 3) << "\n";
}
```

Naturally, you won't use it just to store a function you have direct access to. You will use it to store function for later use!
`std::function` is very strict about types. When you define a `std::function` **without initializing it directly**, you must specify the exact signature of the callable it can hold. And so, to have a function that takes and `int` and returns a `std::string`, you would define it like this:

```c++
#include <functional>
#include <string>

std::function<std::string(int)> int_to_string;
```

And to have one that takes two vectors of `double`s and returns nothing (`void`), you would define it like this:

```c++
#include <functional>
#include <vector>

std::function<void(std::vector<double>, std::vector<double>)> process_doubles;
```

As you have probably noticed, the syntax for the function signature type is simply `ReturnType(ParamType1, ParamType2, ...)`.

You can assign any callable that matches the signature to a `std::function`. For example:

```c++
#include <functional>
#include <string>
#include <iostream>

std::string as_string(int x) {
    return "Number: " + std::to_string(x);
}

std::function<std::string(int)> int_to_string = as_string;

std::cout << int_to_string(42); // prints "Number: 42"
```

Or with a *lambda expression*:

```c++
std::function<std::string(int)> int_to_string = [](int x) {
    return "Number: " + std::to_string(x);
};

std::cout << int_to_string(42); // prints "Number: 42"
```

It's a bit more work with *member functions* because you need an instance of the class to call them on:

```c++
class Converter {
public:
    std::string as_string(int x) {
        return "Number: " + std::to_string(x);
    }
};

Converter obj{}; // we need on object of type Converter

// We use std::bind to bind the member function to the object
std::function<std::string(int)> int_to_string = std::bind(&Converter::as_string, &obj, std::placeholders::_1);
std::cout << int_to_string(42); // prints "Number: 42"

// Or a simpler variant using a lambda, that captures the `obj` object
std::function<std::string(int)> int_to_string = [&obj](int x) {
    return obj.as_string(x);
};
std::cout << int_to_string(42); // prints "Number: 42"
```

Finally, most often than not, you can let the compiler deduce the type of the `std::function` for you:

```c++
std::function int_to_string = [&obj](int x) {
    return obj.as_string(x);
};
std::cout << int_to_string(42); // prints "Number: 42"
```

As disappointing as it is, you are not going to do anything fancy with `std::function`. You will just use it to store the callbacks (subscribers) in your `event` class template. 

### Variadic Templates

Let's talk about fancy template techniques. Up till now, you used templates with a fixed number of template parameters. For instance, to define a function template that takes two value of some (possibly different) different types, and prints them, you would write:

```c++
template<typename T1, typename T2>
void print(const T1& a, const T2& b) {
    std::cout << a << ", " << b << "\n";
}
```

The problem is that very often you don't know in advance how many parameters you will need. What if you needed a *function* that can print any number of parameters? Naturally, you could write multiple overloads, to support possibly any foreseeable number of parameters, but that would be tedious, to say the least.

In C++, you can use *variadic templates* instead. This feature allows you to define templates that take a *variable number* of template parameters. Here's how you could declare a `print` function template that can take any number of parameters:

```c++
template<typename... Ts>
void print(const Ts&... args);
```

Here, `Ts...` is a *template parameter pack*. It stands for **zero or more** template parameters. We use this parameter pack to define the function parameters as `const Ts&... args`. Again `args...` represents **zero or more** function parameters, each of the type corresponding to the types in the `Ts` pack.

When you call `print`, the compiler does its deduction magic and substitutes the actual types for the `Ts` pack. For instance:

```c++
print(42, 24.0, "Hello");
// will get translated to:
print<int, double, const char *>(42, 24.0, "Hello");

// And:
print();
// will get translated to:
print<>();
```

There are many things you can do with parameter packs, for example, you can see how many were passed using `sizeof...` operator:

```c++
template<typename... Ts>
void print_count(const Ts&... args) {
    std::cout << "Number of arguments: " << sizeof...(Ts) << "\n";
}

print_count(42, 24.0, "Hello");
// will print: Number of arguments: 3
```

It is not possible to access the individual pack elements by index, but you can *expand* the pack using the `...` to use its elements. For example, you could implement the `print` function by expanding the `args` pack like this:

```c++
template<typename... Ts>
void print(const Ts&... args) {
    // Expand the args pack and print each argument
    ((std::cout << args << " "), ...);
    std::cout << "\n";
}
```

Formally, this is knows as *folding* the parameter pack or a *fold expression*. The `...` after the comma tell the compiler to repeat the left-hand side expression (`std::cout << args << "  "`) for all the arguments. When used, it will be translated to:

```c++
print(42, 24.0, "Hello");

// will result in the compiler generating code equivalent to:
void print<int, double, const char *>(const int & arg0, const double & arg1, const char *& arg2)
{
  ((std::cout << arg0 << " ") , (std::cout << arg1 << " ") , (std::cout << arg2 << " "));
  std::cout << "\n";
}
```

But worry not, you are going to do no such things. The only purpose for parameter packs in this assignment is to allow you to define an `event` class template that can support any number of parameters for its callbacks. You will be simply forwarding the packs as needed. Something along the lines of:

```c++
// a normal function taking three parameters
double add_three(int a, double b, int c)
{
    return a + b + c;
}

// a variadic template function that takes any number of parameters
template<typename... Args>
void use_pack(Args... args) {
    // forward (pass on) the args to some function that takes the same parameters
    add_three( args... );
}

use_pack(1, 2.5, 3); // calls add_three(1, 2.5, 3)
```

## The real assignment, a.k.a. the `event` class template


**You must implement the `event` class template in the [`libobs/observers/event.hpp`](libobs/observers/event.hpp) file. Put it in the `observers` namespace.**

As very often is the case, we start with a class diagram at its full glory:

```text
,------------------------------------------------------.
|                     event<Args...>                   |
|------------------------------------------------------|
|-- type aliases --                                    |
| callback_t = std::function<void(Args...)>            |
| handle_t = std::size_t                               |
|-- data members --                                    |
|-m_callbacks: std::unordered_map<handle_t, callback_t>|
|-m_next_handle: handle_t                              |
|-- functions --                                       |
|+ operator+=(callback: callback_t const&): handle_t   |
|+ operator+=(callback: callback_t &&): handle_t       |
|                                                      |
|+ operator-=(handle: handle_t): bool                  |
|                                                      |
|-operator()(args: Args...): void                      |
`------------------------------------------------------'
```

First of all, the `event` class template takes a variable number of template parameters `Args...`. Consequently, you will have to declare it as:

```c++
template <typename... Args>
class event{
    // things to come
};
```

These `Args...` represent the types of the parameters that the callbacks (subscribers) will take. For instance, an `event<int, double>` allows subscribing the following callbacks:

* A free function like `void callback(int, double);`

* A lambda like `[](int a, double b) { /* do something */ }`

Below you will find a description of the `event` class template's functionality. You will have to implement it, following the description as closely as possible.

> If you find it mind-bending to think about the `Args...` pack, try to imagine that you are implementing a non-template `event` class that only supports callbacks taking a single template parameter `Arg`. The only syntactic difference is that everywhere you see `Arg`, you will have to replace it with `Args...`. 

### Type aliases (1 point)

To simplify the syntax, there are two type aliases defined in the class, `callback_t` and `handle_t`. `callback_t` is an alias for `std::function<void(Args...)>`, while `handle_t` is an alias for `std::size_t`.

`std::function<void(Args...)>` (or `callback_t`) stands for any callable object that takes parameters of types `Args...` and returns `void`. This is the type of the callbacks that can be subscribed to the event, and that will be triggered when the event is invoked.

### Subscribing and unsubscribing (4 points)

The `event` class template stores all the callbacks in an `std::unordered_map`, where the keys are of type `handle_t` and the values are of type `callback_t`. Every time a new callback is added, it is assigned a unique handle (of type `handle_t`), which is returned to the caller. The value of the handle, stored in `m_next_handle`, starts from zero and is auto-incremented for every new subscription. 

The `event` class template allows subscribing to the event by overloading the `operator+=`. There are two overloads of this operator, one for lvalue references to `callback_t` and one for rvalue references to `callback_t`. Both overloads add the `callback` to the `m_callbacks` map (by copying or moving), assign it a unique handle, and return that handle.

To unsubscribe from the event, the `event` class template exposes the `operator-=`. This operator takes a `handle` of type `handle_t` as a parameter and removes the corresponding callback from the `m_callbacks` map. It returns `true` if the callback was successfully removed and `false` otherwise.

### Invoking the event (2 points)

Invoking the event (known as *notifying the subscribers* in observer pattern terminology) is done by calling the `operator()`, which takes parameters of types `Args...`. This operator iterates over all the callbacks stored in the `m_callbacks` map and invokes each one, passing the provided arguments to them.

**Note that** the callback functions are expected to return `void` but they may throw exceptions. If a callback throws an exception, the `operator()` should catch it and continue invoking the remaining callbacks. This ensures that all subscribers are notified even if one of them fails.

### Invoking the event is `private`! (1 point)

If you look back at the UML diagram, you'll notice that the `operator()` is declared as `private`. This is an important design decision. We don't want just about anyone to be able to invoke the event. Only the class that owns the event (has an `event` member) should be able to do that. It is up to you to figure out how to achieve this. You'll need to use the `friend` keyword for this. A further hint is embedded in the example program at the beginning of this document. If you scroll up all the way to the [C++ event equivalent](#c-event-equivalent) section, you will notice that the `clicked` event takes an additional template parameter: the class that owns the event. Now, combine these two pieces of information, and you should be able to figure it out.

### Handling legacy iobserver interface (3 points)

The `event` class template in its current form only supports subscribing callbacks of type `std::function<void(Args...)>`. However, it would be really great to ensure compatibility with existing code that uses the `iobserver<TEvent>` interface. You know, to ease off the migration to the new event system. There is a small catch though. The `iobserver<TEvent>` interface has a `notify` method that takes a single parameter of type `TEvent`. Consequently, it seems that it can only be used with events that have a single argument. However, this is not necessarily true. Also `TEvent`s that can be constructed from `Args...` should be supported:

```c++
struct MyEvent {
    int x;
    double y;
    std::string msg;
};

// An observer that handles MyEvent
class MyObserver : public iobserver<MyEvent> {
public:
    void notify(const MyEvent& event) override { /*~~~*/ }
};

// An event that takes multiple arguments
// Yes, this won't compile because events must be members of some class
// However, ignore that for now - this is just an example
observers::event<int, double, std::string> my_event;

MyObserver observer{};

// This should work, as MyEvent can be constructed from (int, double, std::string)
my_event += &observer;
```

To achieve this, you need to add an additional overload of the `operator+=` (not in the UML diagram above) that takes a pointer to an `iobserver<TEvent>` as a parameter. This new operator should create a callback using a *lambda expression* that calls the observer's `notify` method. The lambda must match the signature `std::function<void(Args...)>`. Finally, this lambda should be added to the `m_callbacks` map, and the handle should be returned.

The declaration of this new overload looks like this:

```cpp
template<typename... Args>
class event {
    // existing code...
public:
    template <typename TEvent>
    handle_t operator+=(iobserver<TEvent>* observer) {
        // Create a (lambda) callback that calls the observer's notify method
        // The callback should match the signature std::function<void(Args...)>
        // Add the callback to m_callbacks and return the handle
    }
};
```

## Tests

There is a testing target `test_events` that contains a set of tests for the `event` class template. This target won't compile until you have implemented the `event` class template as described above. Once you have done that, you can run the tests to verify that your implementation works correctly. The tests that cover the `iobserver` compatibility feature are disabled by default. To enable them, go to [`libobs/tests/test_events.cpp`](libobs/tests/test_events.cpp) and set the `ENABLE_OBSERVER_SINGLE_ARG` and `ENABLE_IOBSERVER_MULTIPLE_ARGS` constants to `true`.

For simple testing and experimentation try the following snippets:

### Simple event with a single argument, triggering event is `public` and no friends are used

```c++
#include <iostream>
#include "observers/events.hpp"
void button_clicked_handler(int how_many) {
    std::cout << "Button was clicked " << how_many << " times!\n";
}

struct Button {
    observers::event<int> clicked;

    void simulate_click(int how_many) {
        // Notify the subscribers about the click event
        clicked(how_many);
    }
};

int main() {
    Button button;
    
    // Subscribe to the event with a free function
    button.clicked += button_clicked_handler;

    // And with a lambda expression
    button.clicked += [](int how_many) {
        std::cout << "Lambda: Button clicked " << how_many << " times!\n";
    };
    
    // Simulate a button click by notifying the subscribers
    button.simulate_click(42);
} 
```

### Event with multiple arguments, triggering event is `public` and no friends are used

```c++
#include <iostream>
#include "observers/events.hpp"
void button_clicked_handler(int x, double y, const std::string& msg) {
    std::cout << "Button was clicked with x=" << x << ", y=" << y << ", msg=" << msg << "\n";
}

struct Button {
    observers::event<int, double, std::string const&> clicked;

    void simulate_click(int x, double y, const std::string& msg) {
        clicked(x, y, msg);
    }
};

int main() {
    Button button;
    
    // Subscribe to the event with a free function
    button.clicked += button_clicked_handler;

    // Simulate a button click by notifying the subscribers
    button.simulate_click(7, 3.14, "Hello World");
}
```

### Event with multiple arguments, triggering event is `private` and `friend` is used

```c++
#include <iostream>
#include "observers/events.hpp"
void button_clicked_handler(int x, double y, const std::string& msg) {
    std::cout << "Button was clicked with x=" << x << ", y=" << y << ", msg=" << msg << "\n";
}

struct Button {
    observers::event<Button, int, double, std::string const&> clicked;

    void simulate_click(int x, double y, const std::string& msg) {
        clicked(x, y, msg);
    }
};

int main() {
    Button button;
    
    // Subscribe to the event with a free function
    button.clicked += button_clicked_handler;

    // And with a lambda expression
    button.clicked += [](int x, double y, const std::string& msg) {
        std::cout << "Lambda: Button clicked with x=" << x << ", y=" << y << ", msg=" << msg << "\n";
    };

    // Simulate a button click by notifying the subscribers
    button.simulate_click(24, 42.0, "Hello World");
}
```

### Event with multiple arguments, triggering event is `private`, `friend` is used, and subscribing an `iobserver<TEvent>`

```c++
#include <iostream>
#include "observers/events.hpp"
#include "observers/iobserver.hpp"

struct ButtonClickedEvent {
    int x;
    double y;
    std::string msg;
};

class ButtonClickedObserver : public observers::iobserver<ButtonClickedEvent> {
public:
    void notify(const ButtonClickedEvent& event) override {
        std::cout << "Observer: Button was clicked with x=" << event.x << ", y=" << event.y << ", msg=" << event.msg << "\n";
    }
};

struct Button {
    observers::event<Button, int, double, std::string const&> clicked;

    void simulate_click(int x, double y, const std::string& msg) {
        clicked(x, y, msg);
    }
};

int main() {
    Button button;
    ButtonClickedObserver observer;
    
    // Subscribe to the event with an iobserver<TEvent>
    button.clicked += &observer;
    // Subscribe to the event with a free function
    button.clicked += button_clicked_handler;

    // And with a lambda expression
    button.clicked += [](int x, double y, const std::string& msg) {
        std::cout << "Lambda: Button clicked with x=" << x << ", y=" << y << ", msg=" << msg << "\n";
    };

    // Simulate a button click by notifying the subscribers
    button.simulate_click(42, 2.768, "Hello from an event!");
}

