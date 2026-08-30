#ifndef INCLUDED_OPERATIONS_OPERATIONS_HPP
#define INCLUDED_OPERATIONS_OPERATIONS_HPP

#include <string_view>
#include <numbers>
#include <cmath>
#include "interfaces/ioperation.hpp"

namespace sax
{
    struct Pi : public INullaryOperation
    {
        virtual double evaluate() const override
        {
            return std::numbers::pi_v<double>;
        }

        virtual std::string_view symbol() const override
        {
            return "pi";
        }

        virtual std::string_view help() const override
        {
            return "pi: Returns the value of π.";
        }
    };

    struct e : public INullaryOperation
    {
        virtual double evaluate() const override
        {
            return std::numbers::e_v<double>;
        }

        virtual std::string_view symbol() const override
        {
            return "e";
        }

        virtual std::string_view help() const override
        {
            return "e - (Exponent) return e number";
        }
    };

    struct logarithm : public IUnaryOperation
    {
        virtual double evaluate(double operand) const override
        {
            if (operand<0) {
                std::__throw_invalid_argument("negative numbers? really");
            }
            return log(operand);
        }

        virtual std::string_view symbol() const override
        {
            return "ln";
        }

        virtual std::string_view help() const override
        {
            return "exp - (Exponentiation) calculates the exponent with the natural base e";
        }
    };


    struct SquareRoot : public IUnaryOperation
    {
        virtual double evaluate(double operand) const override
        {
            return std::sqrt(operand);
        }

        virtual std::string_view symbol() const override
        {
            return "sqrt";
        }

        virtual std::string_view help() const override
        {
            return "sqrt - (SquareRoot) calculates the square root of a number";
        }
    };

    
    struct plus : public IBinaryOperation
    {
        virtual double evaluate(double left, double right) const override
        {
            return left + right;
        }

        virtual std::string_view symbol() const override
        {
            return "+";
        }

        virtual std::string_view help() const override
        {
            return "+ - (Addition) adds two numbers";
        }
    };

    struct minus : public IBinaryOperation
    {
        virtual double evaluate(double left, double right) const override
        {
            return left - right;
        }

        virtual std::string_view symbol() const override
        {
            return "-";
        }

        virtual std::string_view help() const override
        {
            return "- - (Subtraction) subtracts two numbers";
        }
    };

    struct multiplication : public IBinaryOperation
    {
        virtual double evaluate(double left, double right) const override
        {
            return left * right;
        }

        virtual std::string_view symbol() const override
        {
            return "*";
        }

        virtual std::string_view help() const override
        {
            return "* - (Multiplication) multiplies two numbers";
        }
    };


    struct divison : public IBinaryOperation
    {
        virtual double evaluate(double left, double right) const override
        {
            return left / right;
        }

        virtual std::string_view symbol() const override
        {
            return "/";
        }

        virtual std::string_view help() const override
        {
            return "/ - (Division) calculates the fraction of two numbers";
        }
    };


    // TODO: Implement more operations here


}

#endif /* INCLUDED_OPERATIONS_OPERATIONS_HPP */
