%{
#include<stdio.h>
int yylex();
void yyerror(const char* s);
%}

%union{
    char* data;
    char* sys;
}

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
;


%%

int main(){
    yyparse();
}

void yyerror(const char* s){
    printf("ERROR : %s \n",s);
}