
#include<stdio.h>
#include<iostream>
#include "ast.h"
using namespace std;

extern int yyparse();

Tree* root;

void yyerror(const char* s){
    printf("ERROR : %s \n",s);
}



int main(){
    yyparse();
    printTree(root,0);
}
