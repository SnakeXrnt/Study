# APC, Assignment 01

In this assignment you'll implement your own smart pointer, `UniquePtr<T>`, similar to `std::unique_ptr<T>`, but with a a possible twist.

> Your whole implementation should be in the `libptr/include/libptr/unique_ptr.h` file. When working with templates, you write all code in the header file itself.

## Requirements

Implement a class template `UniquePtr<T>` that manages a dynamically allocated object of type `T` with the following requirements:

1. **Ownership Semantics**: Your `UniquePtr<T>` should ensure that only one instance can own a dynamically allocated object at a time. This is done by implementing:

   * **Move Semantics**: Implement move constructor and move assignment operator to transfer ownership.

   * **No Copy Semantics**: Disable copy constructor and copy assignment operator.

2. **Resource Management**: Ensure proper resource management (*RAII*).

3. Provide the typical smart pointer interface:

    * default constructor and constructor from raw pointer.
    * `operator*` and `operator->` for dereferencing.
    * `get()` to access the raw pointer.
    * `release()` to release ownership of the pointer without deleting it.
    * `reset()` to replace the managed object.
    * `operator bool()` to check if the pointer is non-null.

4. Don't forget about `swap` functionality both as a member function and *a non-member function*. 

# UML diagram

In your implementation, follow the UML diagram below [(also in png format)](./img/UniquePtr.png)

