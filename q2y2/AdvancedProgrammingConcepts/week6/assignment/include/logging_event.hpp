#ifndef INCLUDED_LOGGING_LOGGING_EVENT_HPP
#define INCLUDED_LOGGING_LOGGING_EVENT_HPP

#include <string_view>
#include "observers/observers.hpp"

namespace logging {
    
struct log_event {
    logging::severity severity;
    std::string_view message;
    const observers::iobservable<log_event> * source;
};

}
#endif