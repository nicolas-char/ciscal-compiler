/* ========================================================================== */
/* SECTION 1: C/C++ Declarations, Flex Options, and Regular Expression Macros */
/* ========================================================================== */
%{
#include <iostream>
#include <string>

using namespace std;

enum TokenType {
    TOKEN_EOF = 0,

    /* Keywords */
    TOKEN_AND,
    TOKEN_DECLARE,
    TOKEN_DO,
    TOKEN_ELSE,
    TOKEN_ENDDECLARE,
    TOKEN_EXIT,
    TOKEN_PROCEDURE,
    TOKEN_FUNCTION,
    TOKEN_PRINT,
    TOKEN_CALL,
    TOKEN_IF,
    TOKEN_IN,
    TOKEN_INOUT,
    TOKEN_NOT,
    TOKEN_SELECT,
    TOKEN_PROGRAM,
    TOKEN_OR,
    TOKEN_RETURN,
    TOKEN_WHILE,
    TOKEN_DEFAULT,

    /* Assignment and Statement Terminator */
    TOKEN_ASSIGN,       /* := */
    TOKEN_SEMICOLON,    /* ;  */

    /* Arithmetic Operators */
    TOKEN_STAR,         /* *  */
    TOKEN_SLASH,        /* /  */
    TOKEN_PLUS,         /* +  */
    TOKEN_MINUS,        /* -  */

    /* Relational Operators */
    TOKEN_EQ,           /* =  */
    TOKEN_LT,           /* <  */
    TOKEN_GT,           /* >  */
    TOKEN_NEQ,          /* <> */
    TOKEN_LEQ,          /* <= */
    TOKEN_GEQ,          /* >= */

    /* Separators */
    TOKEN_LBRACE,       /* {  */
    TOKEN_RBRACE,       /* }  */
    TOKEN_COMMA,        /* ,  */

    /* Parentheses and Brackets */
    TOKEN_LPAREN,       /* (  */
    TOKEN_RPAREN,       /* )  */
    TOKEN_LBRACKET,     /* [  */
    TOKEN_RBRACKET,     /* ]  */

    /* Identifiers and Numbers */
    TOKEN_IDENTIFIER,
    TOKEN_NUMBER,

    /* Errors */
    TOKEN_UNKNOWN
};

    /* A safe copy of ours that isn't subject to be spoiled by Flex's internal processes */
string tokenValue;
%}

/* Flex options */
%option noyywrap
%option yylineno

/* Exclusive start state for comment handling */
%x COMMENT

/* Regular Expression Macros */
DIGIT       [0-9]
LETTER      [A-Za-z]
NUMBER      {DIGIT}+
WHITESPACE  [ \t\n\r]+
IDENTIFIER  {LETTER}({LETTER}|{DIGIT})*

/* ========================================================================== */
/* SECTION 2: Rules (Patterns and Actions)                                    */
/* ========================================================================== */
%%

    /* Comments */
"/*"            { BEGIN(COMMENT); }
<COMMENT>"*/"   { BEGIN(INITIAL); }
<COMMENT>\n     { /* Ignore newlines inside comments */ }
<COMMENT>.      { /* Ignore any other character inside comments */ }

    /* Keywords */
"and"           { return TOKEN_AND; }
"declare"       { return TOKEN_DECLARE; }
"do"            { return TOKEN_DO; }
"else"          { return TOKEN_ELSE; }
"enddeclare"    { return TOKEN_ENDDECLARE; }
"exit"          { return TOKEN_EXIT; }
"procedure"     { return TOKEN_PROCEDURE; }
"function"      { return TOKEN_FUNCTION; }
"print"         { return TOKEN_PRINT; }
"call"          { return TOKEN_CALL; }
"if"            { return TOKEN_IF; }
"in"            { return TOKEN_IN; }
"inout"         { return TOKEN_INOUT; }
"not"           { return TOKEN_NOT; }
"select"        { return TOKEN_SELECT; }
"program"       { return TOKEN_PROGRAM; }
"or"            { return TOKEN_OR; }
"return"        { return TOKEN_RETURN; }
"while"         { return TOKEN_WHILE; }
"default"       { return TOKEN_DEFAULT; }

    /* Assignment operator and statement terminator */
":="            { return TOKEN_ASSIGN; }
";"             { return TOKEN_SEMICOLON; }

    /* Arithmetic Operators */
"*"             { return TOKEN_STAR; }
"/"             { return TOKEN_SLASH; }
"+"             { return TOKEN_PLUS; }
"-"             { return TOKEN_MINUS; }

    /* Relational Operators */
"="             { return TOKEN_EQ; }
"<"             { return TOKEN_LT; }
">"             { return TOKEN_GT; }
"<>"            { return TOKEN_NEQ; }
"<="            { return TOKEN_LEQ; }
">="            { return TOKEN_GEQ; }

    /* Separators and Parenthesis */
"{"             { return TOKEN_LBRACE; }
"}"             { return TOKEN_RBRACE; }
","             { return TOKEN_COMMA; }
"("             { return TOKEN_LPAREN; }
")"             { return TOKEN_RPAREN; }
"["             { return TOKEN_LBRACKET; }
"]"             { return TOKEN_RBRACKET; }

    /* Identifier rule goes below keywords, because if `program` appeared after {IDENTIFIER}, 
    Flex would match it as an Identifier instead of a Keyword */
{IDENTIFIER}    { tokenValue = yytext; return TOKEN_IDENTIFIER; }

{NUMBER}        { tokenValue = yytext; return TOKEN_NUMBER; }

{WHITESPACE}    { /* Ignore whitespaces. Do nothing. */ }

    /* Catch-all: any unrecognized character is a lexical error */
.               { tokenValue = yytext; return TOKEN_UNKNOWN; }

%%
/* ========================================================================== */
/* SECTION 3: User Code (C/C++ functions)                                     */
/* ========================================================================== */

int main() {
    int token;

    cout << "Ciscal Lexer started...\n";
    cout << "Type something and press Enter (or Ctrl+D to exit):\n";
    
    /* Start the lexical analysis */
    while ((token = yylex()) != 0) {
        cout << "Token ID: " << token <<"\n";

        if (token == TOKEN_IDENTIFIER || token == TOKEN_NUMBER || token == TOKEN_UNKNOWN)
            cout << " (Value: " << tokenValue << ")";
        cout << "\n";
    }
    
    return 0;
}