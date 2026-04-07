#include <iostream>
#include "tokens.h"

using namespace std;

    /* A safe copy of ours that isn't subject to be spoiled by Flex's internal processes */
string tokenValue;

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