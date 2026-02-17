%option noinput nounput noyywrap
%{
#include "ch3-01.tab.h"

void yyerror(char *s);
int yylex();
extern int yylval;
%}

%%
[0-9]+	{ yylval = atoi(yytext); return NUMBER; }
[ \t]	;		/* ignore white space */
\n	return 0;	/* logical EOF */
.	return yytext[0];
%%

void yyerror(char *s)
{
    fprintf(stderr, "%s\n", s);
}
