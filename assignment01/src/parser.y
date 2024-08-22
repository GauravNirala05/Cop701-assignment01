
%{
#include<stdio.h>
#include<iostream>
#include "ast_tree/ast.h"
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

%type <node> program  expression expressions  section subsection subsubsection italic bold href hrule paragraph information newline

%token SECTION
%token SUBSECTION
%token SUBSUBSECTION
%token OB CB OSB CSB 
%token BOLD ITALIC NEWLINE
%token HRULE PAR HREF
%token <data> DATA  
%token <data> LINK

%%
program :   
    expressions
    {   
        
        struct Tree*node=new Tree;
        node->dtype=PROGRAM_BEGINING;
        node->data="START - ";
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
        // node->dtype="end";
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
|   newline
;


section:
    SECTION OB information CB                  
    {
        // struct Tree * node=new struct Tree;
        // node->dtype="section";
        // node->child=$3;
        // node->next=NULL;
        // $$= node;
        // std::cout << "Section data: " << $3->dtype << std::endl; // Debug output
        $$ = new struct Tree;
        $$->dtype = D_SECTION;
        $$->data= "section";
        $$->child = $3;
        // printf("section\n");
    }
;
subsection:
    SUBSECTION OB information CB               
    {
        $$=new Tree;
        $$->dtype=D_SUB_SECTION;
        $$->data= "sub-section";
        $$->child=$3;
        //printf("##%s",$3);
    }
;

subsubsection :
    SUBSUBSECTION OB information CB               
    {
        $$=new Tree;
        $$->dtype=D_SUBSUB_SECTION;
        $$->data= "subsub-section";
        $$->child=$3;
        // printf("##%s",$3);
    }
;
italic :
    ITALIC OB information CB                  
    {
        $$=new Tree;
        $$->dtype=D_ITALIC;
        $$->data= "italic";
        $$->child=$3;
        // printf("*%s*",$3);
    }
;
bold:
    BOLD OB information CB                    
    {
        $$=new Tree;
        $$->dtype=D_BOLD;
        $$->data= "bold";
        $$->child=$3;
        // printf("** %s **",$3);
    }
;
href:
    HREF OB LINK CB OB information CB          
     {
        $$=new Tree;
        $$->dtype=D_HREF;
        $$->data=$3;
        $$->child=$6;
        // printf("[%s](%s)",$6,$3);
    }
;
hrule:
    HRULE                              
    {
        $$=new Tree;
        $$->data= "hrule";
        $$->dtype=D_HRULE;
        // printf("---");
    }
;
paragraph:
    PAR                                
    {
        $$=new Tree;
        $$->data= "paragraph";
        $$->dtype=D_PAR;
        // printf("\n");
    }
;
information:
    DATA                                
    {
        $$=new struct Tree;
        $$->dtype=D_INFORMATION;
        $$->data=$1;
        $$->child=NULL;
        $$->next=NULL;
        // printf("%s",$1);
    }
newline:
    NEWLINE                                
    {
        $$=new struct Tree;
        $$->dtype=D_NEWLINE;
        $$->data= "newline";
        $$->child=NULL;
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