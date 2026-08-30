
#include "../include/clogger_adapter.hpp"
#include <stdexcept>

namespace logging {

// Constructor implementation
clogger_adapter::clogger_adapter(unsigned int rolling_interval_second) {
    lg_result_e result = lg_create(&m_clogger, rolling_interval_second);
    if (result == lgr_error) {
        throw std::runtime_error("Failed to create C logger");
    }
}

// Destructor implementation
clogger_adapter::~clogger_adapter() {
    if (m_clogger != nullptr) {
        lg_destroy(&m_clogger);
    }
}

// Log method implementation
void clogger_adapter::log(const std::string& msg) const {
    if (m_clogger != nullptr) {
        lg_log(m_clogger, msg.c_str());
    }
}

}
