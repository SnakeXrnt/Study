#ifndef INCLUDED_IO_WRITERS_MULTI_WRITER_HPP
#define INCLUDED_IO_WRITERS_MULTI_WRITER_HPP

#include <unordered_map>
#include <string_view>
#include <memory>
#include <string>

#include "itext_writer.hpp"


namespace io::writers {
    class multi_writer : public io::itext_writer {
    public:
        multi_writer();

        void add_writer(const std::string& name, std::unique_ptr<io::itext_writer> writer);
        void remove_writer(const std::string& name);

        virtual ~multi_writer() noexcept override = default;

        virtual itext_writer& operator<<(std::string_view view) override;

        virtual itext_writer& operator<<(const char* string) override;

        virtual itext_writer& operator<<(char c) override;

        virtual itext_writer& operator<<(int n) override;

        virtual itext_writer& operator<<(io::flush_t flush) override;

    private:
        std::unordered_map<std::string, std::unique_ptr<io::itext_writer>> m_writers;
    };
}


#endif //INCLUDED_IO_WRITERS_MULTI_WRITER_HPP
