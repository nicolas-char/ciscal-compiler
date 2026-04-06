/* ========================================================================== */
/* SECTION 1: C/C++ Declarations, Flex Options, and Regular Expression Macros */
/* ========================================================================== */
%{
#include <iostream>
using namespace std;
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
"and"           { cout << "FOUND KEYWORD: and\n"; }
"declare"       { cout << "FOUND KEYWORD: declare\n"; }
"do"            { cout << "FOUND KEYWORD: do\n"; }
"else"          { cout << "FOUND KEYWORD: else\n"; }
"enddeclare"    { cout << "FOUND KEYWORD: enddeclare\n"; }
"exit"          { cout << "FOUND KEYWORD: exit\n"; }
"procedure"     { cout << "FOUND KEYWORD: procedure\n"; }
"function"      { cout << "FOUND KEYWORD: function\n"; }
"print"         { cout << "FOUND KEYWORD: print\n"; }
"call"          { cout << "FOUND KEYWORD: call\n"; }
"if"            { cout << "FOUND KEYWORD: if\n"; }
"in"            { cout << "FOUND KEYWORD: in\n"; }
"inout"         { cout << "FOUND KEYWORD: inout\n"; }
"not"           { cout << "FOUND KEYWORD: not\n"; }
"select"        { cout << "FOUND KEYWORD: select\n"; }
"program"       { cout << "FOUND KEYWORD: program\n"; }
"or"            { cout << "FOUND KEYWORD: or\n"; }
"return"        { cout << "FOUND KEYWORD: return\n"; }
"while"         { cout << "FOUND KEYWORD: while\n"; }
"default"       { cout << "FOUND KEYWORD: default\n"; }

    /* Assignment operator and statement terminator */
":="            { cout << "FOUND ASSIGNMENT: :=\n"; }
";"             { cout << "FOUND SEMICOLON: ;\n"; }

    /* Arithmetic Operators */
"*"             { cout << "FOUND OPERATOR: *\n"; }
"/"             { cout << "FOUND OPERATOR: /\n"; }
"+"             { cout << "FOUND OPERATOR: +\n"; }
"-"             { cout << "FOUND OPERATOR: -\n"; }

    /* Relational Operators */
"="             { cout << "FOUND RELATIONAL OPERATOR: =\n"; }
"<"             { cout << "FOUND RELATIONAL OPERATOR: <\n"; }
">"             { cout << "FOUND RELATIONAL OPERATOR: >\n"; }
"<>"            { cout << "FOUND RELATIONAL OPERATOR: <>\n"; }
"<="            { cout << "FOUND RELATIONAL OPERATOR: <=\n"; }
">="            { cout << "FOUND RELATIONAL OPERATOR: >=\n"; }

    /* Separators and Parenthesis */
"{"            { cout << "FOUND SEPARATOR: {\n"; }
"}"            { cout << "FOUND SEPARATOR: }\n"; }
","            { cout << "FOUND SEPARATOR: ,\n"; }
"("            { cout << "FOUND LEFT PARENTHESIS\n"; }
")"            { cout << "FOUND RIGHT PARENTHESIS\n"; }
"["            { cout << "FOUND LEFT BRACKET\n"; }
"]"            { cout << "FOUND RIGHT BRACKET\n"; }

    /* Identifier rule goes below keywords, because if `program` appeared after {IDENTIFIER}, 
    Flex would match it as an Identifier instead of a Keyword */
{IDENTIFIER}    { cout << "FOUND IDENTIFIER: " << yytext << "\n"; }

{NUMBER}        { cout << "FOUND NUMBER: " << yytext << "\n"; }

{WHITESPACE}    { /* Ignore whitespaces. Do nothing. */ }

    /* Catch-all: any unrecognized character is a lexical error */
.               { cout << "UNKNOWN CHARACTER: " << yytext << "\n"; }

%%
/* ========================================================================== */
/* SECTION 3: User Code (C/C++ functions)                                     */
/* ========================================================================== */

int main() {
    cout << "Ciscal Lexer started...\n";
    cout << "Type something and press Enter (or Ctrl+D to exit):\n";
    
    /* Start the lexical analysis */
    yylex(); 
    
    return 0;
}