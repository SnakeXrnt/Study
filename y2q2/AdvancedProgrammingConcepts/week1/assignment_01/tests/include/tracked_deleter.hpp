#ifndef INCLUDED_INCLUDE_TRACKED_DELETER_HPP
#define INCLUDED_INCLUDE_TRACKED_DELETER_HPP

#include <cstddef>
#include <type_traits>
#include <utility>
#include <string>
#include <vector>

namespace sax::testing
{

    struct DeleterStats
    {
        std::size_t id{0};
        std::size_t delete_calls{0};
        std::size_t delete_array_calls{0};
        bool default_constructed{false};
        bool copy_constructed{false};
        bool copy_constructed_from_compatible{false};

        bool operator==(const DeleterStats& other) const {return id == other.id;}
    };

    struct DeleterStatsRecorder
    {
        std::vector<DeleterStats> stats{};
        std::size_t next_id{0};

        DeleterStats& operator[](std::size_t id)
        {
            return stats.at(id);
        }

        DeleterStats* add_deleter()
        {
            stats.push_back(DeleterStats{next_id++});
            return &stats.back();
        }

        std::size_t size() const noexcept
        {
            return stats.size();
        }
    };

    inline DeleterStatsRecorder& deleterStatsRecorder()
    {
        static DeleterStatsRecorder tracker{};
        return tracker;
    }



    template <typename T>
    class TrackedDeleter
    {

    private:
        DeleterStats * my_stats{ deleterStatsRecorder().add_deleter() };
    public:
        using Type = T;
        using TypePure = std::remove_extent_t<T>;
        using Pointer = TypePure *;

        std::size_t id() const noexcept { return my_stats->id; }

        DeleterStats& stats() const noexcept { return *my_stats; }

        TrackedDeleter()
        {
            my_stats->default_constructed = true;
        }

        // enable conversion from TrackedDeleter<U> to TrackedDeleter<T> if U* is convertible to T*
        template <typename U>
            requires (!std::is_same_v<U, T> && std::is_convertible_v<U*, T*>)
        TrackedDeleter(const TrackedDeleter<U>&) noexcept 
        {
            my_stats->copy_constructed_from_compatible = true;
        }

        TrackedDeleter(const TrackedDeleter&) noexcept
        {
            my_stats->copy_constructed = true;
        }

        void operator()(Pointer ptr) const
        {
            if constexpr (std::is_array_v<T>)
            {
                ++my_stats->delete_array_calls;
                delete[] ptr;
            }
            else
            {
                ++my_stats->delete_calls;
                delete ptr;
            }
        }
    };
}

#endif /* INCLUDED_INCLUDE_TRACKED_DELETER_HPP */
