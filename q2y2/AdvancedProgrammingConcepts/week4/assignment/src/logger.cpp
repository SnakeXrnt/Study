#include "logger.hpp"
#include <ctime>

namespace logging{

    logger::logger(std::unique_ptr<io::itext_writer> out) 
        : m_out{ std::move(out) }
    {}

    void logger::log(std::string_view msg) const {
        *m_out << msg << '\n';
    }
    
    void logger::set_writer(std::unique_ptr<io::itext_writer> out) {
        m_out.reset(out.release());
    }
}