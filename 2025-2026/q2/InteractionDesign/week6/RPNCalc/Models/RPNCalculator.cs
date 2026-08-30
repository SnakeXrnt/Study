using System.Collections.Generic;
using System.Linq;

namespace RPNCalc.Models;

/// <summary>
/// Core RPN Calculator logic - handles expression parsing and evaluation
/// Accepts normal notation (e.g., "5 + 3") and converts to RPN internally
/// </summary>
public class RPNCalculator
{
    private readonly Dictionary<string, IOperator> _operators;
    private readonly Stack<double> _stack;

    public RPNCalculator()
    {
        _stack = new Stack<double>();
        
        // Register all operators (binary and unary)
        _operators = new Dictionary<string, IOperator>
        {
            // Binary operators
            { "+", new AddOperator() },
            { "-", new SubtractOperator() },
            { "×", new MultiplyOperator() },
            { "÷", new DivideOperator() },
            // Unary operators
            { "sin", new SinOperator() },
            { "cos", new CosOperator() },
            { "tan", new TanOperator() },
            { "log", new LogOperator() },
            { "√", new SqrtOperator() }
        };
    }

    /// <summary>
    /// Get the current state of the RPN stack
    /// </summary>
    public IEnumerable<double> GetStack() => _stack.Reverse();

    /// <summary>
    /// Convert an expression to RPN notation string for display
    /// </summary>
    public string GetRPNNotation(string expression)
    {
        if (string.IsNullOrWhiteSpace(expression))
            return "(empty)";

        try
        {
            var tokens = ParseExpression(expression);
            var rpnTokens = ConvertToRPN(tokens);
            return string.Join(" ", rpnTokens);
        }
        catch
        {
            return "(invalid)";
        }
    }

    /// <summary>
    /// Clear the calculator stack
    /// </summary>
    public void Clear()
    {
        _stack.Clear();
    }

    /// <summary>
    /// Evaluate an expression in normal notation (e.g., "5 + 3")
    /// Converts to RPN internally and returns the result
    /// </summary>
    public double Evaluate(string expression)
    {
        if (string.IsNullOrWhiteSpace(expression))
            throw new ArgumentException("Expression cannot be empty");

        // Parse the expression and convert to RPN
        var tokens = ParseExpression(expression);
        var rpnTokens = ConvertToRPN(tokens);
        
        // Evaluate the RPN expression
        return EvaluateRPN(rpnTokens);
    }

    /// <summary>
    /// Parse expression into tokens (numbers, operators, and functions)
    /// </summary>
    private List<string> ParseExpression(string expression)
    {
        var tokens = new List<string>();
        var currentToken = "";

        for (int i = 0; i < expression.Length; i++)
        {
            char c = expression[i];

            if (char.IsDigit(c) || c == '.')
            {
                // Part of a number
                currentToken += c;
            }
            else if (char.IsLetter(c))
            {
                // Part of a function name (sin, cos, tan, log)
                currentToken += c;
            }
            else if (_operators.ContainsKey(c.ToString()))
            {
                // Single-character operator (√, +, -, ×, ÷)
                if (!string.IsNullOrEmpty(currentToken))
                {
                    tokens.Add(currentToken);
                    currentToken = "";
                }
                tokens.Add(c.ToString());
            }
            else if (c == ' ' || c == '(' || c == ')')
            {
                // Whitespace or parentheses
                if (!string.IsNullOrEmpty(currentToken))
                {
                    tokens.Add(currentToken);
                    currentToken = "";
                }
                if (c == '(' || c == ')')
                {
                    tokens.Add(c.ToString());
                }
            }
        }

        if (!string.IsNullOrEmpty(currentToken))
            tokens.Add(currentToken);

        return tokens;
    }

    /// <summary>
    /// Convert infix notation to RPN using Shunting Yard algorithm
    /// Supports functions (sin, cos, tan, log, √) and parentheses
    /// </summary>
    private List<string> ConvertToRPN(List<string> tokens)
    {
        var output = new List<string>();
        var operatorStack = new Stack<string>();

        // Operator precedence (higher number = higher precedence)
        var precedence = new Dictionary<string, int>
        {
            { "+", 1 },
            { "-", 1 },
            { "×", 2 },
            { "÷", 2 },
            // Functions have highest precedence
            { "sin", 3 },
            { "cos", 3 },
            { "tan", 3 },
            { "log", 3 },
            { "√", 3 }
        };

        foreach (var token in tokens)
        {
            if (double.TryParse(token, out _))
            {
                // It's a number
                output.Add(token);
            }
            else if (_operators.ContainsKey(token))
            {
                // It's an operator or function
                bool isFunction = _operators[token].OperandCount == 1;
                
                if (isFunction)
                {
                    // Functions always go on stack immediately
                    operatorStack.Push(token);
                }
                else
                {
                    // Binary operators - check precedence
                    while (operatorStack.Count > 0 && 
                           operatorStack.Peek() != "(" &&
                           precedence.ContainsKey(operatorStack.Peek()) &&
                           precedence[operatorStack.Peek()] >= precedence[token])
                    {
                        output.Add(operatorStack.Pop());
                    }
                    operatorStack.Push(token);
                }
            }
            else if (token == "(")
            {
                operatorStack.Push(token);
            }
            else if (token == ")")
            {
                // Pop until we find opening parenthesis
                while (operatorStack.Count > 0 && operatorStack.Peek() != "(")
                {
                    output.Add(operatorStack.Pop());
                }
                if (operatorStack.Count > 0 && operatorStack.Peek() == "(")
                {
                    operatorStack.Pop(); // Remove the (
                    
                    // If there's a function on top of stack, pop it too
                    if (operatorStack.Count > 0 && _operators.ContainsKey(operatorStack.Peek()) && 
                        _operators[operatorStack.Peek()].OperandCount == 1)
                    {
                        output.Add(operatorStack.Pop());
                    }
                }
            }
        }

        // Pop remaining operators
        while (operatorStack.Count > 0)
        {
            if (operatorStack.Peek() != "(" && operatorStack.Peek() != ")")
            {
                output.Add(operatorStack.Pop());
            }
            else
            {
                operatorStack.Pop(); // Discard unmatched parentheses
            }
        }

        return output;
    }

    /// <summary>
    /// Evaluate an RPN expression
    /// </summary>
    private double EvaluateRPN(List<string> rpnTokens)
    {
        var evalStack = new Stack<double>();

        foreach (var token in rpnTokens)
        {
            if (double.TryParse(token, out double number))
            {
                evalStack.Push(number);
            }
            else if (_operators.ContainsKey(token))
            {
                var op = _operators[token];
                
                if (evalStack.Count < op.OperandCount)
                    throw new InvalidOperationException($"Insufficient operands for operator {token}");

                // Pop operands in reverse order
                var operands = new double[op.OperandCount];
                for (int i = op.OperandCount - 1; i >= 0; i--)
                {
                    operands[i] = evalStack.Pop();
                }

                var result = op.Execute(operands);
                evalStack.Push(result);
                
                // Update internal stack for display
                _stack.Clear();
                foreach (var val in evalStack.Reverse())
                    _stack.Push(val);
            }
        }

        if (evalStack.Count != 1)
            throw new InvalidOperationException("Invalid expression");

        return evalStack.Pop();
    }
}
