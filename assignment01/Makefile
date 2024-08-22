all:
	flex lexer.l
	bison -d parser.y
	g++ main.cpp lex.yy.c parser.tab.c ast.cpp -lfl	
	rm lex.yy.c parser.tab.h parser.tab.c 
