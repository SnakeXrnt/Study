#include "builder/logger_builder.hpp"
#include "logger.hpp"
#include "console_writer.hpp"
#include "multi_writer.hpp"
#include "decorators/decorator.hpp"
#include "decorators/runningtime_decorator.hpp"
#include "decorators/timestamp_decorator.hpp"
#include <memory>

builders::logger_builder::logger_builder()
    : m_writer{nullptr}
    , m_logger{nullptr}
{
    reset();
}

builders::ilogger_builder& builders::logger_builder::reset() {

    auto multi_writer = std::make_unique<io::writers::multi_writer>();
    m_writer = multi_writer.get();

    m_logger = std::make_unique<logging::logger>( std::move(multi_writer) );

    return *this;
}

builders::ilogger_builder& builders::logger_builder::with_console_output() {
    if (m_writer){
        m_writer->add_writer("console", std::make_unique<io::writers::console_writer>() );
    }
    return *this;
}

builders::ilogger_builder& builders::logger_builder::with_file_output(std::string_view file_name) {
    if (m_writer){
        m_writer->add_writer(std::string{file_name}, std::make_unique<io::writers::stream_writer>(file_name.data()) );
    }
    return *this;
}

std::unique_ptr<logging::ilogger> builders::logger_builder::get() {
    m_writer = nullptr;
    return std::move(m_logger);
}

builders::ilogger_builder& builders::logger_builder::with_runningtime_timestamp() {
    if (m_logger) {
        m_logger = std::make_unique<extensions::runningtime_decorator>(std::move(m_logger));
    }
    return *this;
}


builders::logger_builder builders::default_builder() {
    return {};
}
