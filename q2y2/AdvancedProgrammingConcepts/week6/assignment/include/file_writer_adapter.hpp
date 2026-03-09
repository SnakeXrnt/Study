#ifndef LESSON_FILE_WRITER_ADAPTER_HPP
#define LESSON_FILE_WRITER_ADAPTER_HPP

#include <string_view>
#include "itext_writer.hpp"
#include "clib/file_writer.h"

namespace io::writers {
    class file_writer_adapter : public io::itext_writer {
    public:

        file_writer_adapter(const char* fname);

        virtual ~file_writer_adapter() override = default;

        virtual io::itext_writer& operator<<(std::string_view view) override;

        virtual io::itext_writer& operator<<(const char* string) override;

        virtual io::itext_writer& operator<<(char c) override;

        virtual io::itext_writer& operator<<(int n) override;

        virtual io::itext_writer& operator<<(io::flush_t flush) override;

    private:
        file_writer m_wrt;
    };

}
#endif //LESSON_FILE_WRITER_ADAPTER_HPP
