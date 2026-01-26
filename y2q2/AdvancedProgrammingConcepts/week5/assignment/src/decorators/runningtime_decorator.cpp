#include <sstream>
#include <iomanip>

#include "decorators/runningtime_decorator.hpp"
#include "global/runningtime_provider.hpp"

void extensions::runningtime_decorator::log(std::string_view msg) {
    // Get elapsed time since program start
    auto elapsed = global::runningtime_provider::get_instance().running_time();
    
    // Convert to seconds as a floating point value
    auto seconds_total = std::chrono::duration<double>(elapsed).count();
    
    // Format: [seconds.nanoseconds] message
    std::ostringstream oss;
    oss << '[' << std::fixed << std::setprecision(9) << seconds_total << "] " << msg;
    
    decorator::log(oss.str());
}