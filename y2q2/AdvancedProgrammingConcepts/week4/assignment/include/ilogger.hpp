#ifndef INCLUDED_LOGGING_ILOGGER_HPP
#define INCLUDED_LOGGING_ILOGGER_HPP

#include <string_view>

namespace logging {

    class ilogger {
    public:
        virtual void log(std::string_view msg) const  = 0;
        virtual ~ilogger() noexcept = default;
    };
}


#endif //INCLUDED_LOGGING_ILOGGER_HPP
