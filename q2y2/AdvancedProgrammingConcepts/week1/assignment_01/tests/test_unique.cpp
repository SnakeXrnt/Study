#define DOCTEST_CONFIG_IMPLEMENT
#include "doctest.h"
#include "libptr/unique_ptr.hpp"
#include "tracked_deleter.hpp"
#include "tracked_object.hpp"
#include "scope_guard.hpp"
#include "grader.hpp"

// You can enable scoring to get an approximate grade when running the tests
constexpr auto ENABLE_GRADER{ true };

#define ENABLE_DELETER_TESTS  (true)

struct Scores: public sax::testing::ScoresBase {
    Scores() 
    : sax::testing::ScoresBase{
        /* Special members */
        {"Default constructor", 0.5f},
        {"Construction from raw pointer", 1.0f},
        {"Move constructor", 1.5f},
        {"Move assignment", 1.5f},

        /* Modifiers */
        {"Releasing managed object", 1.0f},
        {"Resetting UniquePtr", 1.0f},
        {"Release reset between two pointers", 1.5f},

        /* Observers */
        {"Accessing raw pointer", 0.5f},
        {"Boolean conversion", 1.0f},

        /* Pointer-like functions */
        {"Dereference and member access operators", 1.0f},

        {"Swapping UniquePtrs", 0.5f},
        
#if ENABLE_DELETER_TESTS
        {"Default constructor with custom deleter", 0.5f},
        {"Destruction with custom deleter", 0.5f},
        {"Destruction with custom deleter in reset", 0.5f},
        {"Destruction with lambda deleter of a tracked object", 1.5f}
#endif
    }
    {}
};

int main(int argc, char** argv) {
    doctest::Context context{};

    if constexpr (ENABLE_GRADER) {
        REGISTER_LISTENER("grader", 1, sax::testing::Grader<Scores>);
        context.setOption("reporters", "grader");           // use the custom grader
    }
    else
    {
        std::cout << "Grader disabled, running normal tests." << std::endl;
        std::cout << "You can enable the grader by setting the ENABLE_GRADER constant to true in the " __FILE__ " file." << std::endl;
    }

    context.setOption("abort-after", 0);
    context.setOption("order-by", "file");

    context.applyCommandLine(argc, argv);

    return context.run(); // run

}


TEST_SUITE_BEGIN("UniquePtr default construction");

SCENARIO("Default constructor")
{
    GIVEN("A default constructed UniquePtr")
    {
        sax::UniquePtr<int> ptr;

        THEN("The pointer is null")
        {
            CHECK(ptr.get() == nullptr);
        }
    }

} // SCENARIO("Default construction")

SCENARIO("Construction from raw pointer")
{
    GIVEN("A UniquePtr constructed from a raw pointer to a std::string")
    {
        auto raw = new std::string{"Hello, World!"};
        sax::UniquePtr<std::string> ptr{ raw };

        THEN("The UniquePtr manages the correct address")
        {
            CHECK(ptr.get() != nullptr);
            CHECK(ptr.get() == raw);
        }

        AND_THEN("The string has the expected value")
        {
            CHECK(*ptr == "Hello, World!");
        }
    }
    GIVEN("A UniquePtr with constructed with a tracked oject")
    {
        using namespace std::string_literals;
        auto raw = new sax::testing::TrackedObject<std::string>{"Hello, World!"};

        auto obj_handle = raw->my_handle();

        sax::UniquePtr<sax::testing::TrackedObject<std::string>> ptr{ raw };


        THEN("The UniquePtr is not null")
        {
            CHECK(ptr.get() != nullptr);
        }

        AND_THEN("The tracked object has the expected value")
        {
            CHECK((std::string&)*ptr == "Hello, World!"s);
        }

        AND_THEN("The tracked object's construction was recorded")
        {
            auto& stats = sax::testing::objectStatsRecorder()[obj_handle];
            CHECK(stats.value_constructions == 1);
            CHECK(stats.last_operation == sax::testing::LastOperation::ValueConstructed);
        }

        AND_THEN("The tracked object's destructor has not been called yet")
        {
            auto& stats = sax::testing::objectStatsRecorder()[obj_handle];
            CHECK(stats.destructions == 0);
            CHECK(stats.last_operation != sax::testing::LastOperation::Destructed);
        }
    }

} // SCENARIO("Construction from raw pointer")


