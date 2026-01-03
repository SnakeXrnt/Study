using RPNCalc.ViewModels;

namespace RPNCalc;

/// <summary>
/// MainPage code-behind - Minimal logic with keyboard support
/// Business logic is in CalculatorViewModel
/// </summary>
public partial class MainPage : ContentPage
{
	private CalculatorViewModel ViewModel => (CalculatorViewModel)BindingContext;

	public MainPage()
	{
		InitializeComponent();
		
		// Focus the keyboard entry when page loads to enable keyboard input
		Loaded += (s, e) => KeyboardEntry?.Focus();
	}

	private void OnKeyboardTextChanged(object sender, TextChangedEventArgs e)
	{
		var entry = (Entry)sender;
		if (string.IsNullOrEmpty(e.NewTextValue))
			return;

		// Get the last character entered
		char key = e.NewTextValue[^1];

		// Process the key
		if (char.IsDigit(key))
		{
			ViewModel.NumberCommand.Execute(key.ToString());
		}
		else
		{
			switch (key)
			{
				case '+':
				case '-':
				case '×':
				case '*':
				case '÷':
				case '/':
					string op = key == '*' ? "×" : (key == '/' ? "÷" : key.ToString());
					ViewModel.OperatorCommand.Execute(op);
					break;
				case '.':
					ViewModel.DecimalCommand.Execute(null);
					break;
				case 'c':
				case 'C':
					ViewModel.ClearCommand.Execute(null);
					break;
				case '\r':
				case '\n':
				case '=':
					ViewModel.EqualsCommand.Execute(null);
					break;
				case '\b': // Backspace key
					ViewModel.BackspaceCommand.Execute(null);
					break;
			}
		}

		// Clear the entry to capture the next key
		entry.Text = string.Empty;
	}
}

