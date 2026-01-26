#ifndef INCLUDED_EXTENSIONS_DECORATOR_HPP
#define INCLUDED_EXTENSIONS_DECORATOR_HPP

#include <memory>
#include "ilogger.hpp"
#include "multi_writer.hpp"


namespace extensions {

    class decorator: public logging::ilogger {
    public:

        decorator(std::unique_ptr<ilogger> inner) : m_inner( std::move(inner) ) {}

        virtual void log(std::string_view msg) override {
            m_inner->log(msg);
        }

    private:
        std::unique_ptr<logging::ilogger> m_inner;
    };
}


#endif //INCLUDED_EXTENSIONS_DECORATOR_HPP
