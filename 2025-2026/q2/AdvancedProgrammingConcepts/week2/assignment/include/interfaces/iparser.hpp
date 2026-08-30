#ifndef INCLUDED_INTERFACES_IPARSER_HPP
#define INCLUDED_INTERFACES_IPARSER_HPP

#include <vector>
#include "token.hpp"

namespace sax
{
    using TokenStream = std::vector<Token>;

    struct IParser
    {
        virtual ~IParser() = default;
        virtual TokenStream parse(std::string_view expression) const = 0;
    };
}

#endif /* INCLUDED_INTERFACES_IPARSER_HPP */
