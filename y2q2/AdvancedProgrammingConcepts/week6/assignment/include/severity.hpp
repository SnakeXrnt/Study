#ifndef INCLUDED_LOGGING_SEVERITY_HPP
#define INCLUDED_LOGGING_SEVERITY_HPP

#include <string_view>
#include <array>

namespace logging
{
    enum struct severity {
        UNKNOWN,
        DEBUG,
        INFO,
        WARNING,
        ERROR,
        CRITICAL
    };

    constexpr inline std::array<severity, 6>  severities() {
        return { severity::UNKNOWN,
                 severity::DEBUG,
                 severity::INFO,
                 severity::WARNING,
                 severity::ERROR,
                 severity::CRITICAL };
    }


    constexpr inline std::string_view to_string(severity prio) {
        static constexpr std::string_view str[] = {
                                    " UNKNOWN",
                                    "   DEBUG",
                                    "    INFO",
                                    " WARNING",
                                    "   ERROR",
                                    "CRITICAL"
        };

        return str[static_cast<std::underlying_type_t<severity>>(prio)];
    }
    
} // namespace logging


#endif /* INCLUDED_LOGGING_SEVERITY_HPP */
