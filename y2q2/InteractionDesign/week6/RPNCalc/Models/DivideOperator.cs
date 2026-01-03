namespace RPNCalc.Models;

/// <summary>
/// Division operator (÷)
/// </summary>
public class DivideOperator : IOperator
{
    public string Symbol => "÷";
    public int OperandCount => 2;

    public double Execute(params double[] operands)
    {
        if (operands.Length < OperandCount)
            throw new ArgumentException($"Operator {Symbol} requires {OperandCount} operands");
        
        if (operands[1] == 0)
            throw new DivideByZeroException("Cannot divide by zero");
        
        return operands[0] / operands[1];
    }
}
