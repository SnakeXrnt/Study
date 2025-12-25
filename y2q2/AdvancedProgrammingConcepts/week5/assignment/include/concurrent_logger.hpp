#ifndef INCLUDED_LOGGING_CONCURRENT_LOGGER_HPP
#define INCLUDED_LOGGING_CONCURRENT_LOGGER_HPP

#include <string>
#include <iostream>
#include <memory>

#include <mutex>
#include <condition_variable>
#include <queue>
#include <atomic>
#include <thread>
#include "ilogger.hpp"
#include "itext_writer.hpp"

namespace logging {
class concurrent_logger: public logging::ilogger {
    public:
        concurrent_logger(std::unique_ptr<io::itext_writer> out);
        
        ~concurrent_logger() override;

        void set_writer(std::unique_ptr<io::itext_writer> out);

        void log(std::string_view msg) override;
    private:

        void process();

        std::unique_ptr<io::itext_writer> m_out;        
        std::mutex m_mtx{};
        std::condition_variable m_cv{};
        std::queue<std::string> m_queue{};
        std::atomic<bool> m_done{false};
        std::thread m_worker;
    };
}

#endif //INCLUDED_LOGGING_CONCURRENT_LOGGER_HPP
