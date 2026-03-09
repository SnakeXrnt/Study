using System.ComponentModel;
using System.Runtime.CompilerServices;
using System.Windows.Input;
using RPNCalc.Models;

namespace RPNCalc.ViewModels;

/// <summary>
/// ViewModel for the RPN Calculator following MVVM pattern
/// Implements INotifyPropertyChanged for data binding
/// </summary>
public class CalculatorViewModel : INotifyPropertyChanged
{
    private readonly RPNCalculator _calculator;
    private string _currentExpression;
    private string _result;
    private string _rpnNotation;
    private string _errorMessage;

    public event PropertyChangedEventHandler? PropertyChanged;

    public CalculatorViewModel()
    {
        _calculator = new RPNCalculator();
        _currentExpression = "";
        _result = "0";
        _rpnNotation = "RPN: (empty)";
        _errorMessage = "";

        // Initialize commands
        NumberCommand = new Command<string>(OnNumberPressed);
        OperatorCommand = new Command<string>(OnOperatorPressed);
        EqualsCommand = new Command(OnEqualsPressed);
        ClearCommand = new Command(OnClearPressed);
        DecimalCommand = new Command(OnDecimalPressed);
        EnterCommand = new Command(OnEnterPressed);
        BackspaceCommand = new Command(OnBackspacePressed);
    }

    #region Properties (Bound to UI)

    /// <summary>
    /// Current expression being entered by user (normal notation)
    /// </summary>
    public string CurrentExpression
    {
        get => _currentExpression;
        set
        {
            _currentExpression = value;
            OnPropertyChanged();
            OnPropertyChanged(nameof(HasExpression));
        }
    }

    /// <summary>
    /// Result of the calculation
    /// </summary>
    public string Result
    {
        get => _result;
        set
        {
            _result = value;
            OnPropertyChanged();
        }
    }

    /// <summary>
    /// RPN notation display (shows the stack/conversion)
    /// </summary>
    public string RpnNotation
    {
        get => _rpnNotation;
        set
        {
            _rpnNotation = value;
            OnPropertyChanged();
        }
    }

    /// <summary>
    /// Error message (user-friendly)
    /// </summary>
    public string ErrorMessage
    {
        get => _errorMessage;
        set
        {
            _errorMessage = value;
            OnPropertyChanged();
            OnPropertyChanged(nameof(HasError));
        }
    }

    /// <summary>
    /// Indicates if there's an error to display
    /// </summary>
    public bool HasError => !string.IsNullOrEmpty(ErrorMessage);

    /// <summary>
    /// Indicates if there's an expression being typed
    /// </summary>
    public bool HasExpression => !string.IsNullOrEmpty(CurrentExpression);

    #endregion

    #region Commands (Bound to Buttons)

    public ICommand NumberCommand { get; }
    public ICommand OperatorCommand { get; }
    public ICommand EqualsCommand { get; }
    public ICommand ClearCommand { get; }
    public ICommand DecimalCommand { get; }
    public ICommand EnterCommand { get; }
    public ICommand BackspaceCommand { get; }

    #endregion

    #region Command Handlers

    private void OnNumberPressed(string number)
    {
        ClearError();
        CurrentExpression += number;
    }

    private void OnEnterPressed()
    {
        // ENTER key evaluates the expression (same as "=")
        OnEqualsPressed();
    }

    private void OnBackspacePressed()
    {
        if (!string.IsNullOrEmpty(CurrentExpression))
        {
            CurrentExpression = CurrentExpression.Substring(0, CurrentExpression.Length - 1);
        }
    }

    private void OnOperatorPressed(string op)
    {
        ClearError();
        
        // Convert × and ÷ to standard symbols for parsing
        string standardOp = op switch
        {
            "×" => "*",
            "÷" => "/",
            _ => op
        };
        
        CurrentExpression += " " + standardOp + " ";
    }

    private void OnDecimalPressed()
    {
        ClearError();
        CurrentExpression += ".";
    }

    private void OnEqualsPressed()
    {
        ClearError();

        try
        {
            if (string.IsNullOrWhiteSpace(CurrentExpression))
            {
                ErrorMessage = "Please enter an expression";
                return;
            }

            // Show RPN notation BEFORE evaluation
            UpdateRpnNotation();

            // Evaluate the expression using RPN internally
            var result = _calculator.Evaluate(CurrentExpression);
            Result = result.ToString();

            // Clear expression for next calculation
            CurrentExpression = "";

            // Keep the result for potential continued calculation
            CurrentExpression = "";
        }
        catch (DivideByZeroException)
        {
            ErrorMessage = "Error: Cannot divide by zero";
            Result = "Error";
            CurrentExpression = "";
        }
        catch (InvalidOperationException ex)
        {
            ErrorMessage = $"Error: {ex.Message}";
            Result = "Error";
            CurrentExpression = "";
        }
        catch (Exception ex)
        {
            ErrorMessage = $"Error: {ex.Message}";
            Result = "Error";
            CurrentExpression = "";
        }
    }

    private void OnClearPressed()
    {
        CurrentExpression = "";
        Result = "0";
        RpnNotation = "RPN: (empty)";
        ClearError();
        _calculator.Clear();
    }

    #endregion

    #region Helper Methods

    private void UpdateRpnNotation()
    {
        var rpnString = _calculator.GetRPNNotation(CurrentExpression);
        RpnNotation = "RPN: " + rpnString;
    }

    private void ClearError()
    {
        ErrorMessage = "";
    }

    protected void OnPropertyChanged([CallerMemberName] string? propertyName = null)
    {
        PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(propertyName));
    }

    #endregion
}
