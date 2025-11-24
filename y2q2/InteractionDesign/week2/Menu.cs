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