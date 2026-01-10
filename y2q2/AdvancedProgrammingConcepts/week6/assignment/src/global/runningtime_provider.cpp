#include "global/runningtime_provider.hpp"

namespace {
    [[maybe_unused]] const auto& _ = ::global::runningtime_provider::get_instance();
}

global::runningtime_provider::time_point global::runningtime_provider::start_time() const noexcept {
    return m_t0;
}

global::runningtime_provider::duration global::runningtime_provider::running_time() const noexcept {
    return std::chrono::high_resolution_clock::now() - m_t0;
}

global::runningtime_provider::runningtime_provider():
    m_t0{std::chrono::high_resolution_clock::now()}
{}

const global::runningtime_provider& global::runningtime_provider::get_instance() {
    static runningtime_provider obj{};
    return obj;
}
