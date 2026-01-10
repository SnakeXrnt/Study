#include "decorators/timestamp_decorator.hpp"
#include <chrono>
#include <sstream>
#include <iomanip>


namespace detail{

    constexpr static std::string_view time_format = "{:%Y-%m-%d %H:%M:%OS}";

    struct time_helper{
        time_helper()
        : oss_{} 
        {
            auto time_point = std::chrono::system_clock::now();
            oss_ << '[' << std::format(time_format, time_point) << "] " ;
        }

        time_helper& operator<<(std::string_view sv) {
            oss_ << sv;
            return *this;
        }

        std::string str() const & {
            return oss_.str();
        }

        std::string str() && {
            return std::move(oss_).str();
        }

    private:
        std::ostringstream oss_{};
    };
}

void extensions::timestamp_decorator::log(std::string_view msg) const {
    
    detail::time_helper th{};
    th << msg;

    auto str = std::move(th).str();

    decorator::log(str);
}

void extensions::timestamp_decorator::log(logging::severity sev, std::string_view msg) const {
    
    detail::time_helper th{};
    th <<  msg;

    auto str = std::move(th).str();
    
    decorator::log(sev, str);
}