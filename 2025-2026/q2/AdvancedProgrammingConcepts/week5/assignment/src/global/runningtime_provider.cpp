#include "global/runningtime_provider.hpp"

global::runningtime_provider::time_point global::runningtime_provider::start_time() const noexcept {
    return m_t0;
}

global::runningtime_provider::duration global::runningtime_provider::running_time() const noexcept {
    return std::chrono::high_resolution_clock::now() - m_t0;
}

// Constructor captures the program start time
global::runningtime_provider::runningtime_provider() 
    : m_t0{std::chrono::high_resolution_clock::now()} 
{}

// Singleton instance - initialized on first access
const global::runningtime_provider& global::runningtime_provider::get_instance() {
    static runningtime_provider instance{};
    return instance;
}

// namespace { 
//     [[maybe_unused]] const auto& _init_runningtime = global::runningtime_provider::get_instance();
// }