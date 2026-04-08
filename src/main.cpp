#include <iostream>
#include "tokens.h"

extern int yylineno;

using namespace std;

    /* A safe copy of ours that isn't subject to be spoiled by Flex's internal processes */
string tokenValue;

    /* Holds the Token's tpye (ID produced by enum). 
    `tokenValue is what holds the lexema` */
int currentToken;

void nextToken() {
    currentToken = yylex();
}

void match(int expectedToken) {
    if (currentToken == expectedToken)
        nextToken();
    else {
        cout << "Syntax Error: Expected token " << expectedToken
            << " but found " << currentToken << " at line " << yylineno << "\n";
            exit(1);
    }
}

void parseSequence() {
    cout << " [Dummy Sequence] ";
}

void parseSubprograms() {
    cout << " [Dummy Subprograms] ";
}

void parseVarList() {    /* Done */
    if (currentToken == TOKEN_IDENTIFIER) {
        match(TOKEN_IDENTIFIER);
        while (currentToken == TOKEN_COMMA) {
            match(TOKEN_COMMA);
            match(TOKEN_IDENTIFIER);
        }
    }
}

void parseDeclarations() {   /* Done */
    if (currentToken == TOKEN_DECLARE) {
        match(TOKEN_DECLARE);
        parseVarList();
        match(TOKEN_ENDDECLARE);
    }
}

void parseBlock() {
    match(TOKEN_LBRACE);
    parseDeclarations();
    parseSubprograms();
    parseSequence();
    match(TOKEN_RBRACE);
}

void parseProgram() {
    match(TOKEN_PROGRAM);
    match(TOKEN_IDENTIFIER);
    parseBlock();
}

int main() {
    cout << "Ciscal Compiler started...\n";

    nextToken();
    parseProgram();
    
    if (currentToken == TOKEN_EOF)
        cout << "Parsing completed successfully!\n";
    else
        cout << "Syntax Error: Unexpected tokens at the end of file.\n";
    
    return 0;
}