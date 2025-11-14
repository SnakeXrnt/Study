#ifndef INCLUDED_INCLUDE_TRACKED_OBJECT_HPP
#define INCLUDED_INCLUDE_TRACKED_OBJECT_HPP

#include <cstddef>
#include <type_traits>
#include <vector>
#include <utility>

namespace sax::testing
{

    enum struct LastOperation
    {
        None = 0,
        DefaultConstructed,
        ValueConstructed,
        CopyConstructed,
        MoveConstructed,
        CopyAssigned,
        MoveAssigned,
        Destructed
    };

    struct TrackedObjectStats
   {
        std::size_t id{0};
        LastOperation last_operation{LastOperation::None};
        std::size_t last_from_id{0};
        std::size_t default_constructions{0};
        std::size_t value_constructions{0};
        std::size_t copy_constructions{0};
        std::size_t move_constructions{0};
        std::size_t copy_assignments{0};
        std::size_t move_assignments{0};
        std::size_t destructions{0};
   };

   struct TrackedObjectStatsRecorder
    {
        std::vector<TrackedObjectStats> stats{};
        
        struct Handle
        {
            std::size_t id{0};
        };

        TrackedObjectStats& operator[](Handle handle)
        {
            return stats.at(handle.id);
        }

        Handle add_object()
        {
            auto next_id = stats.size();
            stats.push_back(TrackedObjectStats{ next_id});
            return Handle{ next_id };
        }

        std::size_t size() const noexcept
        {
            return stats.size();
        }
    };

    inline TrackedObjectStatsRecorder& objectStatsRecorder()
    {
        static TrackedObjectStatsRecorder instance{};
        return instance;
    }

    template <typename T = void *>
    class TrackedObject
    {
        T payload_;
        TrackedObjectStatsRecorder::Handle stats_handle;

    public:

        TrackedObjectStats& my_stats() noexcept
        {
            return objectStatsRecorder()[stats_handle];
        }

        TrackedObjectStatsRecorder::Handle my_handle() const noexcept
        {
            return stats_handle;
        }

        TrackedObject() noexcept
            : payload_{}
            , stats_handle{ objectStatsRecorder().add_object() }
        {
            my_stats().last_operation = LastOperation::DefaultConstructed;
            my_stats().default_constructions++;
        }

        TrackedObject(T payload) noexcept
            : payload_{ std::move(payload) }
            , stats_handle{ objectStatsRecorder().add_object() }
        {
            my_stats().last_operation = LastOperation::ValueConstructed;
            my_stats().value_constructions++;
        }

        TrackedObject(const TrackedObject& other) noexcept
            : payload_{ other.payload_ }
            , stats_handle{ objectStatsRecorder().add_object() }
        {
            my_stats().last_operation = LastOperation::CopyConstructed;
            my_stats().last_from_id = other.my_stats().id;
            my_stats().copy_constructions++;
        }

        TrackedObject(TrackedObject&& other) noexcept
            : payload_{ std::move(other.payload_) }
            , stats_handle{ objectStatsRecorder().add_object() }
        {
            my_stats().last_operation = LastOperation::MoveConstructed;
            my_stats().last_from_id = other.my_stats().id;
            my_stats().move_constructions++;
        }

        TrackedObject& operator=(const TrackedObject& other) noexcept
        {
            if (this != &other)
            {
                payload_ = other.payload_;
                my_stats().last_operation = LastOperation::CopyAssigned;
                my_stats().last_from_id = other.my_stats().id;
                my_stats().copy_assignments++;
            }
            return *this;
        }

        TrackedObject& operator=(TrackedObject&& other) noexcept
        {
            if (this != &other)
            {
                payload_ = std::move(other.payload_);
                my_stats().last_operation = LastOperation::MoveAssigned;
                my_stats().last_from_id = other.my_stats().id;
                my_stats().move_assignments++;
            }
            return *this;
        }

        operator T&() noexcept
        {
            return payload_;
        }

        operator T const&() const noexcept
        {
            return payload_;
        }

        ~TrackedObject() noexcept
        {
            my_stats().last_operation = LastOperation::Destructed;
            my_stats().destructions++;
        }

    };
}


#endif /* INCLUDED_INCLUDE_TRACKED_OBJECT_HPP */
