#ifndef INCLUDED_LOGGING_ILOGGER_HPP
#define INCLUDED_LOGGING_ILOGGER_HPP

#include <string_view>
#include "severity.hpp"

namespace logging {
    
struct ilogger 
{
    virtual void log(std::string_view msg) const = 0;
    virtual void log(severity prio, std::string_view msg) const = 0;
    virtual ~ilogger() = default;
};
}


#endif //INCLUDED_LOGGING_ILOGGER_HPP

