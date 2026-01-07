# Advanced Programming Concepts, assignment 5

In this assignment you'll extend `logger_builder` and make the `runningtime_provider` singleton behave more predictably. You'll also pay a short visit to the *adapter* pattern and adapt the C `logger` once more.

## Grading

Doing all the mandatory tasks *correctly** will get you 11 points:

* Extending the [`logger_builder` class (4 points)](#extending-logger_builder-class-4-points)
* Supporting various [`timestamping decorators (3 points)](#supporting-various-timestamping-decorators-3-points)
* Making sure of [`when the program truly starts (1 point)](#when-does-the-program-truly-start-1-point)
* [`Adapting C logger once more (3 points)](#adapting-c-logger-once-more-3-points)

There are just one extra-effort task:

* [Concurrent logger decorator](./README_EXTRA.md) ( points)

## Extending `logger_builder` class (4 points)

The are two goals in this part:

* Adding support for *custom* writers to the `logger_builder`
* Supporting various timestamping methods and preventing multiple timestamping of a log message 

### Adding support for custom writers

Navigate to the *builder* directory in the project and take a look at the code there. `logger_builder`, as any other class in the project inherits from an abstract class (this time `ilogger_builder`). This allows for more flexibility and for providing additional *builder* implementations that will return alternative `ilogger` objects. **When you add methods to `logger_builder` make sure to first add them to `ilogger_builder`.**


`logger_builder` only supports addition of pre-defined writers (*console* and *stream*). This can be helped by adding a function that takes a pointer to `itext_writer` and adds it to the `logger` instance that's being built. This will allow users of `logger_builder` to customize loggers with any writers they want.

1. Add a *pure virtual* function to `ilogger_builder*` with the following signature:

    ```c++
    ilogger_builder& with_writer(std::unique_ptr<io::itext_writer> writer);
    ```

2. Add the implementation of this function to `logger_builder`. Remember to move the ownership of `std::unique_ptr` passed as an argument. 

3. You also need to come up with some name when adding a writer. You can use a random number generator to generate a number and convert it to `std::string` or, alternatively,  use the current running time, obtained from `runningtime_provider` for this purpose. In both cases you'll have to convert a number to a `std::string` to produce a name.

4. Test your implementation by creating `logger` with a custom `itext_writer` in the `main` function.


## Supporting various timestamping decorators (3 points)

`ilogger_builder` only supports decorating with `runningtime_decorator`. It's time to include the other decorator (current time) in the design. Instead of adding an extra function (`with_timestamp`) that mimics the one currently implemented, you'll provide just one function that can decorate `logger` with either *decorator*.

1. There will only be one function for both decorators. To discriminate between them, a user will need to pass an argument indicating which *decorator* they want. The most suited type for such a purpose is an `enum` type. In your `ilogger_builder` add an enumeration `timestamp_type` with three values: `none`, `current_time` and `running_time`:

    This enumeration should be nested in `ilogger_builder` and placed in its `public` section. Nested types are perfectly normal and fine in C++. Only users of `ilogger_builder` will be ever interested in `timestamp_type`, so the place for this `enum` is in there.

    Use so-called [*enum classes*](https://stackoverflow.com/questions/18335861/why-is-enum-class-preferred-over-plain-enum) instead of plain `enum`s. They are a bit safer.

2. Add a *pure virtual* function `with_timestamp` to `ilogger_builder` that takes `timestamp_type` as its argument:

    ```c++
    ilogger_builder& with_timestamp(timestamp_type type)
    ```

3. Override and implement `with_timestamp` in `logger_builder`. You'll have to handle all three cases (`none`, `current_time` and `running_time`). For the `none` case you shouldn't decorate `m_logger` at all. For the remaining two cases use the corresponding *decorator*s. 

4. Remove the now obsolete `with_runningtime_stamp` function from both `ilogger_builder` and `logger_builder`.

5. There's a slight issue that arose when you added support for multiple decorators. Now a user can decorate the same `logger` multiple times. (This was actually possible also in the previous implementation, just a bit less obvious.) Consequently, a `logger` object build with:

    ```c++
    auto log = builders::default_builder()
        .with_console_output()
        .with_file_output("out5.txt")
        .with_writer(std::make_unique<io::writers::stream_writer>("custom.txt"))
        .with_timestamp(builders::ilogger_builder::timestamp_type::current_time)
        .with_timestamp(builders::ilogger_builder::timestamp_type::running_time)
        .get();
    ```

    Will produce output similar to:

    ```text
    [10:15:01] [0.000117100] Starting
    ```

    This is not really desirable.

6. Prevent the possibility of adding multiple *decorator*s in the `logger_builder`. It's up to you how you do it. Also, decide what to do if a `logger` object is already decorated.


## When does the program truly start? (1 point)

The singleton instance of `runningtime_provider` is a local `static` variable defined in the `runningtime_provider::get_instance()` function:

```c++
const global::runningtime_provider& global::runningtime_provider::get_instance() {
    static runningtime_provider obj{};
    return obj;
}
```

As discussed in the lesson, local `static` variables have *static lifetime* - that is, they exist in the global section of the program's memory and persist for the whole program's duration. They are, however, initialized only at the moment when the *control flow* goes for the first time over the line of their definition. (Or, to put it simply, the first time they are used.) This creates a slight issue, the `obj` variable is not really initialized when the program starts but only some time after it, when it's first used. In our case this happens when the `program::program` constructor calls `ilogger::log` function, which in turn requests a message decoration with the current program's running time. That something is very wrong should be also obvious when looking at the log produced by the program. It might look like:

```
[0.000000100] Starting
[0.000077000] Running: 1
[0.000082800] Running: 2
[0.000084600] Running: 3
[0.000086000] Running: 4
[0.000087400] Running: 5
[0.000088800] Quitting
```

It's totally unrealistic that only 100 ns have passed since the program's start to the moment the first message was logged. 

### \[> Side note, if you are curious

If you are curious about the other seeming irregularities of the intervals:

```
[0.000000100] Starting      | 0.1 us
[0.000077000] Running: 1    | 76.9 us
[0.000082800] Running: 2    | 5.8 us
[0.000084600] Running: 3    | 1.8 us
[0.000086000] Running: 4    | 1.4 us
[0.000087400] Running: 5    | 1.4 us
[0.000088800] Quitting      | 1.4 us
```

The whooping 76.9 us is caused by two things:

* The message *Starting* is printed in the constructor of `program`. The running time of 100 ns is measured *before any output happens*. After this the first write to an output stream takes place. This likely setups some buffers or properly initializes streams and takes a lot of CPU cycles.

*  Next, after the `program`'s constructor finishes its work, the runtime needs to set-up a hook for calling the destructor of, now, a fully constructed `program` instance. This also takes some time.

* The constructor returns and `program::run` starts, this switch costs some extra, albeit not that much on a modern system.

The decreasing interval between consecutive loop's iterations (5.8 -> 1.8 -> 1.4 us) is likely caused by the microprocessor's [branch predictor](https://en.wikipedia.org/wiki/Branch_predictor) learning its lesson.

### End of the side note for the curious <\]

It's impossible to acquire the true starting time of a program. You can, however, do the second best thing - initialize `runningtime_provider::m_t0` before the `main` function starts executing. To do so, you'll need to create a global variable somewhere and use `runningtime_provider` in its initialization.

Global variables have *static lifetime* and, unlike local *static* variables, are initialized not when they are needed, but before the execution of the `main` program function starts. This is guaranteed. Be very careful when using this feature, because the order of initialization of global variables is nondeterministic. If there are two global variables and the initialization of one depends on the initialization of the other you might be up for a nasty surprise. This is known as the [*static initialization order fiasco*](https://en.cppreference.com/w/cpp/language/siof) and there are standard and [super very non-standard](https://clang.llvm.org/docs/AttributeReference.html#init-priority) ways of preventing it.


Back to the task at hand. Put a global *dummy* variable in your `runningtime_provider` source file and initialize it by calling `runningtime_provider::get_instance()`. This will ensure that the singleton instance is created before `main` starts executing. To prevent a compiler whining about an unused variable, you can mark it with a [`[[maybe_unused]]` attribute](https://en.cppreference.com/w/cpp/language/attributes/maybe_unused).

When you've finished making changes, check how the timing looks like. Most likely the intervals between the steps will be similar to those before the changes. However, instead of seeing nanoseconds next to the first message you'll now see milliseconds, which correctly represents the time between the initialization of global variables and the moment when the first log message is outputted.

## Adapting C `logger` once more (3 points)

*Adapter* is one of the most important patterns, to get more exposure and see how flexible it is, write an adapter for the C `logger` once more. This time, however, adapt it to the `itext_writer` interface! You've already done something similar once, so only a few tips this time (this assumes that you named your adapter class `clogger_as_writer`):

1. The overall design will be similar to `clogger_adapter`, you'll need a `private` member of type `lg_logger_t*`. Don't forget about initialization in the constructor and cleanup in the destructor.

2. You won't be able to implement `itext_writer::operator<<(io::flush_t)` properly. It doesn't matter. Provide an empty implementation.

3. When you are finished with adapting `lg_logger` as `clogger_as_writer`, add support for it in `logger_builder` under the name `with_rolling_log_with_interval(std::chrono::seconds)`.

## Finally

When you are ready, test your program in the `main` function, demonstrating its functionality and working of the new or refactored components.
