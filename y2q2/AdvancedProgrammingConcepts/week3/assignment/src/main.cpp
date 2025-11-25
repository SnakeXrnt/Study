#include "logger.hpp"
#include "program.hpp"
#include "../writers/console_writer.hpp"
#include "../time/system_time_source.hpp"

#include <memory>

int main() {
    using writers::console_writer;
    using lib::logger;

    // 1. Concrete writer
    auto writer = std::make_unique<console_writer>();

    // 2. Concrete logger, but stored as pointer to interface
    std::unique_ptr<loggers::ilogger> log =
        std::make_unique<logger>(std::move(writer));

    // 3. Time source
    auto ts = std::make_unique<system_time_source>();
    // logger has set_time_source, but we need a lib::logger* to call it
    // so downcast the pointer temporarily if needed, or keep a separate pointer

    // if loggers::ilogger has no set_time_source, do something like:
    auto concrete_logger = static_cast<logger*>(log.get());
    concrete_logger->set_time_source(std::move(ts));

    // 4. Transfer ownership of logger to program
    program prog{ std::move(log) };   // now program owns it
    prog.run();
}
