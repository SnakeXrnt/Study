
#include "../include/ilogger.hpp"
#include "../clib/clib/logger.h"

namespace logging {

class clogger_adapter : public ilogger {

public:
    
    explicit clogger_adapter(unsigned int rolling_interval_second);

    virtual ~clogger_adapter() override;

    void log(const std::string& msg) const;

private :
    lg_logger_t* m_clogger = nullptr;

};
}
