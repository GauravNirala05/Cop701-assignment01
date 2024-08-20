%{

%}

 // rules

%%


[a-z] {printf("lower case\n");}
. {printf("not a lower case\n");}
\n {return 0;}


%%

yywrap(){}

int main(){
    printf( "enter any string");
    yylex();

    return 0;
}