#include "../../include/decorators/runningtime_decorator.hpp"
#include <chrono>
#include <sstream>
#include <iomanip>
#include <string>

namespace extensions {

void runningtime_decorator::log(const std::string& msg) const {
    
    const auto now = std::chrono::high_resolution_clock::now();
    const auto elapsed = now - START_TIME;

    
    const auto total_seconds = std::chrono::duration_cast<std::chrono::seconds>(elapsed);
    const auto fractional_part = elapsed - total_seconds;

    
    const auto nanoseconds = std::chrono::duration_cast<std::chrono::nanoseconds>(fractional_part);
    
    std::ostringstream oss;

    
    oss << '[' << total_seconds.count() << '.'
        
        
        << std::setw(9) << std::setfill('0') << nanoseconds.count() 
        << "] " << msg;
    
    const auto decorated_string = oss.str();

    
    decorator::log(decorated_string);
}

} 
