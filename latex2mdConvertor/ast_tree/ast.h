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
    D_VERBATIM_START,
    D_VERBATIM_END,
    D_ITEM_START,
    D_ITEM_END,
    D_ENUM_START,
    D_ENUM_END,
    D_TABLE_START,
    D_TABLE_END,
    D_TABLE_NEWLINE,
    D_TABLE_PART,
    D_TABLE_HLINE,
    D_NEWLINE,
    D_GRAPHIC,
    // D_EOL,
    D_INFORMATION
};


typedef struct Tree{
    D_TYPE dtype;
    string data;
    struct Tree* child;
    struct Tree* next;
}Tree;

void printTree(Tree*);

#endif
