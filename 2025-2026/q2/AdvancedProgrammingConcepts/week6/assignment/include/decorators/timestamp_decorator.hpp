#ifndef INCLUDED_EXTENSIONS_TIMESTAMP_DECORATOR_HPP
#define INCLUDED_EXTENSIONS_TIMESTAMP_DECORATOR_HPP

#include <string_view>
#include <memory>
#include "decorator.hpp"

namespace extensions {

class timestamp_decorator: public decorator {
public:
    using decorator::decorator;
    virtual void log(std::string_view msg) const override;
    virtual void log(logging::severity sev, std::string_view msg) const override;
};

}

#endif //INCLUDED_EXTENSIONS_TIMESTAMP_DECORATOR_HPP

