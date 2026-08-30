#ifndef INCLUDED_LOGGING_CLOGGER_ADAPTER_HPP
#define INCLUDED_LOGGING_CLOGGER_ADAPTER_HPP

#include "ilogger.hpp"
#include "../clib/clib/logger.h"
#include <string>

namespace logging {

class clogger_adapter : public ilogger {

public:
    
    explicit clogger_adapter(unsigned int rolling_interval_second);

    virtual ~clogger_adapter() override;

    void log(const std::string& msg) const;

private:
    lg_logger_t* m_clogger = nullptr;

};

}

#endif // INCLUDED_LOGGING_CLOGGER_ADAPTER_HPP
