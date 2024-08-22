
#include <stdio.h>
#include <iostream>
#include "ast_tree/ast.h"
using namespace std;

extern int yyparse();

Tree *root;

void yyerror(const char *s)
{
    printf("ERROR : %s \n", s);
}

void Traverse(Tree *head)
{
    if (head != NULL)
    {
        // cout<<head->data<<endl;
        if (head->dtype == D_SECTION)
        {
            cout << "#";
            Traverse(head->child);
            Traverse(head->next);
        }
        if (head->dtype == D_SUB_SECTION)
        {
            cout << "##";
            Traverse(head->child);
            Traverse(head->next);
        }
        if (head->dtype == D_SUBSUB_SECTION)
        {
            cout << "###";
            Traverse(head->child);
            Traverse(head->next);
        }
        if (head->dtype == D_ITALIC)
        {
            cout << "*";
            Traverse(head->child);
            cout << "*\n";
            Traverse(head->next);
        }
        if (head->dtype == D_BOLD)
        {
            cout << "***";
            Traverse(head->child);
            cout << "***\n";
            Traverse(head->next);
        }
        if (head->dtype == D_NEWLINE)
        {
            cout << endl;
            Traverse(head->child);
            Traverse(head->next);
        }
        if (head->dtype == D_INFORMATION)
        {
            cout << head->data;
        }
    }
}

int main()
{
    yyparse();
    cout << "PRINTING AST TREE : " << endl;
    printTree(root, 0);

    if (root->dtype == PROGRAM_BEGINING)
    {
        Traverse(root->next);
    }
}
