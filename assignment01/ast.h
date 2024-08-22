#ifndef _AST_H
#define _AST_H


#include <stdio.h>
#include <iostream>

using namespace std;

typedef struct Tree{
    string data;
    struct Tree* child;
    struct Tree* next;
}Tree;

void printTree(Tree*,int);

#endif
