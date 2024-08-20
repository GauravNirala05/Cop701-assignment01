%{
#include "latex.tab.h"
#include <string>
%}

%%
"\\section{"[^}]*"}"     { yylval.str = strdup(yytext); return SECTION; }
"\\subsection{"[^}]*"}"  { yylval.str = strdup(yytext); return SUBSECTION; }
"\\textbf{"[^}]*"}"      { yylval.str = strdup(yytext); return BOLD; }
"\\textit{"[^}]*"}"      { yylval.str = strdup(yytext); return ITALICS; }
"\\hrule"                { return HRULE; }
"\\par"                  { return PARAGRAPH; }
"\\begin{verbatim}"      { return BEGIN_VERBATIM; }
"\\end{verbatim}"        { return END_VERBATIM; }
"\\href{"[^}]*"}{"[^}]*"}" { yylval.str = strdup(yytext); return HYPERLINK; }
"\\includegraphics{"[^}]*"}" { yylval.str = strdup(yytext); return IMAGE; }
"\\begin{itemize}"       { return BEGIN_ITEMIZE; }
"\\end{itemize}"         { return END_ITEMIZE; }
"\\begin{enumerate}"     { return BEGIN_ENUMERATE; }
"\\end{enumerate}"       { return END_ENUMERATE; }
"\\begin{tabular}"       { return BEGIN_TABLE; }
"\\end{tabular}"         { return END_TABLE; }
[^\\]+                   { yylval.str = strdup(yytext); return TEXT; }
[\t\n]+                 { /* ignore whitespace */ }
.                        { /* ignore unknown characters */ }

%%

int yywrap() {
    return 1;
}
