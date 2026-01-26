#ifndef INCLUDED_IO_WRITERS_STREAM_WRITER_HPP
#define INCLUDED_IO_WRITERS_STREAM_WRITER_HPP

#include <ostream>
#include <string_view>
#include <memory>
#include "itext_writer.hpp"

namespace io::writers {
    class stream_writer : public io::itext_writer {
    public:

        stream_writer(const char* fname);

        stream_writer(std::unique_ptr<std::ostream> out);

        virtual itext_writer& operator<<(std::string_view view) override;

        virtual itext_writer& operator<<(const char* string) override;

        virtual itext_writer& operator<<(char c) override;

        virtual itext_writer& operator<<(int n) override;

        virtual itext_writer& operator<<(io::flush_t) override;

    private:
        std::unique_ptr<std::ostream> m_out;
    };
}

#endif //INCLUDED_IO_WRITERS_STREAM_WRITER_HPP
