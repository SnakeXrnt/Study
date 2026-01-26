#include "decorators/timestamp_decorator.hpp"
#include <ctime>
#include <sstream>
#include <iomanip>

static const char* TIME_FMT = "%H:%M:%S";

void extensions::timestamp_decorator::log(std::string_view msg)  {

    std::ostringstream oss;

    auto time_point = std::time(nullptr);
    auto local_time = std::localtime(&time_point);

    oss << '[' << std::put_time(local_time, TIME_FMT) << "] " << msg;
    auto str = oss.str();

    decorator::log(str);
}
