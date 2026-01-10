#include "clogger_adapter.hpp"

void logging::clogger_adapter::log(std::string_view msg) const {

    if (*msg.cend() == '\0') {
        lg_log(m_clogger, msg.data());
    }
    else{
        std::string str{msg};
        lg_log(m_clogger, str.c_str());
    }
}

logging::clogger_adapter::clogger_adapter(int roll_interval): m_clogger{nullptr} {
    if (auto result = lg_create(&m_clogger, roll_interval); result == lgr_error){
        lg_destroy(&m_clogger);
        m_clogger = nullptr;
        throw std::runtime_error("c logger returned an error during initialization");
    }
}

logging::clogger_adapter::~clogger_adapter() {
    lg_destroy(&m_clogger);
}

