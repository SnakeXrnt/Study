#include "system_time_source.hpp"
#include <ctime> 
#include <cstdio>
#include <string>
#include <string_view>

std::string_view system_time_source::timestamp() const {
    static std::string buffer;

    auto now = std::time(nullptr);
    auto local = std::localtime(&now);
    static char tmp[32]{};

    std::strftime(tmp, sizeof(tmp), "%H:%M:%S", local);
    buffer = tmp;
    return tmp;
}
