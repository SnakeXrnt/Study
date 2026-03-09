namespace RPNCalc.Models;

/// <summary>
/// Sine operator - calculates sin(x) where x is in radians
/// </summary>
public class SinOperator : IOperator
{
    public string Symbol => "sin";
    public int OperandCount => 1;

    public double Execute(params double[] operands)
    {
        if (operands.Length != 1)
            throw new ArgumentException("Sin requires exactly 1 operand");

        return Math.Sin(operands[0]);
    }
}