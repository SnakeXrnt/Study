#include "interfaces/ioperation.hpp"
#include "rpn/rpn.hpp"
#include "rpn/parser.hpp"
#include "rpn/operations.hpp"


#include <algorithm>
#include <iostream>
#include <iterator>
#include <memory>
#include <string>
#include <utility>
#include <vector>

// TODO: Most of the work is in the files in include/rpn
// The directory include/interfaces already contains the implementations of all the interfaces


int main()
{
    std::vector<std::shared_ptr<sax::IOperation>> operations;

    operations.push_back(std::make_shared<sax::plus>());
    operations.push_back(std::make_shared<sax::minus>());
    operations.push_back(std::make_shared<sax::multiplication>());
    operations.push_back(std::make_shared<sax::divison>());


    operations.push_back(std::make_shared<sax::Pi>());
    operations.push_back(std::make_shared<sax::e>());
    operations.push_back(std::make_shared<sax::SquareRoot>());
    operations.push_back(std::make_shared<sax::logarithm>());

    auto parser = std::make_unique<sax::RPNParser>();

    sax::RPNCalculator calc(std::move(operations), std::move(parser));

    std::string expression = "3 4 + 2 *";
    try {
        double result = calc.calculate(expression);
        std::cout << expression << " = " << result << std::endl;
    } catch (const std::exception& e) {
        std::cerr << "error : " << e.what() << std::endl;
    } 

    return 0;
    

    
  }
