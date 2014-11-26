%{
#include <stdio.h>
#include "y.tab.c"
%}

%% /* Regular Expressions */
\(                   return OPAR;
\)                   return CPAR;
\\                   return LAMBDA;
[a-z]                yylval=yytext[0]; return VAR;
\.                   return DOT;
.                    {};
%%
