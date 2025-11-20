#ifndef INCLUDED_INTERFACES_ICALCULATOR_HPP
#define INCLUDED_INTERFACES_ICALCULATOR_HPP
#include <string_view>
#include <optional>
#include <vector>
#include <memory>

#include "ioperation.hpp"
#include "interfaces/iparser.hpp"


namespace sax
{
    struct ICalculator
    {
        virtual ~ICalculator() = default;

        virtual double evaluate(std::string_view expression) const = 0;
        virtual void add_operation(std::unique_ptr<IOperation> operation) = 0;
        virtual void clear_operations() = 0;

        std::vector<std::string_view> supported_operations() const;
        std::vector<std::string_view> help() const;
    };
}

#endif /* INCLUDED_INTERFACES_ICALCULATOR_HPP */
