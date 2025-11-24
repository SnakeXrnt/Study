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
