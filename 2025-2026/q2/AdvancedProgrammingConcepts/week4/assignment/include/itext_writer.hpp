#ifndef INCLUDED_IO_ITEXT_WRITER_HPP
#define INCLUDED_IO_ITEXT_WRITER_HPP

#include <string_view>

namespace io {

    namespace detail {
        struct _flush {
        };
    }

    using flush_t = detail::_flush;
    inline flush_t flush;

    struct itext_writer {
        virtual itext_writer& operator<<(std::string_view) = 0;
        virtual itext_writer& operator<<(const char*) = 0;
        virtual itext_writer& operator<<(char c) = 0;
        virtual itext_writer& operator<<(int n) = 0;

        virtual itext_writer& operator<<(flush_t) = 0;

        virtual ~itext_writer() noexcept = default;
    };
}

#endif //INCLUDED_IO_ITEXT_WRITER_HPP
