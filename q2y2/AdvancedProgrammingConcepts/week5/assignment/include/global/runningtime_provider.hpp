#ifndef INCLUDE_GLOBAL_RUNNINGTIME_PROVIDER_HPP
#define INCLUDE_GLOBAL_RUNNINGTIME_PROVIDER_HPP

#include <chrono>

namespace global {
    // Singleton that tracks elapsed time since first access
    class runningtime_provider {
    public:
        using time_point = std::chrono::time_point<std::chrono::high_resolution_clock>;
        using duration = std::chrono::nanoseconds;

        // Prevent copying
        runningtime_provider(const runningtime_provider&) = delete;
        runningtime_provider& operator=(const runningtime_provider&) = delete;

        // Get the program start time
        time_point start_time() const noexcept;
        
        // Get elapsed time since program start
        duration running_time() const noexcept;

        // Access the singleton instance
        static const runningtime_provider& get_instance();
        
    private:
        time_point m_t0;  // Program start time
        runningtime_provider();
    };
}

#endif //INCLUDE_GLOBAL_RUNNINGTIME_PROVIDER_HPP
