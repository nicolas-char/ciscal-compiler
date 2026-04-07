all:
	flex -o src/lex.yy.c src/lexer.l
	g++ src/lex.yy.c src/main.cpp -o compiler.out

clean:
	rm -f src/lex.yy.c compiler.out