#ifndef INCLUDED_PARSER_HPP
#define INCLUDED_PARSER_HPP

#include "interfaces/iparser.hpp"
#include "interfaces/token.hpp"

#include <cstddef>
#include <stdexcept>
#include <string>
#include <sstream>
#include <charconv>
#include <string_view>

namespace sax
{
    struct RPNParser : public IParser
    {
        RPNParser() = default;
        // TODO: Implement the IParser interface
        TokenStream parse(std::string_view expression) const override {
            TokenStream tokens;
            std::string current_token;

            for(size_t i=0; i < expression.size(); i++) {
                if(expression[i] != ' ') {
                    current_token.push_back(expression[i]);
                } 
                if((expression[i] == ' ' || i == expression.size()) - 1 && !current_token.empty()) {
                    Token token;
                    token.value = current_token;

                    try {
                        token.number_value = std::stod(current_token);
                        token.type = Token::TokenType::Number;
                    } catch (const std::invalid_argument& e) {
                        token.type = Token::TokenType::Operation;
                        token.number_value = 0.0;
                    }

                    tokens.push_back(token);
                    current_token.clear();
                }
            }
            return tokens;
        }


    };
}

#endif /* INCLUDED_PARSER_HPP */
