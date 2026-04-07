#pragma once
#include <string>

extern std::string tokenValue;
extern int yylex();

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