SCENARIO("Accessing raw pointer")
{
    GIVEN("A UniquePtr managing a std::string")
    {
        auto raw = new std::string{"Hello, World!"};
        sax::UniquePtr<std::string> ptr{ raw };

        THEN("Getting the raw pointer yields the correct address")
        {
            CHECK(ptr.get() != nullptr);
            CHECK(ptr.get() == raw);
        }

        AND_THEN("Dereferencing yields the correct value")
        {
            CHECK(*ptr.get() == "Hello, World!");
        }
    }
}

SCENARIO("Move constructor")
{
    GIVEN("A UniquePtr managing a std::string")
    {
        auto raw = new std::string{"Hello, World!"};
        sax::UniquePtr<std::string> ptr1{ raw };

        WHEN("We move construct a second UniquePtr from the first")
        {
            sax::UniquePtr<std::string> ptr2{ std::move(ptr1) };

            THEN("The second UniquePtr now manages the string")
            {
                CHECK(ptr2.get() != nullptr);
                CHECK(ptr2.get() == raw);
            }

            AND_THEN("The string has the expected value")
            {
                CHECK(*ptr2 == "Hello, World!");
            }

            AND_THEN("The first UniquePtr is now null")
            {
                CHECK(ptr1.get() == nullptr);
            }
        }
    }
} // SCENARIO("Move construction")

SCENARIO("Move assignment")
{
    GIVEN("Two UniquePtr instances, one default constructed and one managing a std::string")
    {
        auto raw = new std::string{"Hello, World!"};
        sax::UniquePtr<std::string> ptr1;
        sax::UniquePtr<std::string> ptr2{ raw };

        WHEN("We move assign the second UniquePtr to the first")
        {
            ptr1 = std::move(ptr2);

            THEN("The first UniquePtr now manages the string")
            {
                CHECK(ptr1.get() != nullptr);
                CHECK(ptr1.get() == raw);
            }

            AND_THEN("The string has the expected value")
            {
                CHECK(*ptr1 == "Hello, World!");
            }

            AND_THEN("The second UniquePtr is now null")
            {
                CHECK(ptr2.get() == nullptr);
            }
        }
    }

    GIVEN("Two UniquePtrs that both manage a tracked object")
    {
        using namespace std::string_literals;

        auto raw1 = new sax::testing::TrackedObject<std::string>{"Hello, World!"};
        auto raw2 = new sax::testing::TrackedObject<std::string>{"Hello, C++!"};
        
        auto first_obj_handle = raw1->my_handle();
        auto second_obj_handle = raw2->my_handle();

        sax::UniquePtr<sax::testing::TrackedObject<std::string>> ptr1{ raw1 };
        sax::UniquePtr<sax::testing::TrackedObject<std::string>> ptr2{ raw2 };

        WHEN("We move assign the second UniquePtr to the first")
        {

            auto second_raw = ptr2.get();

            ptr1 = std::move(ptr2);

            THEN("The first UniquePtr now manages the second object's resource")
            {
                CHECK(ptr1.get() != nullptr);
                CHECK((std::string&)*ptr1 == "Hello, C++!"s);
                CHECK(ptr1.get() == second_raw);
            }

            AND_THEN("The second UniquePtr is now null")
            {
                CHECK(ptr2.get() == nullptr);
            }

            AND_THEN("The first managed object's destructor was called")
            {
                auto& stats1 = sax::testing::objectStatsRecorder()[first_obj_handle];
                CHECK(stats1.destructions == 1);
                CHECK(stats1.last_operation == sax::testing::LastOperation::Destructed);
            }

            AND_THEN("The second managed object's destructor was not called yet")
            {
                auto& stats2 = sax::testing::objectStatsRecorder()[second_obj_handle];
                CHECK(stats2.destructions == 0);
                CHECK(stats2.last_operation != sax::testing::LastOperation::Destructed);
            }
        }
    }
}

