#ifndef INCLUDED_PROGRAM_HPP
#define INCLUDED_PROGRAM_HPP

#include "logger.hpp"
#include <memory>

class program {
public:
    program(std::unique_ptr<logging::ilogger> some_logger) noexcept;
    ~program() noexcept;

    void set_logger(std::unique_ptr<logging::ilogger> some_logger) noexcept;
    void run();
private:
    std::unique_ptr<logging::ilogger> m_logger;
};

#endif //INCLUDED_PROGRAM_HPP
