import java_cup.runtime.*;

%%
%class Lexer
%unicode
%cup
%line
%column
%states IN_COMMENT
%{
  private StringBuffer string = new StringBuffer();

  private Symbol symbol(int type) {
    return new Symbol(type, yyline, yycolumn);
  }
  private Symbol symbol(int type, Object value) {
    return new Symbol(type, yyline, yycolumn, value);
  }
%}

whitespace = " "|\r|\t|\r\t|"\n"
letters = [a-zA-Z]
digits = [0-9]
integers = 0|-?[1-9]{digits}*("_"-?{digits}+)?
rationals = (integers"_"|floats"_")?{integers}"/"[1-9]{digits}*
floats = {integers}"."{digits}+("_"{integers}|"_"{integers}"."{digits}+|"_"{rationals})?
character = "'"[^\n]"'"
comments = {commentHelp}|{singleLineComment}
commentHelp = "/#" ~"#/"
singleLineComment = "#"[^\r\n]*
identifiers = {letters}{idHelp}*
idHelp = "_"|{letters}|{digits}

%state STRING_LITERAL

%%


<YYINITIAL> {
    /* Data types */
    "char"                          { return symbol(sym.CHARACTER); }
    "int"                           { return symbol(sym.INTEGER); }
    "rat"                           { return symbol(sym.RATIONAL); }
    "float"                         { return symbol(sym.FLOAT); }
    "bool"                          { return symbol(sym.BOOLEAN); }
    "top"                           { return symbol(sym.TOP); }

    /* Keywords */
    "break"                         { return symbol(sym.BREAK); }
    "return"                        { return symbol(sym.RETURN); }
    "T"                             { return symbol(sym.TRUE); }
    "F"                             { return symbol(sym.FALSE); }
    "loop"                          { return symbol(sym.LOOP); }
    "pool"                          { return symbol(sym.POOL); }
    "if"                            { return symbol(sym.IF); }
    "fi"                            { return symbol(sym.FI); }
    "lambda"                        { return symbol(sym.LAMBDA); }
    "seq"                           { return symbol(sym.SEQUENCE); }
    "for"                           { return symbol(sym.FOR); }
    "in"                            { return symbol(sym.IN); }
    "tdef"                          { return symbol(sym.TDEF); }
    "fdef"                          { return symbol(sym.FDEF); }
    "alias"                         { return symbol(sym.ALIAS); }
    "else"                          { return symbol(sym.ELSE); }
    "main"                          { return symbol(sym.MAIN); }
    "print"                         { return symbol(sym.PRINT); }
    "read"                          { return symbol(sym.READ); }
    "then"                          { return symbol(sym.THEN); }

    /* Operators */
    "!"                             { return symbol(sym.NOT); }
    "&&"                            { return symbol(sym.AND); }
    "||"                            { return symbol(sym.OR); }
    "="                             { return symbol(sym.EQ); }
    ":="                            { return symbol(sym.ASSIGN); }
    "!="                            { return symbol(sym.NOTEQ); }
    "::"                            { return symbol(sym.CONCAT); }
    "<="                            { return symbol(sym.LESSEQ); }
    "<"                             { return symbol(sym.LESS); }
    ">="                            { return symbol(sym.GREATEQ); }
    ">"                             { return symbol(sym.GREAT); }
    "+"                             { return symbol(sym.ADD); }
    "-"                             { return symbol(sym.MINUS); }
    "*"                             { return symbol(sym.TIMES); }
    "/"                             { return symbol(sym.DIVIDE); }
    "^"                             { return symbol(sym.POWER); }
    "in"                            { return symbol(sym.IN); }

    /* Symbols */
    "["                             { return symbol(sym.LEFTBRACK); }
    "]"                             { return symbol(sym.RIGHTBRACK); }
    ","                             { return symbol(sym.COMMA); }
    "("                             { return symbol(sym.LEFTPAREN); }
    ")"                             { return symbol(sym.RIGHTPAREN); }
    "{"                             { return symbol(sym.LEFTCURLY); }
    "}"                             { return symbol(sym.RIGHTCURLY); }
    ";"                             { return symbol(sym.SEMICOLON); }
    ":"                             { return symbol(sym.COLON); }
    "."                             { return symbol(sym.DOT); }

   /* Literals */
   {identifiers}                    { return symbol(sym.ID, yytext()); }
   {floats}                         { return symbol(sym.FLOATID, yytext()); }
   {rationals}                      { return symbol(sym.RATIONALID, yytext()); }
   {integers}                       { return symbol(sym.INTID, yytext()); }
   {character}                      { return symbol(sym.CHARID, yytext().charAt(1)); }
    \"                              { yybegin(STRING_LITERAL); }


    /* Do nothing */
    {comments}                       {  }
    {whitespace}                     {  }

}




<STRING_LITERAL> {
    \"                              { yybegin(YYINITIAL); return symbol(
                                        sym.STRING, string.toString()); }
    [^\r\n\\\"]+                    { string.append(yytext()); }
    "\\t"                           { string.append('\t'); }
    "\\n"                           { string.append('\n'); }
    "\\r"                           { string.append('\r'); }
    "\\\""                          { string.append('\"'); }
    "\\b"                           { string.append('\b'); }
}

/* error fallback */
[^]  {
    System.out.println("Error in line "
        + (yyline+1) +": Invalid input '" + yytext()+"'");
    return symbol(sym.ILLEGAL_CHARACTER);
}
