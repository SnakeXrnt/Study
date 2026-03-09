#include "logger.hpp"
#include "severity_proxy.hpp"

namespace logging
{
    logger::logger(std::unique_ptr<io::itext_writer> out) 
        : m_out{ std::move(out) }
    {}

    void logger::log(std::string_view msg) const {
        log(severity::INFO, msg);
    }

    void logger::log(severity sev, std::string_view msg) const {
        *m_out << to_string(sev) << " | " << msg << '\n';
    }
    
    void logger::set_writer(std::unique_ptr<io::itext_writer> out) {
        m_out.reset(out.release());
    }
}
