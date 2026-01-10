#ifndef INCLUDED_CLIB_ITEXT_WRITER_H
#define INCLUDED_CLIB_ITEXT_WRITER_H

struct itext_writer {
    
    virtual void write(const char*) = 0;
    virtual void write(char c) = 0;

    virtual ~itext_writer() = default;
};

#endif //INCLUDED_CLIB_ITEXT_WRITER_H
