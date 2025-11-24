public interface IMenu
{
    public void ShowMenu();
    public void ShowHelp();
    public void ShowOperations();

    public IList<string> OperationsHelpText { get; }
}