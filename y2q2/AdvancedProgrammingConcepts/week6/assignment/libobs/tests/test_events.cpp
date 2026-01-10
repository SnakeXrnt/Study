#define DOCTEST_CONFIG_IMPLEMENT
#include "doctest.h"
#include "grader.hpp"
#include "helpers.hpp"

#include "observers/events.hpp"

// There's no automatic grader for this assignment
constexpr auto ENABLE_GRADER{ true };

// enable testing of the iobserver interface with a single argument event
#define ENABLE_OBSERVER_SINGLE_ARG (true)
// enable testing of the iobserver interface with a multiple arguments event
#define ENABLE_IOBSERVER_MULTIPLE_ARGS (true)

struct Scores: public sax::testing::ScoresBase {
    Scores() 
    : sax::testing::ScoresBase{
        // part where i change
        {"Callbacks with simple lambdas", 2.0f},
        {"Callbacks with lambda wrappers", 1.0f},
        {"Callbacks with bind", 1.0f},
        {"Callbacks with function objects", 1.0f},
        {"Callbacks with ref wrapper", 1.0f},
        {"Callbacks with observer interface - single argument", 2.0f},
        {"Callbacks with observer interface - multiple arguments", 3.0f}
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

TEST_SUITE_BEGIN("Adding event callbacks");

SCENARIO("Callbacks with simple lambdas")
{
    using namespace observers::testing;

    GIVEN("An observed object with an event")
    {
        observed<int, std::string const&> obs{};

        GIVEN("A function callback added to the event")
        {
            int call_count{ 0 };

            auto handle = obs.got_data += [&call_count](int, std::string const&){
                ++call_count;
            };

            WHEN("The event is triggered")
            {
                obs.trigger(42, "Hello");

                THEN("The callback is called")
                {
                    CHECK(call_count == 1);
                }

                AND_WHEN("The event is triggered again")
                {
                    obs.trigger(7, "World");

                    THEN("The callback is called again")
                    {
                        CHECK(call_count == 2);
                    }
                }
            }

            GIVEN("The callback is removed")
            {
                obs.got_data -= handle;

                WHEN("The event is triggered")
                {
                    obs.trigger(1, "Test");

                    THEN("The callback is not called")
                    {
                        CHECK(call_count == 0);
                    }
                }
            }
        }
    }
}

SCENARIO("Callbacks with lambda wrappers")
{
    using namespace observers::testing;

    GIVEN("An observed object with an event")
    {
        observed<int, std::string> obs{};

        GIVEN("A function callback added to the event")
        {
            event_callback<int, std::string> callback{};

            auto handle = obs.got_data += [&callback](int a, const std::string& b){
                callback(a, b);
            };

            WHEN("The event is triggered")
            {
                obs.trigger(42, "Hello");

                THEN("The callback is called")
                {
                    CHECK(callback.call_count == 1);
                }

                AND_WHEN("The event is triggered again")
                {
                    obs.trigger(7, "World");

                    THEN("The callback is called again")
                    {
                        CHECK(callback.call_count == 2);
                    }
                }
            }

            GIVEN("The callback is removed")
            {
                obs.got_data -= handle;

                WHEN("The event is triggered")
                {
                    obs.trigger(1, "Test");

                    THEN("The callback is not called")
                    {
                        CHECK(callback.call_count == 0);
                    }
                }
            }
        }
    }
}

SCENARIO("Callbacks with bind")
{
    using namespace observers::testing;
    using namespace std::placeholders;

    GIVEN("An observed object with an event")
    {
        observed<int, std::string> obs{};

        GIVEN("A function callback added to the event")
        {
            event_callback<int, std::string> callback{};

            auto handle = obs.got_data += std::bind(&decltype(callback)::operator(), &callback, _1, _2);

            WHEN("The event is triggered")
            {
                obs.trigger(42, "Hello");

                THEN("The callback is called")
                {
                    CHECK(callback.call_count == 1);
                }

                AND_WHEN("The event is triggered again")
                {
                    obs.trigger(7, "World");

                    THEN("The callback is called again")
                    {
                        CHECK(callback.call_count == 2);
                    }
                }
            }

            GIVEN("The callback is removed")
            {
                obs.got_data -= handle;

                WHEN("The event is triggered")
                {
                    obs.trigger(1, "Test");

                    THEN("The callback is not called")
                    {
                        CHECK(callback.call_count == 0);
                    }
                }
            }
        }
    }
}

SCENARIO("Callbacks with function objects")
{
    using namespace observers::testing;

    GIVEN("An observed object with an event")
    {
        observed<int, std::string> obs{};

        GIVEN("A function callback added to the event")
        {
            event_callback<int, std::string> callback{};

            struct FuncObj {
                event_callback<int, std::string>& cb;
                void operator()(int a, const std::string& b) {
                    cb(a, b);
                }
            };

            auto handle = obs.got_data += FuncObj{ callback };

            WHEN("The event is triggered")
            {
                obs.trigger(42, "Hello");

                THEN("The callback is called")
                {
                    CHECK(callback.call_count == 1);
                }

                AND_WHEN("The event is triggered again")
                {
                    obs.trigger(7, "World");

                    THEN("The callback is called again")
                    {
                        CHECK(callback.call_count == 2);
                    }
                }
            }

            GIVEN("The callback is removed")
            {
                obs.got_data -= handle;

                WHEN("The event is triggered")
                {
                    obs.trigger(1, "Test");

                    THEN("The callback is not called")
                    {
                        CHECK(callback.call_count == 0);
                    }
                }
            }
        }
    }
}

SCENARIO("Callbacks with ref wrapper")
{
    using namespace observers::testing;

    GIVEN("An observed object with an event")
    {
        observed<int, std::string> obs{};

        GIVEN("A function callback added to the event")
        {
            event_callback<int, std::string> callback{};

            auto handle = obs.got_data += std::ref(callback);

            WHEN("The event is triggered")
            {
                obs.trigger(42, "Hello");

                THEN("The callback is called")
                {
                    CHECK(callback.call_count == 1);
                }

                AND_WHEN("The event is triggered again")
                {
                    obs.trigger(7, "World");

                    THEN("The callback is called again")
                    {
                        CHECK(callback.call_count == 2);
                    }
                }
            }

            GIVEN("The callback is removed")
            {
                obs.got_data -= handle;

                WHEN("The event is triggered")
                {
                    obs.trigger(1, "Test");

                    THEN("The callback is not called")
                    {
                        CHECK(callback.call_count == 0);
                    }
                }
            }
        }
    }
}

#if defined(ENABLE_OBSERVER_SINGLE_ARG) && ENABLE_OBSERVER_SINGLE_ARG

SCENARIO("Callbacks with observer interface - single argument")
{
    using namespace observers::testing;

    struct EventArgs
    {
        int number;
        std::string text;
    };

    GIVEN("An observed object with an event")
    {
        observed<EventArgs const&> obs{};

        GIVEN("An observer added to the event")
        {
            observer<EventArgs const&> obsrv{};

            auto handle = obs.got_data += &obsrv;

            WHEN("The event is triggered")
            {
                obs.trigger({42, "Hello"});

                THEN("The observer is notified")
                {
                    CHECK(obsrv.call_count == 1);
                }

                AND_WHEN("The event is triggered again")
                {
                    obs.trigger({7, "World"});

                    THEN("The observer is notified again")
                    {
                        CHECK(obsrv.call_count == 2);
                    }
                }
            }

            GIVEN("The observer is removed")
            {
                obs.got_data -= handle;

                WHEN("The event is triggered")
                {
                    obs.trigger({1, "Test"});

                    THEN("The observer is not notified")
                    {
                        CHECK(obsrv.call_count == 0);
                    }
                }
            }
        }
    }
}

#endif

#if defined(ENABLE_IOBSERVER_MULTIPLE_ARGS) && ENABLE_IOBSERVER_MULTIPLE_ARGS

SCENARIO("Callbacks with observer interface - multiple arguments")
{
    using namespace observers::testing;

    GIVEN("An observed object with an event")
    {
        observed<int, std::string> obs{};

        struct EventArgs
        {
            int number;
            std::string text;
        };

        GIVEN("An observer added to the event")
        {
            observer<EventArgs const&> obsrv{};

            auto handle = obs.got_data += &obsrv;

            WHEN("The event is triggered")
            {
                obs.trigger(42, "Hello");

                THEN("The observer is notified")
                {
                    CHECK(obsrv.call_count == 1);
                }

                AND_WHEN("The event is triggered again")
                {
                    obs.trigger(7, "World");

                    THEN("The observer is notified again")
                    {
                        CHECK(obsrv.call_count == 2);
                    }
                }
            }

            GIVEN("The observer is removed")
            {
                obs.got_data -= handle;

                WHEN("The event is triggered")
                {
                    obs.trigger(1, "Test");

                    THEN("The observer is not notified")
                    {
                        CHECK(obsrv.call_count == 0);
                    }
                }
            }
        }
    }
}

#endif

TEST_SUITE_END();