%{
#include<stdio.h>
%}

%%
"\section" {printf("#");}
"\subsection" { printf("##");}
"\subsubsection" {printf("###");}
[a-zA-Z0-9]+ {printf("%s \n",yytext);}
[ \t\n]  {}
%%
yywrap(void){};

int main(){
    yylex();
}
