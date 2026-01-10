#include "builder/logger_builder.hpp"
#include "logger.hpp"
#include "console_writer.hpp"
#include "multi_writer.hpp"
#include "decorators/decorator.hpp"
#include "decorators/runningtime_decorator.hpp"
#include "decorators/timestamp_decorator.hpp"
#include "decorators/observable_decorator.hpp"
#include "severity_proxy.hpp"
#include <memory>

std::string builders::logger_builder::make_unique_id(std::string_view base) {
    std::string unique_id = std::string{base} + "_" + std::to_string(m_next_id++);
    return unique_id;
}

builders::logger_builder::logger_builder():
    m_writer{nullptr}, m_logger{nullptr}, m_decorated{false}
{
    reset();
}

builders::ilogger_builder& builders::logger_builder::reset() {

    auto multi_writer = std::make_unique<io::writers::multi_writer>();
    m_writer = multi_writer.get();

    m_logger = std::make_unique<logging::logger>( std::move(multi_writer) );

    m_decorated = false;
    m_observable = false;
    return *this;
}

builders::ilogger_builder& builders::logger_builder::with_console_output() {
    if (m_writer){
        m_writer->add_writer(make_unique_id("console"), std::make_unique<io::writers::console_writer>() );
    }
    return *this;
}

builders::ilogger_builder& builders::logger_builder::with_console_output(logging::severity min_sev) {
    if (m_writer){
        m_writer->add_writer(make_unique_id("console"), std::make_unique<io::writers::severity_proxy>( std::make_unique<io::writers::console_writer>(), min_sev ) );
    }
    return *this;
}

builders::ilogger_builder& builders::logger_builder::with_file_output(std::string_view file_name) {
    if (m_writer){
        m_writer->add_writer(make_unique_id(file_name), std::make_unique<io::writers::stream_writer>(file_name.data()) );
    }
    return *this;
}

// builders::ilogger_builder& builders::logger_builder::with_file_output(std::string_view file_name, logging::severity min_sev) {
//     if (m_writer){
//         m_writer->add_writer(make_unique_id(file_name), std::make_unique<io::writers::severity_proxy>( std::make_unique<io::writers::stream_writer>(file_name.data()), min_sev ) );
//     }
//     return *this;
// }

builders::ilogger_builder& builders::logger_builder::with_file_output(std::string_view file_name, logging::severity min_sev) {
    if (m_writer){
        auto stream_wrt = std::make_unique<io::writers::stream_writer>(file_name.data());
        auto proxy = std::make_unique<io::writers::severity_proxy>( std::move(stream_wrt), min_sev );
        m_writer->add_writer( make_unique_id(file_name), std::move(proxy) );
    }
    return *this;
}

std::unique_ptr<logging::ilogger> builders::logger_builder::get() {

    if (m_observable && !m_decorated) {
        m_logger =  std::make_unique<extensions::observable_decorator>( std::move(m_logger) );
    }
    
    auto result = std::move(m_logger);
    
    reset();

    return result;
}

builders::ilogger_builder& builders::logger_builder::with_writer(std::unique_ptr<io::itext_writer> writer) {
    if (m_writer){
        m_writer->add_writer(make_unique_id("writer"), std::move(writer));
    }
    return *this;
}

builders::ilogger_builder& builders::logger_builder::with_writer(std::unique_ptr<io::itext_writer> writer, logging::severity min_sev) {
    if (m_writer){
        m_writer->add_writer(make_unique_id("writer"), std::make_unique<io::writers::severity_proxy>( std::move(writer), min_sev ) );
    }
    return *this;
}

builders::ilogger_builder& builders::logger_builder::with_timestamp(builders::ilogger_builder::timestamp_type type) {
    if (m_logger && !m_decorated) {
        switch (type){
            case ilogger_builder::timestamp_type::running_time:
                m_logger = std::make_unique<extensions::runningtime_decorator>(std::move(m_logger));
                m_decorated = true;
                break;
            case ilogger_builder::timestamp_type::current_time:
                m_logger = std::make_unique<extensions::timestamp_decorator>(std::move(m_logger));
                m_decorated = true;
                break;
            default:
                break;
        }
    }
    return *this;
}

builders::logger_builder builders::default_builder() {
    return {};
}

void builders::logger_builder::make_observable() {
    if (m_logger && !m_observable) {
        m_observable = true;
    }
}