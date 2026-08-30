namespace RPNCalc.Models;

/// <summary>
/// Cosine operator - calculates cos(x) where x is in radians
/// </summary>
public class CosOperator : IOperator
{
    public string Symbol => "cos";
    public int OperandCount => 1;

    public double Execute(params double[] operands)
    {
        if (operands.Length != 1)
            throw new ArgumentException("Cos requires exactly 1 operand");

        return Math.Cos(operands[0]);
    }
}