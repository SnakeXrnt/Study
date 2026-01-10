#include "logger.hpp"
#include "program.hpp"
#include "console_writer.hpp"
#include "stream_writer.hpp"
#include "file_writer_adapter.hpp"
#include "multi_writer.hpp"
#include "builder/logger_builder.hpp"
#include "severity_proxy.hpp"
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

int main(){

std::unique_ptr<io::itext_writer> file_writer = std::make_unique<io::writers::stream_writer>("errors.txt");
file_writer = std::make_unique<io::writers::severity_proxy>(std::move(file_writer), logging::severity::WARNING);

auto log = builders::default_builder()
    .with_console_output()
    .with_writer(std::move(file_writer))
    .with_timestamp(builders::ilogger_builder::timestamp_type::current_time)
    .get();

program prog { std::move(log) };
prog.run();

return 0;

}
