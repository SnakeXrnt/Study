#ifndef INCLUDED_ILOGGER_HPP
#define INCLUDED_ILOGGER_HPP

#include <iterator>
#include <string>
#include <string_view>

namespace loggers {
    class ilogger {
    public:
        virtual void log(const std::string_view& msg) const = 0;
        virtual ~ilogger() = default;
    };
}

#endif //INCLUDED_ILOGGER_HPP
