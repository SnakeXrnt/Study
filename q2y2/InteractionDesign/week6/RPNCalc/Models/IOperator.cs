namespace RPNCalc.Models;

/// <summary>
/// Interface for mathematical operators in the RPN calculator
/// </summary>
public interface IOperator
{
    /// <summary>
    /// The symbol representing this operator (e.g., "+", "-", "×", "÷")
    /// </summary>
    string Symbol { get; }

    /// <summary>
    /// The number of operands this operator requires
    /// </summary>
    int OperandCount { get; }

    /// <summary>
    /// Execute the operation on the provided operands
    /// </summary>
    /// <param name="operands">Array of operands (order matters for non-commutative operations)</param>
    /// <returns>The result of the operation</returns>
    double Execute(params double[] operands);
}
