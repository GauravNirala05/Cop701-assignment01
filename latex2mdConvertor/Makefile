compiler:
	flex src/lexer.l
	bison -d src/parser.y
	g++ main.cpp lex.yy.c parser.tab.c ast_tree/ast.cpp Traversor/Traverse.cpp -o latex2md.out -lfl	
	rm lex.yy.c parser.tab.h parser.tab.c 

gtest:
	flex src/lexer.l
	bison -d src/parser.y
	g++ -c lex.yy.c -o lexer.o
	g++ -c parser.tab.c -o parser.o
	g++ -c Traversor/traverse.cpp -o traverse.o
	g++ test.cpp lexer.o parser.o traverse.o -lgtest -lgtest_main -o gtest_result
	rm lex.yy.c parser.tab.h parser.tab.c lexer.o parser.o traverse.o







