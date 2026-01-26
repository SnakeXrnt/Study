#ifndef INCLUDED_CLIB_FILE_WRITER_H
#define INCLUDED_CLIB_FILE_WRITER_H

#include <cstdio>
#include "itext_writer.h"

class file_writer : public itext_writer {
public:

    explicit file_writer(const char* fname);

    virtual void write(char c) override;

    virtual void write(const char* string) override;

    virtual ~file_writer() noexcept override;

protected:
    file_writer();
    void write(const char* string, std::FILE* file);
    void write(char c, std::FILE* file);

private:
    std::FILE* m_file;
};


#endif //INCLUDED_CLIB_FILE_WRITER_H
