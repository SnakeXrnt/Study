## calculator.cs
```cs
public class Calculator : ICalculator
{
    public IList<string> SupportedOperators { get; } = new List<string> { "+", "-", "*", "/", "^", "sqrt", "ln", "exp" };

    public IList<string> OperationsHelpText { get; } = new List<string>
    {
        "+ : Adds two numbers",
        "- : Subtracts second number from first",
        "* : Multiplies two numbers",
        "/ : Divides first number by second",
        "^ : Raises first number to the power of second number",
        "sqrt : Calculates the square root of a number",
        "ln : Calculates the natural logarithm of a number",
        "exp : Calculates e raised to the power of a number"
    };

    public double Calculate(IList<Token> tokens)
    {
        var stack = new Stack<double>();

        foreach (var token in tokens)
        {
            if (token.IsNumeric)
            {
                stack.Push(token.NumericValue);
            }
            else if (token.IsOperation)
            {
                if (token.Value == "sqrt" || token.Value == "ln" || token.Value == "exp")
                {
                    if (stack.Count() < 1) {
                        throw new InvalidOperationException("cannot calculate, some number is missing");
                    }
                    var operand = stack.Pop();
                    double result = token.Value switch
                    {
                        "sqrt" => Math.Sqrt(operand),
                        "ln" => Math.Log(operand),
                        "exp" => Math.Exp(operand),
                        _ => throw new InvalidOperationException("Unsupported operator")
                    };
                    stack.Push(result);
                }
                else
                {
                    if (stack.Count() < 2) {
                        throw new InvalidOperationException("cannot calculate, some number is missing");
                    }
                    var right = stack.Pop();
                    var left = stack.Pop();
                    double result = token.Value switch
                    {
                        "+" => left + right,
                        "-" => left - right,
                        "*" => left * right,
                        "/" => right == 0 ? throw new DivideByZeroException("division by zero ? monkey type of calculation") : left / right,
                        "^" => Math.Pow(left, right),
                        _ => throw new InvalidOperationException("Unsupported operator")
                    };
                    stack.Push(result);
                }
            }
        }


        return stack.Pop();
    }
}

```

## controller.cs
```cs
public class Calculator : ICalculator
{
    public IList<string> SupportedOperators { get; } = new List<string> { "+", "-", "*", "/", "^", "sqrt", "ln", "exp" };

    public IList<string> OperationsHelpText { get; } = new List<string>
    {
        "+ : Adds two numbers",
        "- : Subtracts second number from first",
        "* : Multiplies two numbers",
        "/ : Divides first number by second",
        "^ : Raises first number to the power of second number",
        "sqrt : Calculates the square root of a number",
        "ln : Calculates the natural logarithm of a number",
        "exp : Calculates e raised to the power of a number"
    };

    public double Calculate(IList<Token> tokens)
    {
        var stack = new Stack<double>();

        foreach (var token in tokens)
        {
            if (token.IsNumeric)
            {
                stack.Push(token.NumericValue);
            }
            else if (token.IsOperation)
            {
                if (token.Value == "sqrt" || token.Value == "ln" || token.Value == "exp")
                {
                    if (stack.Count() < 1) {
                        throw new InvalidOperationException("cannot calculate, some number is missing");
                    }
                    var operand = stack.Pop();
                    double result = token.Value switch
                    {
                        "sqrt" => Math.Sqrt(operand),
                        "ln" => Math.Log(operand),
                        "exp" => Math.Exp(operand),
                        _ => throw new InvalidOperationException("Unsupported operator")
                    };
                    stack.Push(result);
                }
                else
                {
                    if (stack.Count() < 2) {
                        throw new InvalidOperationException("cannot calculate, some number is missing");
                    }
                    var right = stack.Pop();
                    var left = stack.Pop();
                    double result = token.Value switch
                    {
                        "+" => left + right,
                        "-" => left - right,
                        "*" => left * right,
                        "/" => right == 0 ? throw new DivideByZeroException("division by zero ? monkey type of calculation") : left / right,
                        "^" => Math.Pow(left, right),
                        _ => throw new InvalidOperationException("Unsupported operator")
                    };
                    stack.Push(result);
                }
            }
        }


        return stack.Pop();
    }
}

```

## icalculator.cs
```cs
public interface ICalculator
{
    // Properties
    public IList<string> SupportedOperators { get; }

    public IList<string> OperationsHelpText { get; }

    // Methods
    public double Calculate(IList<Token> tokens);
}
```

## imenu.cs
```cs
public interface IMenu
{
    public void ShowMenu();
    public void ShowHelp();
    public void ShowOperations();

    public IList<string> OperationsHelpText { get; }
}

```

## iparser.cs
```cs
public interface IParser {
    public IList<string> SupportedOperators{get; set;}
    public IList<string> Tokenize(string expression);
    public IList<Token> Lex(IList<string> tokens);
}
```

## menu.cs
```cs
public class Menu : IMenu
{
    //Properties
    public IList<string> OperationsHelpText { get; set; } 
    
    //Constructors
    public Menu(IList<string> operationsHelp)
    {
        this.OperationsHelpText = operationsHelp;
    }
    
    //Methods
    public void ShowMenu()
    {
        Console.WriteLine("RPN Calculator\n" +
                          "Enter an RPN expression to evaluate.\n" +
                          "Enter '(h)elp' for help.\n" +
                          "Enter '(o)ps' for available operations.\n" +
                          "Enter '(q)uit' to exit.");
    }

    public void ShowHelp()
    {
        Console.WriteLine("Enter expressions using RPN notation, for instance to calculate:\n" +
                          "2 + 3 * 4\n" +
                          "enter '2 3 4 * +'\n" +
                          "enter (o)ps to see available operations");
    }

    public void ShowOperations()
    {
        
        foreach (var s in OperationsHelpText)
        {
            Console.WriteLine(s);
        }
    }
}

```

## parser.cs
```cs
public class Parser : IParser {
    public IList<string> SupportedOperators {get; set;}

    public Parser(IList<string> supportedOperators) {
        SupportedOperators = supportedOperators;
    }

    public IList<string> Tokenize(string expressions) {
        if (string.IsNullOrWhiteSpace(expressions)) {
            return new List<string>();
        }
        var TokenizedList = new List<string>();
        string[] separate = expressions.Split(' ');
        foreach (var s in separate) {
            TokenizedList.Add(s);
        }
        return TokenizedList;
    }

    public IList<Token> Lex(IList<string> tokens) {
        var ListofTokens = new List<Token>();
        foreach (var t in tokens) {
            if(double.TryParse(t, out _)) {
                ListofTokens.Add(new Token(TokenType.NUMBER,t));
            } else if (SupportedOperators.Contains(t)){
                ListofTokens.Add(new Token(TokenType.OPERATOR, t));
            } else {
                throw new ArgumentOutOfRangeException($"Invalid Operator: {t}");
            }
            
        }
        return ListofTokens;
    }

}

```

## Program.cs
```


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

```

## token.cs
```cpp
public enum TokenType { 
    NUMBER,
    OPERATOR
}

public class Token {
    public TokenType TokenType{get;}

    public string Value{get;}

    public double NumericValue{get;}

    public bool IsNumeric => TokenType == TokenType.NUMBER;

    public bool IsOperation => TokenType == TokenType.OPERATOR;

    public Token(TokenType type, string value) {
        TokenType = type;
        Value = value;
        if (type == TokenType.NUMBER) {
            NumericValue = double.Parse(value);
        }
    }
}

```