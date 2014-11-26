%{
#include <stdio.h>
#include <string.h>
#include <iostream>
#include <string>
#define YYSTYPE std::string

extern "C"
{
        int yyparse(void);
        int yylex();  
        int yywrap()
        {
                return 1;
        }

}


void yyerror(const char* str) {
    fprintf(stderr,"Error: %s\n",str);
}

int main() {
    yyparse();
}
%}

%token OPAR CPAR LAMBDA VAR DOT

%%
// Yacc syntax
root: expression
{
    std::cout << $1 << "Impreso";
    exit(0);
}
;

expression
       : lambda {$$ = $1;}
       | pair {$$ = $1;} 
       | variable {$$ = $1;} 
       | OPAR expression CPAR {$$ = $2;}
;


lambda: LAMBDA variable DOT expression
{ 
    $$ = "(\\" +$2 + "." + $4 + ")";
}
;

pair: OPAR expression CPAR OPAR expression CPAR
{ 
    $$ = "Pair (" + $2 + ")(" + $5 + ")";
}
;

variable: VAR
{
    $$ = $1;
}
;


