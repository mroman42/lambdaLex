%{
#include <stdio.h>
#include "y.tab.c"
%}

%% /* Regular Expressions */
Defs\.$              return DEFS;
Comp\.$              return COMP;
\=                   return EQUALS;
\(                   return OPAR;
\)                   return CPAR;
\\                   return LAMBDA;
[a-z]                {yylval=yytext[0]; return VAR;}
[a-z0-9]+            {yylval=yytext; return NAME;}
\.                   return DOT;
\n                   return NL;
.                    {};
%%
