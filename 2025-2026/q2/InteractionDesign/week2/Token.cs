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
