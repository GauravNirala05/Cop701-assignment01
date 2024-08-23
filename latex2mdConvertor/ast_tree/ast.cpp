#include <stdio.h>
#include <iostream>
#include "ast.h"

using namespace std;

void printTree(Tree *head)
{
    if (head != NULL)
    {
        cout << head->data << " : "  << endl;

        if (head->child)
        {
            cout << "child of " << head->data << " : \n\t";
            printTree(head->child);
        }
        if (head->next)
        {
            cout << "next of " << head->data << " : \n\t";
            printTree(head->next);
        }
    }
    else
    {
        cout << "backtrack \n";
    }
}