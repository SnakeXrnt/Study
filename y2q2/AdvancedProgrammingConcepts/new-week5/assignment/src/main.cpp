#include "logger.hpp"
#include "concurrent_logger.hpp"
#include "program.hpp"
#include "console_writer.hpp"
#include "stream_writer.hpp"
#include "file_writer_adapter.hpp"
#include "multi_writer.hpp"
#include "builder/logger_builder.hpp"
#include "extra/logger_factory_unsafe.hpp"
#include <iostream>
#include <memory>
#include <thread>
#include <vector>
#include <thread>
#include <cstdbool>
#include <clogger_adapter.hpp>


#include "clib/logger.h"

namespace {
    [[maybe_unused]] auto _ = [] () noexcept {
       std::ios_base::sync_with_stdio(false);
        return true;
    }();
}

void demo_logger_factory_unsafe()
{
    std::vector<std::thread> threads;
    for (auto i = 0; i < 25; ++i)
    {
        threads.emplace_back([](){
            auto& logger = extra::logger_factory_unsafe::get().default_logger();
            logger.log("Logging from thread unsafe factory");
        });
    }

    for (auto& thread : threads)
    {
        thread.join();
    }
}


int main(){

    auto log = builders::default_builder()
        .with_console_output()
        .with_file_output("out5.txt")
        .with_runningtime_timestamp()
        .get();

    program prog { std::move(log) };
    prog.run();

    // uncomment if you do extra part
    // demo_logger_factory_unsafe();

}