#include <sstream>
#include <iomanip>

#include "decorators/runningtime_decorator.hpp"
#include "global/runningtime_provider.hpp"


namespace detail{

    struct time_helper{
        time_helper()
            : oss_{} 
        {

            auto running_time = global::runningtime_provider::get_instance().running_time();

            // full seconds of the running time
            auto seconds = std::chrono::duration_cast<std::chrono::seconds>(running_time);
            running_time -= seconds;

            // remaining nanoseconds of the running time
            auto nano = std::chrono::duration_cast<std::chrono::nanoseconds>(running_time);

            oss_ << '[' << seconds.count() << '.' << std::setfill('0') << std::setw(9) << nano.count() << "] ";
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


void extensions::runningtime_decorator::log(std::string_view msg) const {

    detail::time_helper th{};
    th << msg;
    
    auto str = std::move(th).str();
    
    decorator::log(str);
}

void extensions::runningtime_decorator::log(logging::severity sev, std::string_view msg) const {
    
    detail::time_helper th{};
    th << msg;
    
    auto str = std::move(th).str();
    
    decorator::log(sev, str);
}