public class Calculator : ICalculator
{
    public IList<string> SupportedOperators { get; } = new List<string> { "+", "-", "*", "/", "^", "sqrt", "ln", "exp" };

    public IList<string> OperationsHelpText { get; } = new List<string>
    {
        "+ : Adds two numbers",
        "- : Subtracts second number from first",
        "* : Multiplies two numbers",
        "/ : Divides first number by second",
        "^ : Raises first number to the power of second number",
        "sqrt : Calculates the square root of a number",
        "ln : Calculates the natural logarithm of a number",
        "exp : Calculates e raised to the power of a number"
    };

    public double Calculate(IList<Token> tokens)
    {
        var stack = new Stack<double>();

        foreach (var token in tokens)
        {
            if (token.IsNumeric)
            {
                stack.Push(token.NumericValue);
            }
            else if (token.IsOperation)
            {
                if (token.Value == "sqrt" || token.Value == "ln" || token.Value == "exp")
                {
                    var operand = stack.Pop();
                    double result = token.Value switch
                    {
                        "sqrt" => Math.Sqrt(operand),
                        "ln" => Math.Log(operand),
                        "exp" => Math.Exp(operand),
                        _ => throw new InvalidOperationException("Unsupported operator")
                    };
                    stack.Push(result);
                }
                else
                {
                    var right = stack.Pop();
                    var left = stack.Pop();
                    double result = token.Value switch
                    {
                        "+" => left + right,
                        "-" => left - right,
                        "*" => left * right,
                        "/" => left / right,
                        "^" => Math.Pow(left, right),
                        _ => throw new InvalidOperationException("Unsupported operator")
                    };
                    stack.Push(result);
                }
            }
        }

        return stack.Pop();
    }
}