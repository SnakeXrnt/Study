#ifndef INCLUDED_LIBPTR_DELETER_HPP
#define INCLUDED_LIBPTR_DELETER_HPP
#include <type_traits>


namespace sax
{
    /// @brief Default deleter for single objects
    /// @tparam T 
    template <typename T>
    struct DefaultDeleter
    {
        DefaultDeleter() noexcept = default;

        template<typename U>
            requires std::is_convertible_v<U*, T*>
        DefaultDeleter(const DefaultDeleter<U>&) noexcept {}

        void operator()(T* ptr) const
        {
            delete ptr;
        }
    };

    /// @brief Default deleter specialization for arrays
    /// @tparam T 
    template <typename T>
    struct DefaultDeleter<T[]>
    {
        DefaultDeleter() noexcept = default;

        template<typename U>
            requires std::is_convertible_v<U(*)[], T(*)[]>
        DefaultDeleter(const DefaultDeleter<U[]>&) noexcept {}

        void operator()(T* ptr) const
        {
            delete[] ptr;
        }
    };
}

#endif /* INCLUDED_LIBPTR_DELETER_HPP */

