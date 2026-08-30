#include "program.hpp"
#include <string>

program::program(std::unique_ptr<logging::ilogger> some_logger) noexcept:
    m_logger{ std::move(some_logger) }
{
    m_logger->log("Starting");
}

void program::set_logger(std::unique_ptr<logging::ilogger> some_logger) noexcept {
    m_logger = std::move(some_logger);
}

void program::run(){
    using namespace std::literals::string_literals;

    auto n{1};
    while(n <= 5){
        m_logger->log("Running: "s + std::to_string(n++));
    }
}

program::~program() noexcept {
    m_logger->log("Quitting");
}


