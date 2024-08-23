
%{
#include<stdio.h>
#include "parser.tab.h"
%}

%option noyywrap

%%
"\\documentclass{"[^}]+"}"              {yylval.data = strdup(yytext);return PREHEADER;}
"\\usepackage{"[^}]+"}"                 {yylval.data = strdup(yytext);return PREHEADER;}
"\\title{"[^}]+"}"                      {yylval.data = strdup(yytext);return PREHEADER;}
"\\date{"[^}]+"}"                       {yylval.data = strdup(yytext);return PREHEADER;}
"\\begin{document}"                     {return PREAMBLE;}
"\\end{document}"                       {return FOOTER;}
"\\begin{verbatim}"                     {return PUSH_START;}                
"\\end{verbatim}"                       {return PUSH_END;}
"\\begin{itemize}"                      {return ITEM_START;} 
"\\end{itemize}"                        {return ITEM_END;} 
"\\begin{enumerate}"                    {return ENUM_START;} 
"\\end{enumerate}"                      {return ENUM_END;} 
"\\begin{tabular}{|c|c|}"               {return TABLE_START;} 
"\\end{tabular}"                        {return TABLE_END;}  
"\\hline"                               {return HLINE;}  
"\\section"                             {return SECTION;}                              //{printf("#");}
"\\subsection"                          {return SUBSECTION;}                           //{printf("##");}
"\\subsubsection"                       {return SUBSUBSECTION;} 
"\\includegraphics["[^\]]+"]"           {yylval.data = strdup(yytext);return GRAPHIC;}
"\\textit"                              {return ITALIC;}    
"\\textbf"                              {return BOLD;} 
"\\hrule"                               {return HRULE;}
"\\par"                                 {return PAR;} 
"\\\\"                                  {return TABLE_NEWLINE;}
"&"                                     {return TABLE_PART;}
"\\href"                                {return HREF;}
"["                                     {return OSB;}
"]"                                     {return CSB;}      
"{"                                     {return OB;}                                  
"}"                                     {return CB;}  
[a-z]+[:][/]{2}[a-z.]*                             {yylval.data = strdup(yytext); return LINK;}
[a-zA-Z0-9()\[\],.-?<>;:'"\/!@#$%^*_+=\- ]+       {yylval.data = strdup(yytext); return DATA;}  //printf("data : %s",yytext);
[\n][\n]                                {return NEWLINE;}       // [\n]                        {return EOL;}
[ \n\t]+                                {}
.                                       {}
%%

