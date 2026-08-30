#ifndef LESSON_CLOGGER_ADAPTER_HPP
#define LESSON_CLOGGER_ADAPTER_HPP

#include <string>
#include <iostream>
#include <memory>
#include "ilogger.hpp"
#include "clib/logger.h"

namespace logging {
    class clogger_adapter: public logging::ilogger {
    public:
        clogger_adapter(int roll_interval);
        virtual void log(std::string_view msg) const override;
        virtual ~clogger_adapter() override;
    private:
        lg_logger_t* m_clogger;
    };
}


#endif //LESSON_CLOGGER_ADAPTER_HPP
