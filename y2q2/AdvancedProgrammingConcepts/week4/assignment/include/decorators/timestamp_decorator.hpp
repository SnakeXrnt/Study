#ifndef INCLUDED_EXTENSIONS_TIMESTAMP_DECORATOR_HPP
#define INCLUDED_EXTENSIONS_TIMESTAMP_DECORATOR_HPP

#include <string>
#include <memory>
#include "../ilogger.hpp"
#include "decorator.hpp"
#include "logger.hpp"

namespace extensions {

class timestamp_decorator: public decorator {
public:
    using decorator::decorator;
    virtual void log(std::string_view msg) const;
    virtual ~timestamp_decorator() override = default;
    timestamp_decorator(std::unique_ptr<logging::ilogger> inner);
};
}

#endif //INCLUDED_EXTENSIONS_TIMESTAMP_DECORATOR_HPP
