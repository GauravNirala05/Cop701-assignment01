all:
	flex src/lexer.l
	bison -d src/parser.y
	g++ main.cpp lex.yy.c parser.tab.c ast_tree/ast.cpp -o latex2md -lfl	
	rm lex.yy.c parser.tab.h parser.tab.c 
