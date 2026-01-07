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

    // Test task #1: Adding custom writer using with_writer()
    std::cout << "=== Testing custom writer ===" << std::endl;
    
    auto log = builders::default_builder()
        .with_console_output()
        .with_file_output("out5.txt")
        .with_writer(std::make_unique<io::writers::stream_writer>("custom_output.txt"))
        .with_timestamp(timestamp_type::running_time)
        .get();

    program prog { std::move(log) };
    prog.run();

    std::cout << "\n=== Custom writer test complete ===" << std::endl;
    std::cout << "Check custom_output.txt for the custom writer output!" << std::endl;

    // Test task #4: Rolling log with C logger adapter
    std::cout << "\n=== Testing rolling log with C logger ===" << std::endl;
    
    auto log2 = builders::default_builder()
        .with_console_output()
        .with_rolling_log_with_interval(std::chrono::seconds(5))
        .with_timestamp(timestamp_type::current_time)
        .get();

    program prog2 { std::move(log2) };
    prog2.run();

    std::cout << "\n=== Rolling log test complete ===" << std::endl;
    std::cout << "Check log_*.txt files for rolling log output!" << std::endl;

    // uncomment if you do extra part
    // demo_logger_factory_unsafe();

}