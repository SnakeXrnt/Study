#include "../time/system_time_source.hpp"
#include "../writers/console_writer.hpp"
#include "../writers/stream_writer.hpp"
#include "logger.hpp"
#include "program.hpp"

#include <algorithm>
#include <memory>

int main() {
  using lib::logger;
  using writers::console_writer;
  using writers::stream_writer;

  // 1. Concrete writer
  auto writer = std::make_unique<console_writer>();

  // 2. Concrete logger, but stored as pointer to interface
  auto log = std::make_unique<logger>(std::move(writer));

  // 3. Time source
  auto ts = std::make_unique<system_time_source>();
  // logger has set_time_source, but we need a lib::logger* to call it
  // so downcast the pointer temporarily if needed, or keep a separate pointer

  // if loggers::ilogger has no set_time_source, do something like:
  log->set_time_source(std::move(ts));

  // 4. Transfer ownership of logger to program
  program prog{std::move(log)}; // now program owns it
  prog.run();

  std::cout << "file logging" << std::endl;

  auto file_writter = std::make_unique<stream_writer>("log.txt");
  std::unique_ptr<loggers::ilogger> file_log =
      std::make_unique<logger>(std::move(file_writter));
  auto ts2 = std::make_unique<system_time_source>();
  auto concrete_file_logger = static_cast<logger *>(file_log.get());
  concrete_file_logger->set_time_source(std::move(ts2));
  program prog2{std::move(file_log)}; // now program owns it
  prog2.run();
}
