namespace RPNCalc.Models;

/// <summary>
/// Logarithm operator - calculates log10(x)
/// </summary>
public class LogOperator : IOperator
{
    public string Symbol => "log";
    public int OperandCount => 1;

    public double Execute(params double[] operands)
    {
        if (operands.Length != 1)
            throw new ArgumentException("Log requires exactly 1 operand");

        if (operands[0] <= 0)
            throw new ArgumentException("Log requires positive number");

        return Math.Log10(operands[0]);
    }
}