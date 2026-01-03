namespace RPNCalc.Models;

/// <summary>
/// Square root operator - calculates √x
/// </summary>
public class SqrtOperator : IOperator
{
    public string Symbol => "√";
    public int OperandCount => 1;

    public double Execute(params double[] operands)
    {
        if (operands.Length != 1)
            throw new ArgumentException("Square root requires exactly 1 operand");

        if (operands[0] < 0)
            throw new ArgumentException("Cannot calculate square root of negative number");

        return Math.Sqrt(operands[0]);
    }
}