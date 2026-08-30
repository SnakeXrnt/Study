# Advanced Programming Concepts, assignment 6

## Points

* Following the this tutorial assignment, up to the *Programmer-friendly design* section: 3 points.
* Figuring out and implementing the *Programmer-friendly design*: 1 points.
* Implementing *Pimpl* with virtual polymorphism and demonstrating it: 2 points.
* Reading about and talking about the C++11 ABI breaking changes that involved `std::string` during a sign-off: 1 points
* Reading about and telling us/ demonstrating in the *Compiler Explorer* what and why is wrong with the `std::unique_ptr` on the *System V ABI (x86-64)* during a sign-off: 2 points.

The third point is not covered in this text. But the idea is to create an interface `event_impl_base` with virtual functions, and have `event_impl` inherit from it. Then, `event` will hold a pointer to `event_impl_base`, allowing different implementations of `event_impl` to be used interchangeably. You must demonstrate this by creating two different implementations of `event_impl` with some extra functionalities (e.g., logging observer additions/removals, counting notifications, using different data structures for storing observers, etc.).

## Extra effort assignment

The current state of affairs of your `event` implementation is such that it *leaks its private implementation details* in its publicly-accessible interface. Confused? Look at the snippet below:

```cpp
template <typename...Args>
struct event 
{
  // ...
private:
  void operator()(Args... args) 
  {
    for (auto&& [handle, obs]: observers_) 
      {
        obs(args...);
      }
  }
};
```

