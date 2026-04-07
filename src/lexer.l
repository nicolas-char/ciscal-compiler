/* ========================================================================== */
/* SECTION 1: C/C++ Declarations, Flex Options, and Regular Expression Macros */
/* ========================================================================== */
%{
#include <iostream>
#include <string>
#include "tokens.h"
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