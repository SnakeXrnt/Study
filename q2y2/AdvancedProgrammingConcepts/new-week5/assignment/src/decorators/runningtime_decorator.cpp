#include <sstream>
#include <iomanip>

#include "decorators/runningtime_decorator.hpp"
#include "global/runningtime_provider.hpp"


void extensions::runningtime_decorator::log(std::string_view msg)  {
    std::ostringstream oss;

    auto running_time = global::runningtime_provider::get_instance().running_time();

    // full seconds of the runing time
    auto seconds = std::chrono::duration_cast<std::chrono::seconds>(running_time);
    running_time -= seconds;

    // remaining nanoseconds of the running time
    auto nano = std::chrono::duration_cast<std::chrono::nanoseconds>(running_time);

    oss << '[' << seconds.count() << '.' << std::setfill('0') << std::setw(9) << nano.count() << "] " << msg;
    auto str = oss.str();
    decorator::log(str);
}