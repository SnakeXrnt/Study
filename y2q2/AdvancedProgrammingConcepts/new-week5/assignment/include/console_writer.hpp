#ifndef INCLUDED_IO_WRITERS_CONSOLE_WRITER_HPP
#define INCLUDED_IO_WRITERS_CONSOLE_WRITER_HPP

#include "stream_writer.hpp"

namespace io::writers {
class console_writer : public io::itext_writer {
public:

    console_writer() = default;

    virtual itext_writer& operator<<(std::string_view view) override;

    virtual itext_writer& operator<<(const char* string) override;

    virtual itext_writer& operator<<(char c) override;

    virtual itext_writer& operator<<(int n) override;

    virtual itext_writer& operator<<(io::flush_t) override;

};
}


#endif //INCLUDED_IO_WRITERS_CONSOLE_WRITER_HPP
