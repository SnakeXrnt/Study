#include "decorators/timestamp_decorator.hpp"
#include <ctime>
#include <sstream>
#include <iomanip>

static const char* TIME_FMT = "%H:%M:%S";

void extensions::timestamp_decorator::log(std::string_view msg) const {

    std::ostringstream oss;

    auto time_point = std::time(nullptr);
    auto local_time = std::localtime(&time_point);

    oss << '[' << std::put_time(local_time, TIME_FMT) << "] " << msg;
    auto str = oss.str();

    m_inner->log(str);
}

extensions::timestamp_decorator::timestamp_decorator(std::unique_ptr<logging::ilogger> inner) noexcept:
    m_inner{ std::move(inner) }
{

}
