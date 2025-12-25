#ifndef INCLUDED_EXTENSIONS_TIMESTAMP_DECORATOR_HPP
#define INCLUDED_EXTENSIONS_TIMESTAMP_DECORATOR_HPP

#include <string_view>
#include <memory>
#include "decorator.hpp"

namespace extensions {

class timestamp_decorator: public decorator {
public:
    using decorator::decorator;
    virtual void log(std::string_view msg) override;
};

}

#endif //INCLUDED_EXTENSIONS_TIMESTAMP_DECORATOR_HPP

