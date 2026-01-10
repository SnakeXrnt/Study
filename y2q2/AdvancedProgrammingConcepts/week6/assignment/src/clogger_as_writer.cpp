#include <cstdio>
#include <stdexcept>
#include <string>
#include "clogger_as_writer.hpp"

io::itext_writer& io::writers::clogger_as_writer::operator<<(std::string_view view) {
    std::string str{view};
    lg_log(m_clogger, str.c_str());
    return *this;
}

io::itext_writer& io::writers::clogger_as_writer::operator<<(const char* string) {
    lg_log(m_clogger, string);
    return *this;
}

io::itext_writer& io::writers::clogger_as_writer::operator<<(char c) {
    char str[2] = {c,};
    lg_log(m_clogger, &str[0]);
    return *this;
}

io::itext_writer& io::writers::clogger_as_writer::operator<<(int n) {
    char str[32];
    std::sprintf(&str[0], "%d", n);
    lg_log(m_clogger, &str[0]);
    return *this;
}

io::itext_writer& io::writers::clogger_as_writer::operator<<(io::flush_t) {
    return *this;
}

io::writers::clogger_as_writer::clogger_as_writer(std::chrono::seconds roll_interval): m_clogger{nullptr} {
    if (auto result = lg_create(&m_clogger, roll_interval.count()); result == lgr_error){
        m_clogger = nullptr;
        throw std::runtime_error("c logger returned an error during initialization");
    }
}

io::writers::clogger_as_writer::~clogger_as_writer() {
    lg_destroy(&m_clogger);
}
