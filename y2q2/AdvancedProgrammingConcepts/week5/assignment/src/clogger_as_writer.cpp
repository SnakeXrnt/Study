#include "clogger_as_writer.hpp"
#include <string>
#include <stdexcept>

namespace io::writers {

    clogger_as_writer::clogger_as_writer(std::chrono::seconds interval) 
        : m_clogger{nullptr} 
    {
        if (auto result = lg_create(&m_clogger, interval.count()); result == lgr_error) {
            lg_destroy(&m_clogger);
            m_clogger = nullptr;
            throw std::runtime_error("C logger returned an error during initialization");
        }
    }

    clogger_as_writer::~clogger_as_writer() {
        lg_destroy(&m_clogger);
    }

    io::itext_writer& clogger_as_writer::operator<<(std::string_view view) {
        if (m_clogger) {
            std::string str{view};
            lg_log(m_clogger, str.c_str());
        }
        return *this;
    }

    io::itext_writer& clogger_as_writer::operator<<(const char* string) {
        if (m_clogger && string) {
            lg_log(m_clogger, string);
        }
        return *this;
    }

    io::itext_writer& clogger_as_writer::operator<<(char c) {
        if (m_clogger) {
            char buffer[2] = {c, '\0'};
            lg_log(m_clogger, buffer);
        }
        return *this;
    }

    io::itext_writer& clogger_as_writer::operator<<(int n) {
        if (m_clogger) {
            std::string str = std::to_string(n);
            lg_log(m_clogger, str.c_str());
        }
        return *this;
    }

    io::itext_writer& clogger_as_writer::operator<<(io::flush_t) {
        // Empty implementation as requested - C logger doesn't support flush
        return *this;
    }

}
