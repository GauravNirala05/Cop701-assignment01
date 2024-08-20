%{
#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <iostream>
#include <string>
#include <vector>

void yyerror(const char *s);
extern int yylex();
void generateMarkdown(const std::string &latexCode);

%}

%union {
    char *str;
}

%token <str> SECTION SUBSECTION BOLD ITALICS HRULE PARAGRAPH BEGIN_VERBATIM END_VERBATIM HYPERLINK IMAGE BEGIN_ITEMIZE END_ITEMIZE BEGIN_ENUMERATE END_ENUMERATE BEGIN_TABLE END_TABLE TEXT

%start document

%%

document:
    elements
    ;

elements:
    | elements element
    ;

element:
    section
    | subsection
    | bold
    | italics
    | hrule
    | paragraph
    | verbatim
    | hyperlink
    | image
    | list
    | table
    | text
    ;

section:
    SECTION { printf("# %s\n\n", $1 + 9); free($1); }
    ;

subsection:
    SUBSECTION { printf("## %s\n\n", $1 + 12); free($1); }
    ;

bold:
    BOLD { printf("**%s**", $1 + 7); free($1); }
    ;

italics:
    ITALICS { printf("_%s_", $1 + 7); free($1); }
    ;

hrule:
    HRULE { printf("---\n"); }
    ;

paragraph:
    PARAGRAPH { printf("\n\n"); }
    ;

verbatim:
    BEGIN_VERBATIM text END_VERBATIM { printf("```\n%s\n```\n", $2); free($2); }
    ;

hyperlink:
    HYPERLINK { printf("[%s](%s)\n", strtok($1 + 6, "}"), strtok(NULL, "}")); free($1); }
    ;

image:
    IMAGE { printf("![Image](%s)\n", $1 + 16); free($1); }
    ;

list:
    BEGIN_ITEMIZE elements END_ITEMIZE { printf("\n"); }
    | BEGIN_ENUMERATE elements END_ENUMERATE { printf("\n"); }
    ;

table:
    BEGIN_TABLE text END_TABLE { printf("\n%s\n", $2); free($2); }
    ;

text:
    TEXT { printf("%s", $1); free($1); }
    ;

%%

void yyerror(const char *s) {
    std::cerr << "Error: " << s << std::endl;
}

int main() {
    return yyparse();
}
