
%{
#include<stdio.h>
#include<iostream>
#include "ast_tree/ast.h"
using namespace std;
int counter=0;
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
%type <node> preheaders
%type <node> program expression expressions
%type <node> section subsection subsubsection
%type <node> italic bold paragraph
%type <node> href hrule graphic
%type <node> information newline //eol
%type <node> verbatim_start verbatim_end 
%type <node> itemize_start itemize_end //items 
%type <node> enumerator_start enumerator_end 
%type <node> table_start table_end table_newline table_partition hline
     
%token PREAMBLE FOOTER
%token SECTION SUBSECTION SUBSUBSECTION
%token OB CB OSB CSB EOL
%token BOLD ITALIC NEWLINE
%token HRULE PAR HREF
%token PUSH_START PUSH_END
%token ITEM_START ITEM_END
%token ENUM_START ENUM_END
%token TABLE_START TABLE_END TABLE_PART TABLE_NEWLINE HLINE

%token <data> GRAPHIC
%token <data> DATA  
%token <data> LINK
%token <data> PREHEADER
/* %token <data> ITEMS */
/* %token <verbatim> VERBATIM */

%%

program :   
    preheaders PREAMBLE expressions FOOTER
    {   
        
        struct Tree*node=new Tree;
        node->dtype=PROGRAM_BEGINING;
        node->data="START - ";
        $$=node;
        node->child=$3;
        root=$$;
        node->next=$1;
        // printf("start\n");

    }
|   PREAMBLE expressions FOOTER
    {   
        
        struct Tree*node=new Tree;
        node->dtype=PROGRAM_BEGINING;
        node->data="START - ";
        $$=node;
        node->child=$2;
        root=$$;
        // printf("start\n");

    }
;
preheaders :
    PREHEADER preheaders 
    {
        $$ = new Tree;
        $$->data=$1;
        $$->next = $2;
        // printf("expressions : expression expressions\n");
    }

|   PREHEADER 
    {
        $$ = new Tree;
        $$->data=$1;
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
;
expression :
    section 
|   subsection
|   subsubsection
|   italic 
|   bold
|   href 
|   hrule 
|   paragraph 
|   verbatim_start
|   verbatim_end
|   itemize_start
|   itemize_end
|   enumerator_start
|   enumerator_end
|   graphic 
|   table_start
|   table_end
|   table_newline
|   table_partition
|   hline
|   information
/* |   items */
|   newline
/* |   eol  */
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
        // printf("section  %d\n",counter++);
    }
;
subsection:
    SUBSECTION OB information CB               
    {
        $$=new Tree;
        $$->dtype=D_SUB_SECTION;
        $$->data= "sub-section";
        $$->child=$3;
        
        // printf("subsection  %d\n",counter++);
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
        
        // printf("subsubsection  %d\n",counter++);
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
        printf("its running ");
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
verbatim_start:
    PUSH_START                            
    {
        
        $$=new Tree;
        $$->dtype=D_VERBATIM_START;
        $$->data="verbatim start - ";
    }
;
verbatim_end:
    PUSH_END                            
    {
        
        $$=new Tree;
        $$->dtype=D_VERBATIM_END;
        $$->data="verbatim end - ";
    }
;
itemize_start:
    ITEM_START                       
    {
        
        $$=new Tree;
        $$->dtype=D_ITEM_START;
        $$->data="item start - ";
    }
;
itemize_end:
    ITEM_END                            
    {
        
        $$=new Tree;
        $$->dtype=D_ITEM_END;
        $$->data="item end - ";
    }
;
enumerator_start:
    ENUM_START                       
    {
        
        $$=new Tree;
        $$->dtype=D_ENUM_START;
        $$->data="ENUM start - ";
    }
;
enumerator_end:
    ENUM_END                            
    {
        
        $$=new Tree;
        $$->dtype=D_ENUM_END;
        $$->data="ENUM end - ";
    }
;
table_start:
    TABLE_START                       
    {
        
        $$=new Tree;
        $$->dtype=D_TABLE_START;
        $$->data="table start - ";
    }
;
table_end:
    TABLE_END                            
    {
        
        $$=new Tree;
        $$->dtype=D_TABLE_END;
        $$->data="table end - ";
    }
;
table_newline :
    TABLE_NEWLINE
    {
        $$=new Tree;
        $$->dtype=D_TABLE_NEWLINE;
        $$->data="table newline - ";

    }
table_partition :
    TABLE_PART
    {
        $$=new Tree;
        $$->dtype=D_TABLE_PART;
        $$->data="table partition - ";

    }
hline :
    HLINE
    {
        $$=new Tree;
        $$->dtype=D_TABLE_HLINE;
        $$->data="table hline - ";
    }
graphic:
    GRAPHIC OB information CB                  
    {
        $$ = new struct Tree;
        $$->dtype = D_GRAPHIC;
        $$->data= $1;
        $$->child = $3;
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
/* items:
    ITEMS                                
    {
        $$=new struct Tree;
        $$->dtype=D_INFORMATION;
        $$->data=$1;
        $$->child=NULL;
        $$->next=NULL;
        // printf("%s",$1);
    } */
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
/* eol:
    EOL                                
    {
        $$=new struct Tree;
        $$->dtype=D_EOL;
        $$->data="END OF LINE";
        $$->child=NULL;
        // printf("%s",$1);
    }
; */


%%

/* int main(){
    yyparse();
}
void yyerror(const char * s){
    printf("ERROR : %s\n",s);
} */

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