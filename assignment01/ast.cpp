#include <stdio.h>
#include <iostream>
#include "ast.h"

using namespace std;


void printTree(Tree* head,int countNode){
    if(head!=NULL){
        cout<<head->data<<" : "<<"countNode : "<<countNode<<endl;;
        if (head->child) {cout<<"child of "<<head->data<<" : ";printTree(head->child,countNode);}
        if (head->next){cout<<"next of "<<head->data<<" : "; printTree(head->next,countNode);}
        countNode++;
    }
    else{
        cout<<"backtrack \n";
    }
}