#ifndef INCLUDED_IO_WRITERS_CLOGGER_AS_WRITER_HPP
#define INCLUDED_IO_WRITERS_CLOGGER_AS_WRITER_HPP

#include <chrono>
#include <string_view>

#include "itext_writer.hpp"
#include "clib/logger.h"

namespace io::writers {

class clogger_as_writer : public io::itext_writer {
public:
    clogger_as_writer(std::chrono::seconds roll_interval);

    virtual itext_writer& operator<<(std::string_view view) override;

    virtual itext_writer& operator<<(const char* string) override;

    virtual itext_writer& operator<<(char c) override;

    virtual itext_writer& operator<<(int n) override;

    virtual itext_writer& operator<<(io::flush_t flush) override;

    virtual ~clogger_as_writer() override;
private:
    lg_logger_t* m_clogger;

};

}


#endif //INCLUDED_IO_WRITERS_CLOGGER_AS_WRITER_HPP