SCENARIO("Swapping UniquePtrs")
{
    GIVEN("Two UniquePtr instances managing different std::string objects")
    {
        auto raw1 = new std::string{"Hello, World!"};
        auto raw2 = new std::string{"Hello, C++!"};

        sax::UniquePtr<std::string> ptr1{ raw1 };
        sax::UniquePtr<std::string> ptr2{ raw2 };

        WHEN("We swap the two UniquePtr instances")
        {
            ptr1.swap(ptr2);

            THEN("The first UniquePtr now manages the second string")
            {
                CHECK(ptr1.get() != nullptr);
                CHECK(ptr1.get() == raw2);
                CHECK(*ptr1 == "Hello, C++!");
            }

            AND_THEN("The second UniquePtr now manages the first string")
            {
                CHECK(ptr2.get() != nullptr);
                CHECK(ptr2.get() == raw1);
                CHECK(*ptr2 == "Hello, World!");
            }
        }
    }
    GIVEN("Two UniquePtr instances, only one managing an object")
    {
        auto raw = new std::string{"Hello, World!"};

        sax::UniquePtr<std::string> ptr1{ raw };
        sax::UniquePtr<std::string> ptr2;

        WHEN("We swap the two UniquePtr instances")
        {
            ptr1.swap(ptr2);

            THEN("The first UniquePtr is now null")
            {
                CHECK(ptr1.get() == nullptr);
            }

            AND_THEN("The second UniquePtr now manages the string")
            {
                CHECK(ptr2.get() != nullptr);
                CHECK(ptr2.get() == raw);
                CHECK(*ptr2 == "Hello, World!");
            }
        }
    }
} // SCENARIO("Swapping UniquePtrs")

SCENARIO("Releasing managed object")
{
    GIVEN("A UniquePtr managing a std::string")
    {
        auto raw = new std::string{"Hello, World!"};
        sax::UniquePtr<std::string> ptr{ raw };


        WHEN("We release the managed object")
        {
            auto released_ptr = ptr.release();

            THEN("The UniquePtr is now null")
            {   
                CHECK(ptr.get() == nullptr);

                AND_THEN("The released pointer points to the original object")
                {
                    CHECK(released_ptr == raw);
                    CHECK(*released_ptr == "Hello, World!");

                    AND_THEN("We can manually delete the released object")
                    {
                        delete released_ptr; // prevent memory leak
                    }
                }
            }
        }
    }


    GIVEN("A UniquePtr managing a tracked object")
    {
        using namespace std::string_literals;
        auto raw = new sax::testing::TrackedObject<std::string>{"Hello, World!"};

        auto obj_handle = raw->my_handle();

        sax::testing::ScopeGuard cleanup{[raw] { 
            delete raw;
        }};

        sax::UniquePtr<sax::testing::TrackedObject<std::string>> ptr{ raw };

        WHEN("We release the managed object")
        {
            auto released_ptr = ptr.release();

            THEN("The UniquePtr is now null")
            {
                CHECK(ptr.get() == nullptr);
            }

            AND_THEN("The released pointer points to the original object")
            {
                CHECK(released_ptr == raw);
                CHECK((std::string const&)*released_ptr == "Hello, World!"s);
            }

            AND_THEN("The tracked object's destructor has not been called yet")
            {
                auto& stats = sax::testing::objectStatsRecorder()[obj_handle];
                CHECK(stats.destructions == 0);
                CHECK(stats.last_operation != sax::testing::LastOperation::Destructed);
            }

            AND_THEN("We can manually delete the released object")
            {
                delete released_ptr; // prevent memory leak
                cleanup.release();

                auto& stats = sax::testing::objectStatsRecorder()[obj_handle];
                CHECK(stats.destructions == 1);
                CHECK(stats.last_operation == sax::testing::LastOperation::Destructed);
            }
        }
    }
} // SCENARIO("Releasing managed object")

