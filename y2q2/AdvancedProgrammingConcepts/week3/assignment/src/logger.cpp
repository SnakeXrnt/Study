#include "logger.hpp"
#include <ctime>
#include <string_view>

namespace lib{
 
    void logger::set_time_source(std::unique_ptr<itime_source> ts) noexcept {
        m_time_source = std::move(ts);
    }

    void logger::log(const std::string_view& msg) const{
        output_time();
        (*m_writer) << ": " <<  msg << '\n';
    }

    void logger::output_time() const {
        if (!m_time_source) {
            return;
        }
        auto ts = m_time_source->timestamp();
        (*m_writer) << '[' << ts << ']';
    }
}
