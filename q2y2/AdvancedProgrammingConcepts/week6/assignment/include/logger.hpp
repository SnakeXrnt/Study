#ifndef INCLUDED_LOGGING_LOGGER_HPP
#define INCLUDED_LOGGING_LOGGER_HPP

#include <string_view>
#include <memory>
#include "ilogger.hpp"
#include "itext_writer.hpp"

namespace logging {
class logger: public logging::ilogger {
    public:
        logger(std::unique_ptr<io::itext_writer> out);
        void set_writer(std::unique_ptr<io::itext_writer> out);

        void log(std::string_view msg) const override;
        
        void log(severity sev, std::string_view msg) const override;

    private:
        std::unique_ptr<io::itext_writer> m_out;
    };
}

#endif //INCLUDED_LOGGING_LOGGER_HPP
