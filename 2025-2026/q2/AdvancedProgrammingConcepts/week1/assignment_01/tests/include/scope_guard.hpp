#ifndef INCLUDED_INCLUDE_SCOPE_GUARD_HPP
#define INCLUDED_INCLUDE_SCOPE_GUARD_HPP

#include <tuple>

namespace sax::testing
{
    template <typename...>
    class ScopeGuard;
    
    // specialization for just a single callable
    template <typename Callable>
    class ScopeGuard<Callable>
    {
        [[no_unique_address]]
        Callable callable_;
        bool active_{ false };

    public:

        template <typename C>
        explicit ScopeGuard(C&& c) noexcept
            : callable_{ std::forward<C>(c) }
            , active_{ true }
        {}

        ~ScopeGuard() noexcept
        {
            if (active_) {
                callable_();
            }
        }

        // disable copy & move
        ScopeGuard(const ScopeGuard&) = delete;
        ScopeGuard& operator=(const ScopeGuard&) = delete;
        ScopeGuard(ScopeGuard&&) = delete;
        ScopeGuard& operator=(ScopeGuard&&) = delete;

        void release() noexcept
        {
            active_ = false;
        }

        operator bool() const noexcept
        {
            return active_;
        }

        [[nodiscard]] Callable& get_callable() noexcept
        {
            return callable_;
        }

        [[nodiscard]] const Callable& get_callable() const noexcept
        {
            return callable_;
        }
    };

    // specialization for a callable + additional args
    template <typename Callable, typename... Args>
    class ScopeGuard<Callable, Args...>
    {
        [[no_unique_address]]
        Callable callable_;
        std::tuple<Args...> args_;
        bool active_{ false };

    public:
        template <typename C, typename... A>
        explicit ScopeGuard(C&& c, A&&... args) noexcept
            : callable_{ std::forward<C>(c) }
            , args_{ std::make_tuple(std::forward<A>(args)... ) }
            , active_{ true }
        {}

        ~ScopeGuard() noexcept
        {
            if (active_) {
                std::apply(callable_, args_);
            }
        }

        // disable copy & move
        ScopeGuard(const ScopeGuard&) = delete;
        ScopeGuard& operator=(const ScopeGuard&) = delete;
        ScopeGuard(ScopeGuard&&) = delete;
        ScopeGuard& operator=(ScopeGuard&&) = delete;

        void release() noexcept
        {
            active_ = false;
        }

        operator bool() const noexcept
        {
            return active_;
        }

        [[nodiscard]] Callable& get_callable() noexcept
        {
            return callable_;
        }

        [[nodiscard]] const Callable& get_callable() const noexcept
        {
            return callable_;
        }
    };
    
    template <typename...Ts>
    ScopeGuard(Ts...) -> ScopeGuard<std::decay_t<Ts>...>;

} // namespace sax::testing

#endif /* INCLUDED_INCLUDE_SCOPE_GUARD_HPP */
