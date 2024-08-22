
%{
#include<stdio.h>
#include<iostream>
using namespace std;
int yylex();
struct Tree{
    string data;
    struct Tree* child;
    struct Tree* next;
};
void printTree(struct Tree* head){
    if(head!=NULL){
    cout<<head->data<<" : \n";
    printTree(head->child);
    printTree(head->next);
    }
}
struct Tree* root;

void yyerror(const char* s);

%}

%define parse.error verbose

%union{
    char* data;
    char* sys;
    struct Tree *node;
}

%type <node> program  expression expressions  section subsection subsubsection italic bold href hrule paragraph information endLine 

%token SECTION
%token SUBSECTION
%token SUBSUBSECTION
%token OB CB OSB CSB 
%token BOLD ITALIC EOL
%token HRULE PAR HREF
%token <data> DATA  
%token <data> LINK

%%
program :   
    expressions
    {   
        // struct Tree * node =$1;
        printf("anything\n");
        root=$1;
    }
;
expressions :
    expression expressions 
    {
        struct Tree * exp =$1;
        struct Tree * exps =$2;
        exp->next=exps;
        $$=exp;
        printf("expressions : expression expressions\n");
    }

|   %empty 
    {
        struct Tree * node =new Tree;
        printf("empty : empty \n");
    }

expression :
    section 
|   subsection
|   subsubsection
|   italic 
|   bold
|   href 
|   hrule 
|   paragraph 
|   information 
|   endLine
;


section:
    SECTION OB information CB                  
    {
        struct Tree * node=new Tree;
        node->data="section";
        node->child=$3;
        node->next=NULL;
        $$= node;
        printf("section\n");
    }
;
subsection:
    SUBSECTION OB DATA CB               {printf("##%s",$3);}
;

subsubsection :
    SUBSUBSECTION OB DATA CB            {printf("##%s",$3);}
;
italic :
    ITALIC OB DATA CB                   {printf("*%s*",$3);}
;
bold:
    BOLD OB DATA CB                     {printf("** %s **",$3);}
;
href:
    HREF OB LINK CB OB DATA CB          {printf("[%s](%s)",$6,$3);}
;
hrule:
    HRULE                               {printf("---");}
;
paragraph:
    PAR                                 {printf("\n");}
;
information:
    DATA                                
    {
        struct Tree * node=new Tree;
        node->data=$1;
        node->child=NULL;
        node->next=NULL;
        $$= node;
        printf("%s",$1);
    }
;
endLine:
    EOL                                 {printf("\n");}
; 


%%

int main(){
    yyparse();
    printTree(root);
}

void yyerror(const char* s){
    printf("ERROR : %s \n",s);
}
/* program :
|    expression program
;

expression:
    SECTION OB DATA CB                  {printf("#%s",$3);}
|   SUBSECTION OB DATA CB               {printf("##%s",$3);}
|   SUBSUBSECTION OB DATA CB            {printf("##%s",$3);}
|   ITALIC OB DATA CB                   {printf("*%s*",$3);}
|   BOLD OB DATA CB                     {printf("** %s **",$3);}
|   HREF OB LINK CB OB DATA CB          {printf("[%s](%s)",$6,$3);}
|   HRULE                               {printf("---");}
|   PAR                                 {printf("\n");}
|   DATA                                {printf("%s",$1);}
|   EOL                                 {printf("\n");}
; */