

public class Program
{
    static void Main(string[] args)
    {
        var calculator = new Calculator();
        var parser = new Parser(calculator.SupportedOperators);
        var menu = new Menu(calculator.OperationsHelpText);
        var controller = new Controller(calculator, parser, menu);
        controller.Run();
    }
}
