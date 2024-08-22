
%{
#include<stdio.h>
#include "parser.tab.h"
%}

%option noyywrap

%%

"\\section"                 {return SECTION;}                              //{printf("#");}
"\\subsection"              {return SUBSECTION;}                           //{printf("##");}
"\\subsubsection"           {return SUBSUBSECTION;}   
"\\textit"                  {return ITALIC;}    
"\\textbf"                  {return BOLD;} 
"\\hrule"                   {return HRULE;}
"\\par"                     {return PAR;}  
"\\href"                    {return HREF;}
"["                         {return OSB;}
"]"                         {return CSB;}      
"{"                         {return OB;}                                  
"}"                         {return CB;}  
[a-z]+[:][/]{2}[a-z.]*                  {yylval.data = strdup(yytext); return LINK;}
[a-zA-Z0-9()\[\],.-?<>;:'"\/!@#$%^&*_+=\- ]+       {yylval.data = strdup(yytext); return DATA;}  
[\n]                        {return EOL;}
[ \t]                       {}

%%

