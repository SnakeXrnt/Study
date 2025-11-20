#ifndef RPN_HPP
#define RPN_HPP

#include <string_view>
#include <vector>
#include <memory>
#include <stdexcept>

#include "interfaces/icalculator.hpp"
#include "interfaces/iparser.hpp"
#include "interfaces/ioperation.hpp"
#include "interfaces/token.hpp"

namespace sax
{
class RPNCalculator {
private:
    std::vector<std::shared_ptr<IOperation>> operations;  // Fixed: IOperation not ioperation
    std::unique_ptr<IParser> parser;                       // Fixed: IParser not iparser

public:
    RPNCalculator(std::vector<std::shared_ptr<IOperation>> ops, std::unique_ptr<IParser> p): operations(std::move(ops)), parser(std::move(p)) {}

    double calculate(std::string_view expression) {
        auto tokens = parser->parse(expression);
        std::vector<double> stack;

        for (const auto& token : tokens) {
            if (token.type == Token::TokenType::Number) {
                stack.push_back(token.number_value); 
            }
            else if (token.type == Token::TokenType::Operation) {
                IOperation* op = findOperation(token.value);
                if (!op) {
                    throw std::runtime_error("Unknown operator: " + 
                                           std::string(token.value));
                }

                if (auto* binOp = dynamic_cast<IBinaryOperation*>(op)) {
                    if (stack.size() < 2) {
                        throw std::runtime_error("Insufficient operands for binary operation");
                    }
                    double right = stack.back(); stack.pop_back();
                    double left = stack.back(); stack.pop_back();
                    stack.push_back(binOp->evaluate(left, right));
                }
                else if (auto* unaryOp = dynamic_cast<IUnaryOperation*>(op)) {
                    if (stack.size() < 1) {
                        throw std::runtime_error("Insufficient operands for unary operation");
                    }
                    double operand = stack.back(); stack.pop_back();
                    stack.push_back(unaryOp->evaluate(operand));
                }
                else if (auto* nullaryOp = dynamic_cast<INullaryOperation*>(op)) {
                    stack.push_back(nullaryOp->evaluate());
                }
                else {
                    throw std::runtime_error("Unknown operation type");
                }
            }
        }

        if (stack.size() != 1) {
            throw std::runtime_error("Invalid expression");
        }

        return stack[0];
    }

private:
    IOperation* findOperation(const std::string& symbolStr) {
        for (const auto& op : operations) {
            // Fixed: use symbol() not getSymbol()
            if (op->symbol() == symbolStr) {
                return op.get();
            }
        }
        return nullptr;
    }
};
}
#endif
