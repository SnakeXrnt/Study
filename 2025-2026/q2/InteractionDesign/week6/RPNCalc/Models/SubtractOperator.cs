namespace RPNCalc.Models;

/// <summary>
/// Subtraction operator (-)
/// </summary>
public class SubtractOperator : IOperator
{
    public string Symbol => "-";
    public int OperandCount => 2;

    public double Execute(params double[] operands)
    {
        if (operands.Length < OperandCount)
            throw new ArgumentException($"Operator {Symbol} requires {OperandCount} operands");
        
        return operands[0] - operands[1];
    }
}
