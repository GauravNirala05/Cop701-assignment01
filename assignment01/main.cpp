
#include <stdio.h>
#include <iostream>
#include "ast_tree/ast.h"
using namespace std;

extern int yyparse();

Tree *root;

extern FILE *yyin;

void yyerror(const char *s)
{
    printf("ERROR : %s \n", s);
}

string Traverse(Tree *head)
{
    string s = "";
    if (head != NULL)
    {
        // cout<<head->data<<endl;
        if (head->dtype == D_SECTION)
        {
            s += "#";
            s += string(Traverse(head->child));
            s += string(Traverse(head->next));
        }
        if (head->dtype == D_SUB_SECTION)
        {
            s += "##";
            s = s + Traverse(head->child);
            s = s + Traverse(head->next);
        }
        if (head->dtype == D_SUBSUB_SECTION)
        {
            s += "###";
            s += string(Traverse(head->child));
            s += string(Traverse(head->next));
        }
        if (head->dtype == D_ITALIC)
        {
            s += "*";
            s += Traverse(head->child);
            s += "*\n";
            s += Traverse(head->next);
        }
        if (head->dtype == D_BOLD)
        {
            s += "***";
            s += Traverse(head->child);
            s += "***\n";
            s += Traverse(head->next);
        }
        if (head->dtype == D_NEWLINE)
        {
            s += "\n";
            s += string(Traverse(head->child));
            s += string(Traverse(head->next));
        }
        if (head->dtype == D_INFORMATION)
        {
            s += string(head->data);
        }
        return s;
    }
    return s;
}

int main(int arg, char *args[])
{
    if (arg < 2)
    {
        cout << "ERROR : Enter 2 args to run <compiler> and <input_file> --> (e.g ./latex2md.out test.tex)\n";
        return 0;
    }
    else
    {
        yyin = fopen(args[1], "r");
        do
        {
            yyparse();
        } while (!feof(yyin));

        cout << "PRINTING AST TREE : " << endl;
        printTree(root, 0);
        string result = "";
        if (root->dtype == PROGRAM_BEGINING)
        {
            result = Traverse(root->next);
        }
        cout << result;
    }
}
