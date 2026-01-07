#include "builder/logger_builder.hpp"
#include "logger.hpp"
#include "console_writer.hpp"
#include "multi_writer.hpp"
#include "decorators/decorator.hpp"
#include "decorators/runningtime_decorator.hpp"
#include "decorators/timestamp_decorator.hpp"
#include "global/runningtime_provider.hpp"
#include "clogger_as_writer.hpp"
#include <memory>
#include <string>

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


builders::ilogger_builder& builders::logger_builder::with_writer(std::unique_ptr<io::itext_writer> writer) {
    if (m_writer){
        auto running_time_ns = global::runningtime_provider::get_instance().running_time().count();
        std::string unique_name = "writer_" + std::to_string(running_time_ns);
        
        m_writer->add_writer(unique_name, std::move(writer));
    }
    return *this;
}

builders::ilogger_builder& builders::logger_builder::with_timestamp(timestamp_type type) {
    if (m_logger) {
        switch (type) {
            case timestamp_type::none:
                break;
            case timestamp_type::current_time:
                m_logger = std::make_unique<extensions::timestamp_decorator>(std::move(m_logger));
                break;
            case timestamp_type::running_time:
                m_logger = std::make_unique<extensions::runningtime_decorator>(std::move(m_logger));
                break;
        }
    }
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

builders::ilogger_builder& builders::logger_builder::with_rolling_log_with_interval(std::chrono::seconds interval) {
    if (m_writer) {
        auto running_time_ns = global::runningtime_provider::get_instance().running_time().count();
        std::string unique_name = "rolling_log_" + std::to_string(running_time_ns);
        
        m_writer->add_writer(unique_name, std::make_unique<io::writers::clogger_as_writer>(interval));
    }
    return *this;
}

std::unique_ptr<logging::ilogger> builders::logger_builder::get() {
    m_writer = nullptr;
    return std::move(m_logger);
}

builders::logger_builder builders::default_builder() {
    return {};
}
