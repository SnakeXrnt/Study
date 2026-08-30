#ifndef INCLUDE_GLOBAL_RUNNINGTIME_PROVIDER_HPP
#define INCLUDE_GLOBAL_RUNNINGTIME_PROVIDER_HPP

#include <chrono>

namespace global {
    class runningtime_provider {
    public:
        using time_point = std::chrono::time_point<std::chrono::high_resolution_clock>;
        using duration = std::chrono::nanoseconds;

        runningtime_provider(const runningtime_provider&) = delete;
        runningtime_provider& operator=(const runningtime_provider&) = delete;

        time_point start_time() const noexcept;
        duration running_time() const noexcept;

        static const runningtime_provider& get_instance();
    private:
        time_point m_t0;
        runningtime_provider();
    };

}


#endif //INCLUDE_GLOBAL_RUNNINGTIME_PROVIDER_HPP
