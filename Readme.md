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
    |->   latex2md.out [COMPILER]
    |
    |->   Makefile [ALL necessory sequence of command]
    |
    |->   test.tex [TEST_LATEX_FILE]
    |
    |->   googletest/ [gtest tools e.g. lgtest lgtest_main]
    |
    |->   test.cpp   [MIAN TESTING file]
    |
    |->   gtest_result     [output file of gtest]

```

## How To run code-
1. cd into latex2mdConvertor 
2. run- "make compiler"
3. run ./latex2md.out test.tex output.md
4. 

## How To run gtest -
1. cd into latex2mdConvertor 
2. run- "make gtest"
8. run ./gtest_result
