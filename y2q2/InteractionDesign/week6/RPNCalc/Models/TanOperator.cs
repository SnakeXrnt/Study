namespace RPNCalc.Models;

/// <summary>
/// Tangent operator - calculates tan(x) where x is in radians
/// </summary>
public class TanOperator : IOperator
{
    public string Symbol => "tan";
    public int OperandCount => 1;

    public double Execute(params double[] operands)
    {
        if (operands.Length != 1)
            throw new ArgumentException("Tan requires exactly 1 operand");

        return Math.Tan(operands[0]);
    }
}