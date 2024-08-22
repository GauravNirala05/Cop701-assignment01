
%{
#include<stdio.h>
#include<iostream>
#include "ast.h"
using namespace std;

extern int yylex();

extern Tree* root;

extern void yyerror(const char* s);

%}

%define parse.error verbose

%union{
    char* data;
    char* sys;
    struct Tree *node;
}

%type <node> program  expression expressions  section subsection subsubsection italic bold href hrule paragraph information 

%token SECTION
%token SUBSECTION
%token SUBSUBSECTION
%token OB CB OSB CSB 
%token BOLD ITALIC
%token HRULE PAR HREF
%token <data> DATA  
%token <data> LINK

%%
program :   
    expressions
    {   
        
        struct Tree*node=new Tree;
        node->data="PROGRAM BEGINING :- ";
        $$=node;
        node->next=$1;
        root=$$;
    }
;
expressions :
    expression expressions 
    {
        $$ = $1;
        $$->next = $2;

        // printf("expressions : expression expressions\n");
    }

|   expression 
    {
        // struct Tree * node =new struct Tree;
        // node->data="end";
        // node->child=NULL;
        // node->next=NULL;
        // $$=node;
        // struct Tree*node1=$2;
        $$ = $1;
        // $$->next = NULL;
        // node->next=node1;
        // printf("empty : empty \n");
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
;


section:
    SECTION OB information CB                  
    {
        // struct Tree * node=new struct Tree;
        // node->data="section";
        // node->child=$3;
        // node->next=NULL;
        // $$= node;
        // std::cout << "Section data: " << $3->data << std::endl; // Debug output
        $$ = new struct Tree;
        $$->data = "SECTION ";
        $$->child = $3;
        // printf("section\n");
    }
;
subsection:
    SUBSECTION OB information CB               
    {
        $$=new Tree;
        $$->data="SUB-SECTION";
        $$->child=$3;
        //printf("##%s",$3);
    }
;

subsubsection :
    SUBSUBSECTION OB information CB               
    {
        $$=new Tree;
        $$->data="SUB-SECTION";
        $$->child=$3;
        // printf("##%s",$3);
    }
;
italic :
    ITALIC OB information CB                  
    {
        $$=new Tree;
        $$->data="ITALIC";
        $$->child=$3;
        // printf("*%s*",$3);
    }
;
bold:
    BOLD OB information CB                    
    {
        $$=new Tree;
        $$->data="BOLD";
        $$->child=$3;
        // printf("** %s **",$3);
    }
;
href:
    HREF OB LINK CB OB information CB          
     {
        $$=new Tree;
        $$->data=$3;
        $$->child=$6;
        // printf("[%s](%s)",$6,$3);
    }
;
hrule:
    HRULE                              
    {
        $$=new Tree;
        $$->data="HRULE";
        // printf("---");
    }
;
paragraph:
    PAR                                
    {
        $$=new Tree;
        $$->data="PAR";
        // printf("\n");
    }
;
information:
    DATA                                
    {
        $$=new struct Tree;
        $$->data=$1;
        $$->child=NULL;
        $$->next=NULL;
        // printf("%s",$1);
    }
;


%%


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