Just about everybody and their grandmother can see that `event` uses a private `operator()` to notify its observers. Knowing is not that bad in itself (because it's private), but it does mean that the implementation details of `event` are now part of its *publicly visible* interface. Every time you want to adjust it, either by adding a new `private` function or a data member, or even changing the existing one, you force recompilation of existing code that uses `event`. 

You already know one solution to this problem: hiding the implementation behind an interface that just defines the public API. However, it's not really applicable here, because:

* `event` is a class template, and you cannot have virtual member functions in class templates,

* we want to use `event` as a value, and not via pointers or references to a base class.

* it is C++, and despite support for virtual polymorphism, most C++ code bases (including the standard library) avoid it, because there are better alternatives.

Luckily, for every problem, there are multiple solutions. Here, you will use the *Pimpl Idiom* (Pointer to Implementation). *Pimpl* works like this: you have a class `my_class` that needs some private members:

```cpp
class my_class
{
public:
  int public_function() { private_function(); return private_data_; }
private:
  int private_data_{ 42 };
  void private_function() { private_data_++; }
};
```
And you really don't want `private_data_` and `private_function()` to be part of the publicly visible interface of `my_class`. So, you move **everything** into a separate class, called `my_class_impl`:

```cpp
class my_class_impl
{
public:
  int public_function() { private_function(); return private_data_; }
private:
  int private_data_{ 42 };
  void private_function() { private_data_++; }
};
```

Now, with all the functionality moved to `my_class_impl` it's time to change `my_class`. Since it no longer has any private members of its own, and its public functions have no implementation, it must use `my_class_impl` to do everything:

```cpp
class my_class
{
public:
  my_class() : impl_{ std::make_unique<my_class_impl>() } {}
  int public_function() { return impl_->public_function(); }
private:
  std::unique_ptr<my_class_impl> impl_;
};
```

Yes, just like that! Now, `my_class` keeps a pointer to an instance of `my_class_impl`, and forwards all calls to it. All the implementation details are now hidden in `my_class_impl`. All that's left in `my_class` is the public interface (public functions) and a pointer to the implementation (hence the name *Pimpl*).

There are many advantages to this design:

* `my_class` is now lightweight and its binary layout (size and ordering of data members) is stable*, because it only contains a single pointer.

* moving objects of `my_class` around is extremely cheap - it is just a pointer copy.

* changing the implementation of `my_class_impl` does not require recompilation of code that uses `my_class`.

Notice that in this design, `my_class` is just like an *interface* you learned about and `my_class_impl` is the *implementation* of this interface. You can have different implementations of `my_class_impl` and easily switch between them.

* Programmers, especially those working on system-level code care a lot about binary interfaces (ABIs) and their stability. If you change the binary layout of a class, things that rely on it will break. And they did multiple times in the past.

Naturally, the *Pimpl* as shown above does't always work out this smoothly. For instance, you may need to pass the pointer to the private implementation in the constructor of `my_class`, instead of default-constructing it:

```cpp
class my_class
{
public:
  my_class(std::unique_ptr<my_class_impl> impl) : impl_{ std::move(impl) } {}
  int public_function() { return impl_->public_function(); }
private:
  std::unique_ptr<my_class_impl> impl_;
};

/* Usage */

auto impl = std::make_unique<my_class_impl>();
my_class obj{ std::move(impl) };
```

But the gist stays the same, the implementation details are hidden behind a pointer.

## Back to `event`

The idea is to move all the implementation details of `event` into a separate class template, called `event_impl`, and have `event` hold a pointer to an instance of that class. Do it, assuming that the `event`  and `event_impl` have the following definitions:

```cpp

// forward declaration of event_impl
// it's needed here because event_impl is used in event
template <typename...>
class event_impl;

template <typename...Args>
class event
{
public:
  using handle_t = std::size_t;
  using observer_t = std::function<void(Args...)>;

  event();

  handle_t operator+=( observer_t const& obs );
  handle_t operator+=( observer_t && obs );
  std::optional<observer_t> operator-=(handle_t handle);

  // there is no event triggering mechanism here
private:  
  std::unique_ptr<event_impl<Args...>>  impl_;
};

template <typename...Args>
class event_impl
{
public:
  using handle_t = typename event<Args...>::handle_t;
  using observer_t = typename event<Args...>::observer_t;

  handle_t add_observer( observer_t const& obs );
  handle_t add_observer( observer_t && obs );
  std::optional<observer_t> remove_observer(handle_t handle);
    
  void notify(Args... args);
private:  
  std::unordered_map<handle_t, observer_t> observers_;
  handle_t next_handle_{ 0 };
};
```

In summary:

* Both `event` and `event_impl` are class templates parameterized on the same variadic template parameter pack `Args...`.

* `event` is default-constructible, and creates its private member `impl_` in the constructor.

* `operator+=` functions return the handle (as before).

* `operator-=` returns an `std::optional<observer_t>`, which contains the removed observer if the handle was valid, or `std::nullopt` otherwise. This is different from the previous implementation, where `operator-=` returned `bool`. (Finally, there is a good [learncpp.com tutorial](https://www.learncpp.com/cpp-tutorial/stdoptional/)!)
  
* `event_impl` has the same functionality as the `event` class before the refactoring, but we renamed the functions to something more readable variants:
  
    * `add_observer()` instead of `operator+=`
    
    * `remove_observer()` instead of `operator-=`
    
    * `notify()` instead of `operator()`

If you've done everything correctly, you most likely also discovered the problem: there is no way to trigger the event now! After all, the `operator()` that notified all observers was part of the implementation details, and is now hidden in `event_impl` as `notify()`. It is `public` in `event_impl`, but we have no way to access it from outside `event`. So we can write a program:

```cpp
event<int> ev;
ev += [](int x) { std::cout << "Observer: " << x << '\n'; };

// No way to trigger the event here!
```

But `event` became useless...

## Triggering the event

We definitely don't want to add a `public` function like `trigger()` to `event`, because that would again expose the implementation. Even worse, it would allow others to trigger the event! Instead we will create an `event_impl` first and then pass it to `event`. This way, whoever creates the `event_impl` can trigger the event, but nobody else. Here's how it will look like in use:

```cpp
// create the implementation
event_impl<int> * ev_impl = new event_impl<int>();

// create the event, passing the implementation
event<int> ev{ ev_impl };

// add an observer
ev += [](int x) { std::cout << "Observer: " << x << '\n'; };

// trigger the event via the implementation
ev_impl->notify(42);
```

The working of this mechanism relies on a delicate ownership and lifetime balance. We create the `event_impl` on the heap, and pass a raw pointer to `event`. The `event` instance now *assumes ownership* of the `event_impl` via a `unique_ptr`. The user code that created the `event_impl` must not delete it, because that would lead to a double deletion when `event` is destroyed.

To implement this, you need to:

* Add a constructor to `event` that takes a raw pointer to `event_impl<Args...>` and assumes ownership of it via the `impl_` unique pointer.

* Remove the default constructor of `event`. We always want to create `event` with an existing `event_impl`.

If you've done it correctly, the following program should work:

```cpp
#include "event.hpp"
#include <iostream>

class Observed
{
public:
    Observed()
        : on_message_impl{ new event_impl<std::string const&>() }
        , on_message{ on_message_impl }
    {}

    void send_message(std::string const& msg)
    {
        on_message_impl->notify(msg);
    }

// Hopefully, you will notice the ugliness of this design that relies on intertwining private and public parts.
private:
    event_impl<std::string const&>  * on_message_impl;
public:
    event<std::string const&> on_message;
};

int main()
{
    Observed obj{};

    obj.on_message += [](std::string const& msg) {
        std::cout << "Received message: " << msg << '\n';
    };

    // Trigger the event via the implementation
    obj.send_message("Hello, World!");
}
``` 

Hopefully, you have noticed the ugliness of this design that relies on intertwining private and public parts. For every single event, we need to have both an `event_impl` pointer and an `event` instance. However, not only the implementation pointer must be in the private part of the class, while the `event` instance must be public, but also the implementation pointer must come before the `event` instance in the class definition, so that it is constructed first! That's not really programmer-friendly...

## Programmer-friendly design

We need to create both `event_impl` and `event` for every event we want to have. Moreover, we need to pass the `event_impl` pointer to the `event` somehow. Only... nobody said that it has to be done via the constructor of `event`! So let's try a different approach that, when implemented, will allow this:

```cpp
class Observed
{
public:
  Observed()
      // create the event first, without an implementation
     : on_message{ }
      // then create the implementation
     , on_message_impl{ new event_impl<std::string const&>() }
     {
        // finally, connect the implementation to the event
         on_message_impl->inject_to( on_message );
     }
    
    void send_message(std::string const& msg)
    {
        on_message_impl->notify(msg);
    }

    event<std::string const&> on_message;

private:
    event_impl<std::string const&> * on_message_impl;
};
```

Notice, that this time the `event` is created before its implementation (so it starts without a pointer to a private implementation). The `event` is then connected to its `event_impl` in the constructor of `Observed` by directly using the curiously looking `inject_to()` member function of `event_impl`:

```cpp
template <typename...Args>
class event_impl
{
public:
  // ...
  
  /// Inject this implementation into the given event.
  void inject_to( event<Args...> & ev )
  {
      // but how?
  }
};
```

But how? Well, that's for you to find out. **You cannot add any new member functions or data members to `event` or `event_impl` to do this (besides `inject_to()`)**. But perhaps you could ask a friend for help...?

## If it works...

Then the following program should compile and run correctly:

```cpp
#include "observers/events.hpp"
#include <iostream>

using namespace observers;

struct Observed
{
  event<std::string const&> got_string{};

  Observed()
    : got_string{}
    , got_string_impl_{ new event_impl<std::string const&>{} }
  {
    got_string_impl_->inject_to( got_string );
  }

  void trigger(std::string const& str)
  {
    got_string_impl_->notify( str );
  }

private:
    event_impl<std::string const&> * got_string_impl_;
};

int main()
{
  Observed obs{};

  auto handle = obs.got_string += [](auto&& str){ std::cout << "One: " << str << '\n'; };

  obs.got_string += [](auto&& str){ std::cout << "Two: " << str << '\n'; };
  
  obs.trigger("It works!");

  obs.got_string -= handle;

  obs.trigger("Really works!");
}
```
