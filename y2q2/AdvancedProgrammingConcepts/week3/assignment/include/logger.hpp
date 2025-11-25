#ifndef INCLUDED_LOGGER_HPP
#define INCLUDED_LOGGER_HPP

#include <string>
#include <iostream>

#include "ilogger.hpp"
#include "../time/itime_source.hpp"
#include "../writers/itext_writer.hpp"
#include <memory>
#include <string_view>

namespace lib{
class logger: public loggers::ilogger {
    public:
        explicit logger(std::unique_ptr<itext_writer> out) noexcept : m_writer{std::move(out)} {};
        logger() noexcept;
        void log(const std::string_view& msg) const override;
        void set_time_source(std::unique_ptr<itime_source> ts) noexcept;
    private:
        std::unique_ptr<itext_writer> m_writer;
        std::unique_ptr<itime_source> m_time_source;
        void output_time() const;
    };
}

#endif //INCLUDED_LOGGER_HPP