SCENARIO("Resetting UniquePtr")
{
    GIVEN("A UniquePtr managing a std::string")
    {
        auto raw = new std::string{"Hello, World!"};
        sax::UniquePtr<std::string> ptr{ raw };

        WHEN("We reset the UniquePtr")
        {
            ptr.reset();

            THEN("The UniquePtr is now null")
            {
                CHECK(ptr.get() == nullptr);
            }
        }
    }

    GIVEN("A UniquePtr managing a tracked object")
    {
        using namespace std::string_literals;
        auto raw = new sax::testing::TrackedObject<std::string>{"Hello, World!"};

        auto obj_handle = raw->my_handle();

        sax::UniquePtr<sax::testing::TrackedObject<std::string>> ptr{ raw };

        WHEN("We reset the UniquePtr")
        {
            ptr.reset();

            THEN("The UniquePtr is now null")
            {
                CHECK(ptr.get() == nullptr);
            }

            AND_THEN("The tracked object's destructor was called")
            {
                auto& stats = sax::testing::objectStatsRecorder()[obj_handle];
                CHECK(stats.destructions == 1);
                CHECK(stats.last_operation == sax::testing::LastOperation::Destructed);
            }
        }
    }

    GIVEN("A UniquePtr managing a std::string")
    {
        auto raw1 = new std::string{"Hello, World!"};
        sax::UniquePtr<std::string> ptr{ raw1 };

        WHEN("We reset the UniquePtr to manage a new std::string")
        {
            auto raw2 = new std::string{"Hello, C++!"};
            ptr.reset(raw2);

            THEN("The UniquePtr now manages the new string")
            {
                CHECK(ptr.get() != nullptr);
                CHECK(ptr.get() == raw2);
                CHECK(*ptr == "Hello, C++!");
            }
        }
    }

    GIVEN("A UniquePtr managing a tracked object")
    {
        using namespace std::string_literals;
        auto raw1 = new sax::testing::TrackedObject<std::string>{"Hello, World!"};

        auto first_obj_handle = raw1->my_handle();

        sax::UniquePtr<sax::testing::TrackedObject<std::string>> ptr{ raw1 };

        WHEN("We reset the UniquePtr to manage a new tracked object")
        {
            auto raw2 = new sax::testing::TrackedObject<std::string>{"Hello, C++!"};
            auto second_obj_handle = raw2->my_handle();

            ptr.reset(raw2);

            THEN("The UniquePtr now manages the new tracked object")
            {
                CHECK(ptr.get() != nullptr);
                CHECK((std::string const&)*ptr == "Hello, C++!"s);
            }

            AND_THEN("The first managed object's destructor was called")
            {
                auto& stats1 = sax::testing::objectStatsRecorder()[first_obj_handle];
                CHECK(stats1.destructions == 1);
                CHECK(stats1.last_operation == sax::testing::LastOperation::Destructed);
            }

            AND_THEN("The second managed object's destructor has not been called yet")
            {
                auto& stats2 = sax::testing::objectStatsRecorder()[second_obj_handle];
                CHECK(stats2.destructions == 0);
                CHECK(stats2.last_operation != sax::testing::LastOperation::Destructed);
            }
        }
    }
} // SCENARIO("Resetting UniquePtr")

SCENARIO("Release reset between two pointers")
{
    GIVEN("A UniquePtr managing a std::string")
    {
        auto raw1 = new std::string{"Hello, World!"};
        sax::UniquePtr<std::string> ptr1{ raw1 };

        WHEN("We release the managed object and reset another UniquePtr with it")
        {
            sax::UniquePtr<std::string> ptr2;
            ptr2.reset( ptr1.release() );

            THEN("The first UniquePtr is now null")
            {
                CHECK(ptr1.get() == nullptr);
            }

            AND_THEN("The second UniquePtr now manages the string")
            {
                CHECK(ptr2.get() != nullptr);
                CHECK(ptr2.get() == raw1);
                CHECK(*ptr2 == "Hello, World!");
            }
        }
    }
} // SCENARIO("Release reset between two pointers")

SCENARIO("Boolean conversion")
{
    GIVEN("A default constructed UniquePtr")
    {
        sax::UniquePtr<int> ptr;

        THEN("The UniquePtr evaluates to false")
        {
            CHECK( !static_cast<bool>(ptr) );
        }
    }

    GIVEN("A UniquePtr managing a std::string")
    {
        auto raw = new std::string{"Hello, World!"};
        sax::UniquePtr<std::string> ptr{ raw };

        THEN("The UniquePtr evaluates to true")
        {
            CHECK( static_cast<bool>(ptr) );
        }
    }
    GIVEN("A UniquePtr that has been reset")
    {
        auto ptr = sax::UniquePtr<std::string>{ new std::string{"Hello, World!"} };
        ptr.reset();

        THEN("The UniquePtr evaluates to false")
        {
            CHECK( !static_cast<bool>(ptr) );
        }
    }

} // SCENARIO("Boolean conversion")

