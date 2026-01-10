#ifndef INCLUDED_INCLUDE_HELPERS_HPP
#define INCLUDED_INCLUDE_HELPERS_HPP

#include "observers/events.hpp"

namespace observers::testing
{

    template <typename...Args>
    struct observed
    {
        event<observed, Args...> got_data;

        void trigger(Args... args)
        {
            got_data(args...);
        }
    };

    template <typename TEvent>
    struct observer: public iobserver<TEvent>
    {
        void notify(TEvent) noexcept override
        {
            ++call_count;
        }

        int call_count{ 0 };
    };

    template <typename...Args>
    struct event_callback
    { 
        void operator()(Args...) 
        {
            call_count++;
        }
        int call_count{ 0 };
    };

    template <typename...Args>
    struct func_callback
    {
        func_callback(std::function<void(Args...)> f) 
        : func{ std::move(f) } {}

        void operator()(Args... args)
        {
            func(args...);
            ++call_count;
        }

        int call_count{ 0 };
        std::function<void(Args...)> func;
    };


}

#endif /* INCLUDED_INCLUDE_HELPERS_HPP */
