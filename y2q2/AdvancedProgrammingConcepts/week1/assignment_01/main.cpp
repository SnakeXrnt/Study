#include <print>
#include <memory>
#include <string>

#include "libptr/unique_ptr.hpp"

template <typename T>
void use_unique(std::unique_ptr<T> const& ptr)
{
    std::println("Inside use_unique with const& parameter, no ownership transfer!");
    if (ptr) {
        std::println("Using unique_ptr managing object at address: {}", static_cast<void*>(ptr.get()));
        std::println("Value: {}", *ptr);
    } else {
        std::println("unique_ptr is null.");
    }
}

template <typename T>
void use_unique(std::unique_ptr<T>&& ptr)
{
    std::unique_ptr<T> local_ptr = std::move(ptr); // take ownership

    std::println("Inside use_unique with rvalue reference parameter, ownership transferred!");
    if (local_ptr) {
        std::println("Using unique_ptr managing object at address: {}", static_cast<void*>(local_ptr.get()));
        std::println("Value: {}", *local_ptr);
    } else {
        std::println("unique_ptr is null.");
    }
}

int main()
{
    std::println("\nYour implementation of UniquePtr is in the libptr/include/libptr/unique_ptr.hpp file.");
    std::println("Run the tests in the tests/ folder to verify your implementation.");
    std::println("The test target is called tests_unique.");
    std::println("The tests are defined in the tests/test_unique.cpp file. But they won't compile until you have implemented UniquePtr.");
    std::println("\nYou can use this main function (located in: " __FILE__ ") to do some ad-hoc testing if you want.\n");
    std::println("For now, it just demonstrate the std::unique_ptr usage as a reference implementation.\n");

    {
        std::unique_ptr<std::string> ptr1{ new std::string{"Hello, World!"} };
        std::println("ptr1 points to: {}", *ptr1);

        auto ptr2 = std::move(ptr1);;
        std::println("After moving, ptr2 points to: {}", *ptr2);
        if (ptr1 == nullptr) {
            std::println("ptr1 is now null after being moved from.");
        }

        use_unique( ptr2 ); // by reference, now ownership transferred
        if (ptr2 != nullptr) {
            std::println("ptr2 is still usable, there was no move (ownership transfer).");
        }

        use_unique( std::move(ptr2) ); // by rvalue ref, ownership transferred
        if (ptr2 == nullptr) {
            std::println("ptr2 is now null after being moved from.");
        }
    }
    return 0;
}
