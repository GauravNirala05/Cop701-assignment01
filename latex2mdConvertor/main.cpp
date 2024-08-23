
#include <stdio.h>
#include <iostream>
#include <fstream>
#include "ast_tree/ast.h"
#include "Traversor/traverse.h"
using namespace std;

extern int yyparse();

Tree *root;

extern FILE *yyin;

void yyerror(const char *s)
{
    printf("ERROR : %s \n", s);
}


int main(int arg, char *args[])
{
    if (arg < 3)
    {
        std::cout << "ERROR : Enter 3 args to run --> <compiler> and <input_file.tex> and <output_file.md> \n\t\t--> (e.g ./latex2md.out test.tex output.md)\n";
        return 0;
    }
    else
    {
        yyin = fopen(args[1], "r");
        do
        {
            yyparse();
        } while (!feof(yyin));
        std::cout << "\n################################################################################\n";
        std::cout << "PRINTING AST TREE : " << endl;
        printTree(root);
        string result = "";
        if (root->dtype == PROGRAM_BEGINING)
        {
            std::cout << "\n\n################################################################################\n";
            std::cout << "Traversing the AST :" << endl;
            result = Traverse(root->child);
            //cout<<Traverse(root->next); //for header file traversal
        }
        std::cout << result;
        ofstream out(args[2]);
        out << result;
        return 0;
    }
}
