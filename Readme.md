# LATEX TO MARKDOWN CONVERTOR (COMPILER)

***Compiler for converting Latex documents to md documents using Flex, Bison and C++.*** 

### The features(tags) of LaTeX considered:-

    
|  ------------------FEATURES-----------------|
|---------|
|    \documentclass |
|   \usepackage
|   \title
|   \date
|   \begin{document}
|   \end{document}
|   \section
|   \subsection
|   \subsubsection
|   \par
|   \hrule
|   \textbf
|   \textit
|   \includegraphics
|   \href
|   \begin{verbatim}               
|   \end{verbatim}
|   \begin{itemize}
|   \end{itemize} 
|   \begin{enumerate}
|   \end{enumerate}
|   \begin{tabular}{|c|c|}
|   \hline 
|   \\
|   &
|   \end{tabular}

### File structure -->
```
latex2mdConvertor ( main directory )
    |-> ast_tree/ [ABSTRACT_SYNTAX_TREE]
    |       |-> ast.h (ast header file)
    |       |-> ast.cpp
    |
    |->images/
    |     |-> images.jpg
    |
    |-> src/  [SOURCE_FILES]
    |    |-> lexer.l 
    |    |-> parser.y
    |
    |->Traversor/ [SYNTAX_TO_SEMENTIC(markdown)]
    |      |-> traverse.h (Traverse header file)
    |      |-> traverse.cpp
    |
    |->   main.cpp [MAIN_FILE]
    |
    |->   Makefile [ALL necessory sequence of command]
    |
    |->   test.tex [TEST_FILE]
    |
    |->   googletest/ [gtest tools e.g. lgtest lgtest_main]
    |
    |->   lexer.o    [used for gtest]
    |->   parser.o   [used for gtest]
    |->   traverse.o [used for gtest]
    |
    |->   test.cpp   [MIAN TESTING file]
    |->   test       [output file of gtest]

```

## How To run code-
1. cd into latex2mdConvertor 
2. run- "make"
3. run ./latex2md.out test.tex output.md

## How To run gtest -
1. cd into latex2mdConvertor 
2. run- "flex src/lexer.l"
3. run- "bison -d src/parser.y"
4. run- "g++ -c lex.yy.c -o lexer.o "
5. run- "g++ -c parser.tab.c -o parser.o "
6. run- "g++ -c Traversor/traverse.cpp -o traverse.o"
7. run- "g++ test.cpp lexer.o parser.o traverse.o -lgtest -lgtest_main -o test"
8. run ./test
