#include "logger.hpp"
#include "program.hpp"
#include "console_writer.hpp"
#include "stream_writer.hpp"
#include "file_writer_adapter.hpp"
#include "multi_writer.hpp"
#include "decorators/timestamp_decorator.hpp"
#include <iostream>
#include <memory>
#include <thread>
#include <vector>
#include <thread>
#include <cstdbool>


#include "clib/logger.h"

namespace {
    [[maybe_unused]] auto _ = [] () noexcept {
       std::ios_base::sync_with_stdio(false);
        return true;
    }();
}

void demo_logging()
{
    auto fwa = std::make_unique<io::writers::file_writer_adapter>("_out2.txt");
    auto sw = std::make_unique<io::writers::stream_writer>("_out1.txt");
    auto cw = std::make_unique<io::writers::console_writer>();

    auto mw = std::make_unique<io::writers::multi_writer>();

    mw->add_writer("fwa", std::move(fwa));
    mw->add_writer("sw", std::move(sw));
    mw->add_writer("cw", std::move(cw));

    auto log = std::make_unique<logging::logger>( std::move(mw) );

    std::unique_ptr<logging::ilogger> decorated = std::make_unique<extensions::timestamp_decorator>(std::move(log));
    
    decorated = std::make_unique<extensions::timestamp_decorator>(std::move(decorated));

    program prog{ std::move(decorated) };
    
    prog.run();
}
    
void demo_rolling()
{
    lg_logger_t* logger{nullptr};
    lg_create(&logger, 3);
    lg_set_debug_output(logger, true);

    lg_log(logger, "Hello world");
    std::this_thread::sleep_for(std::chrono::seconds{6});
    lg_log(logger, "Once more...");
    std::this_thread::sleep_for(std::chrono::seconds{6});
    lg_log(logger, "And once more...");

    lg_destroy(&logger);
}

int main(){

    demo_logging();

}