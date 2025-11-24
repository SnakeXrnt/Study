public interface ICalculator
{
    // Properties
    public IList<string> SupportedOperators { get; }

    public IList<string> OperationsHelpText { get; }

    // Methods
    public double Calculate(IList<Token> tokens);
}