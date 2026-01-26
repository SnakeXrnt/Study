#include "concurrent_logger.hpp"
#include <ctime>

namespace logging{

    concurrent_logger::concurrent_logger(std::unique_ptr<io::itext_writer> out) 
        : m_out{ std::move(out) }
        , m_worker{&concurrent_logger::process, this }
    {}

    concurrent_logger::~concurrent_logger() {
        m_done.store(true);
        m_cv.notify_all();
        if (m_worker.joinable()){
            m_worker.join();
        }
    }

    void concurrent_logger::log(std::string_view msg) {
        {
            std::lock_guard<std::mutex> lock{m_mtx};
            m_queue.emplace( std::string{msg} );
        }
        m_cv.notify_one();
    }
    
    void concurrent_logger::set_writer(std::unique_ptr<io::itext_writer> out) {
        std::lock_guard<std::mutex> lock{m_mtx};
        m_out = std::move(out);
    }

    void concurrent_logger::process(){
        while(!m_done.load()){
            std::unique_lock<std::mutex> lock{m_mtx};
            m_cv.wait(lock, [this]() { return !m_queue.empty() || m_done.load(); });

            while(!m_queue.empty()){
                auto msg = std::move(m_queue.front());
                m_queue.pop();
                *m_out << msg << '\n';
            }
        }

        // Process remaining messages
        while(true){
            std::unique_lock<std::mutex> lock{m_mtx};
            if (m_queue.empty()){
                break;
            }
            auto msg = std::move(m_queue.front());
            m_queue.pop();
            *m_out << msg << '\n';
        }
    }
}