SCENARIO("Dereference and member access operators")
{
    GIVEN("A UniquePtr managing a std::string")
    {
        auto raw = new std::string{"Hello, World!"};
        sax::UniquePtr<std::string> ptr{ raw };

        THEN("The dereference operator yields the correct value")
        {
            CHECK(*ptr == "Hello, World!");
        }

        AND_THEN("The member access operator works correctly")
        {
            CHECK(ptr->size() == 13);
            ptr->append(" C++");
            CHECK(*ptr == "Hello, World! C++");
        }
    }
} // SCENARIO("Dereference and member access operators")


TEST_SUITE_END();

#if ENABLE_DELETER_TESTS
TEST_SUITE_BEGIN("UniquePtr with custom deleter");

SCENARIO("Default constructor with custom deleter")
{
    GIVEN("A UniquePtr with a tracked deleter, default constructed")
    {
        sax::UniquePtr<std::string, sax::testing::TrackedDeleter<std::string>> ptr{ };

        auto deleter_handle = ptr.get_deleter().id();

        THEN("The UniquePtr is null")
        {
            CHECK(ptr.get() == nullptr);
        }

        AND_THEN("The deleter has not been called yet")
        {
            CHECK(sax::testing::deleterStatsRecorder()[deleter_handle].delete_calls == 0);
        }
    }
} // SCENARIO("Default constructor with custom deleter")

SCENARIO("Destruction with custom deleter")
{
    GIVEN("A UniquePtr managing a std::string with a tracked deleter")
    {

        using handle_type = decltype(sax::testing::deleterStatsRecorder().add_deleter()->id);
        handle_type deleter_handle{};
        
        { //scope to trigger destruction
            auto raw = new std::string{"Hello, World!"};
            sax::UniquePtr<std::string, sax::testing::TrackedDeleter<std::string>> ptr{ raw };
            deleter_handle = ptr.get_deleter().id();
        }
        
        THEN("The deleter's delete call was recorded")
        {
            CHECK(sax::testing::deleterStatsRecorder()[deleter_handle].delete_calls == 1);
        }
    }
}

SCENARIO("Destruction with custom deleter in reset")
{
    GIVEN("A UniquePtr managing a std::string with a tracked deleter")
    {

        using handle_type = decltype(sax::testing::deleterStatsRecorder().add_deleter()->id);
        handle_type deleter_handle{};
        
        WHEN("We reset the UniquePtr")
        {
            auto raw = new std::string{"Hello, World!"};
            sax::UniquePtr<std::string, sax::testing::TrackedDeleter<std::string>> ptr{ raw };
            deleter_handle = ptr.get_deleter().id();

            ptr.reset();

            THEN("The deleter's delete call was recorded for the reset")
            {
                CHECK(sax::testing::deleterStatsRecorder()[deleter_handle].delete_calls == 1);
            }
        }
        

    }
}

SCENARIO("Destruction with lambda deleter of a tracked object")
{
    GIVEN("A UniquePtr managing a tracked object with a lambda deleter")
    {
        using namespace std::string_literals;
        auto raw = new sax::testing::TrackedObject<std::string>{"Hello, World!"};

        auto obj_handle = raw->my_handle();

        auto was_triggered{ false };
        auto deleter = [&was_triggered](sax::testing::TrackedObject<std::string>* ptr) {
            was_triggered = true;
            delete ptr;
        };

        WHEN("The UniquePtr is created and goes out of scope")
        {
            {
                sax::UniquePtr<sax::testing::TrackedObject<std::string>, decltype(deleter)> ptr{ raw, std::move(deleter) };
            }
            
            THEN("The deleter was triggered")
            {
                CHECK(was_triggered == true);
            }
            AND_THEN("The tracked object's destructor was called")
            {
                auto& stats = sax::testing::objectStatsRecorder()[obj_handle];
                CHECK(stats.destructions == 1);
                CHECK(stats.last_operation == sax::testing::LastOperation::Destructed);
            }
        } // scope ends here


        
    }
}



TEST_SUITE_END();
#endif
