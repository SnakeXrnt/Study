#ifndef INCLUDED_EXTENSIONS_RUNNINGTIME_DECORATOR_HPP
#define INCLUDED_EXTENSIONS_RUNNINGTIME_DECORATOR_HPP

#include <chrono>
#include "decorator.hpp"

namespace extensions {

    class runningtime_decorator: public decorator {
    public:
        using decorator::decorator;
        virtual void log(std::string_view msg) const override;
        virtual void log(logging::severity sev, std::string_view msg) const override;
    };
}

#endif /* INCLUDED_EXTENSIONS_RUNNINGTIME_DECORATOR_HPP */
