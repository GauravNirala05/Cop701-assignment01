#ifndef _AST_H
#define _AST_H


#include <stdio.h>
#include <iostream>

using namespace std;

enum D_TYPE{
    PROGRAM_BEGINING,
    D_SECTION,
    D_SUB_SECTION,
    D_SUBSUB_SECTION,
    D_HREF,
    D_ITALIC,
    D_BOLD,
    D_HRULE,
    D_PAR,
    D_NEWLINE,
    D_INFORMATION
};


typedef struct Tree{
    D_TYPE dtype;
    string data;
    struct Tree* child;
    struct Tree* next;
}Tree;

void printTree(Tree*,int);

#endif