```plaintext
,-------------------------------------------------------------------.
|**class** UniquePtr< T >                                           |
|-------------------------------------------------------------------|
|== private members ==                                              |
|- ptr: T *                                                         |
|== public members ==                                               |
|-- special members --                                              |
|+ UniquePtr( p: T * = nullptr )                                    |
|+ UniquePtr( other: UniquePtr&& ) <<noexcept>>                     |
|+ operator=( other: UniquePtr&& ) : UniquePtr& <<noexcept>>        |
|+ UniquePtr( other: UniquePtr const& )  <<deleted>>                |
|+ operator=( other: UniquePtr const& ) : UniquePtr& <<deleted>>    |
|+ ~UniquePtr() <<noexcept>>                                        |
|-- modifiers --                                                    |
|+ release() : T *                                                  |
|+ reset( p: T * = nullptr ) : void                                 |
|+ swap( other: UniquePtr& ) : void                                 |
|-- observers --                                                    |
|+ get() : T * <<const>>                                            |
|+ operator bool() : bool <<const>>                                 |
|-- pointer-like operators --                                       |
|+ operator*() : T & <<const>>                                      |
|+ operator->() : T * <<const>>                                     |
`-------------------------------------------------------------------'
```

## Testing

There are two target in this project:
1. *assignment_01*, with `main()` in `main.cpp`. Use it and modify to your liking during the development to test partial functionality.
2. *tests_unique*, implemented in `tests/tests_unique.cpp`, with throughout tests for your `UniquePtr<T>`. This target won't compile unless you have implemented `UniquePtr<T>`. 

Comment out some test suites if you want to focus on specific functionality or don't have the full implementation yet.

You can also enable the grader in the `tests/tests_unique.cpp` or enable deleters tests.

## Implementation Details

- Start with a basic class definition for `UniquePtr<T>`:

    ```cpp
    template <typename T>
    class UniquePtr {
    public:
        // Constructors, destructor, and assignment operators
        UniquePtr(T* ptr = nullptr);
        ~UniquePtr() noexcept;
  
        void swap(UniquePtr& other) noexcept;
    
    private:
        T* ptr_;
    };
    
    // Non-member swap function
    template <typename T>
    void swap(UniquePtr<T>& lhs, UniquePtr<T>& rhs) noexcept;
    ```
- Implement the required constructors, assignment operators, and destructor.
- Test your implementation with the provided tests.
- Implement the rest.

## Scoring:

### Standard scoring

| **Functionality**        | **Max points** |
|--------------------------|:--------------:|
| Special member functions |        4.5     |
| Modifiers                |        3.5     |
| Observers                |        1.5     |
| Pointer-like functions   |        1.0     |
| Swap functions           |        0.5     |

## Extra-effort credits

If you are not satisfied with a score of 11/15, consider the following extra-effort tasks to earn additional points:

1. **Custom Deleters**: Extend `UniquePtr<T>` to accept custom deleters, allowing users to specify how the managed object should be deleted. With a custom deleter, your UniquePtr will be able to manage other resource types, such as `FILE*` handles, as in:

    ```cpp
    auto filePtr = UniquePtr<FILE, decltype(&fclose)>(fopen("file.txt", "r"), &fclose);
    ```

    or:

    ```cpp
    struct FileDeleter {
        void operator()(FILE* file) const {
            if (file) fclose(file);
        }
    };
    auto filePtr = UniquePtr<FILE, FileDeleter>(fopen("file.txt", "r"));
    ```

2. **ObserverPtr**: Implement an `ObserverPtr<T>` class that provides a non-owning view of the managed object in `UniquePtr<T>`. This pointer should not manage the lifetime of the object but should allow safe access to it. Ensure that `ObserverPtr<T>` can only be created from a `UniquePtr<T>` instance, enforcing this at compile-time.

    Example usage:

    ```cpp
    void consume(ObserverPtr<int> view);

    UniquePtr<int> ptr{new int{42}};
    consume(ptr.observer());     // OK
    consume({ptr.get()});        // Compile-time fail, cannot be constructed without UniquePtr
    ```

### Custom deleter

A custom deleter requires one more template parameter:

```cpp
template <typename T, typename Deleter = std::default_delete<T>>
class UniquePtr;
```

* You'll need to store an instance of `Deleter` in your `UniquePtr` and use it in the destructor and `reset` method.

* You will have to add constructors that accept an extra `Deleter` parameter both by copy and by move.

* Some other functions will also need to be updated, assigning, swapping, resetting will all need to take the deleter into account. (It's not difficult but also requires some attention.)

* The `Deleter` is expected to be called with a pointer to `T` when the `UniquePtr` is destroyed or reset.

> If you have real trouble with assigning, swapping and resetting, ask or skip those parts.

For the curious, the `std::default_delete<T>` looks something like this:

```cpp
template <typename T>
struct default_delete {
    void operator()(T* ptr) const {
        delete ptr;
    }
};
```

The functionality of custom deleters can be tested with the provided tests by setting the `ENABLE_DELETER_TESTS` macro in the test runner.

### ObserverPtr

> **Implement `sax::ObserverPtr<T>` in the `libptr/observer_ptr.h` file.**

The idea behind an `ObserverPtr<T>` is to provide a safe, non-owning view of the object managed by `UniquePtr<T>`. The standard library [`std::weak_ptr`](https://en.cppreference.com/w/cpp/memory/weak_ptr) provides similar functionality for `std::shared_ptr`, but there is none for the `std::unique_ptr<T>`.

Your `ObserverPtr<T>` should:

* Be constructible only from a `UniquePtr<T>` instance.

* Provide access to the object managed by the *parent* `UniquePtr<T>` via `operator*` and `operator->` but only if the `UniquePtr<T>` is still valid (i.e., has not been destroyed or reset).
 
* If the `UniquePtr<T>` is destroyed or reset, the `ObserverPtr<T>` should not allow access to the object anymore and throw a (preferably custom) exception or assert in debug mode.

* Provide a way to check if the observed object is still valid (`operator bool()` and convenience methods like `expired()`).

* Don't care about multithreading or atomic operations for this assignment. Also don't go into complexities like `lock()` methods - they are not needed for a single-threaded observer pointer.

Implementing this functionality is not difficult but requires extra reading, perhaps start with understanding how [`std::shared_ptr` is implemented](https://andreasfertig.com/blog/2024/09/understanding-the-inner-workings-of-cpp-smart-pointers-the-shared_ptr/). The key concept is the use of a control block that keeps track of the validity of the `UniquePtr<T>` and the number of `ObserverPtr<T>` instances pointing to the same object (you don't need to track the number of `UniquePtr<T>` instances since there can only be one).

The simplified UML diagram for `ObserverPtr<T>` could look like this:

```plaintext
,-----------------------------------------------------.
|**class** ObserverPtr< T >                           |
|-----------------------------------------------------|
|== private members ==                                |
|- observed: ctrl_block<T> *                          |
|== public members ==                                 |
|-- special members --                                |
|+ ObserverPtr( owner: UniquePtr<T>& )                |
|+ ~ObserverPtr()                                     |
|-- observers --                                      |
|+ get() : T * <<const>>                              |
|+ operator bool() : bool <<const>>                   |
|+ expired() : bool <<const>>                         |
|-- pointer-like operators --                         |
|+ operator*() : T & <<const>>                        |
|+ operator->() : T * <<const>>                       |
`------------------------------------------------------'
```

### Scoring of extra-effort tasks

| **Functionality**        | **Max points** |
|--------------------------|:--------------:|
| Custom Deleters          |        3.0     |
| ObserverPtr              |        4.5     |

(This doesn't sum up to 15, but faithfully represents the effort. Even if you do everything, the maximum score you can get is 15/15.)

## Submission Guidelines

Submit just two files (no zip files):
1. `libptr/unique_ptr.h`
2. A pdf or html document that's generated from the `libptr/unique_ptr.h` file.

If you did the ObserverPtr extra-effort task, also submit:

1. `libptr/observer_ptr.h`
2. A pdf or html document that's generated from the `libptr/observer_ptr.h` file.