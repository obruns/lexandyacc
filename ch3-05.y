%{
#include "ch3hdr2.h"
#include <math.h>
#include <string.h>
#include <stdlib.h>

void yyerror(char *s);
int yylex();
struct symtab symtab[NSYMS];
%}

%union {
	double dval;
	struct symtab *symp;
}
%token <symp> NAME
%token <dval> NUMBER
%left '-' '+'
%left '*' '/'
%precedence UMINUS

%type <dval> expression
%%
statement_list:	statement '\n'
	|	statement_list statement '\n'
	;

statement:	NAME '=' expression	{ $1->value = $3; }
	|	expression		{ printf("= %g\n", $1); }
	;

expression:	expression '+' expression { $$ = $1 + $3; }
	|	expression '-' expression { $$ = $1 - $3; }
	|	expression '*' expression { $$ = $1 * $3; }
	|	expression '/' expression
				{	if($3 == 0.0)
						yyerror("divide by zero");
					else
						$$ = $1 / $3;
				}
	|	'-' expression %prec UMINUS	{ $$ = -$2; }
	|	'(' expression ')'	{ $$ = $2; }
	|	NUMBER
	|	NAME			{ $$ = $1->value; }
	|	NAME '(' expression ')'	{
			if($1->funcptr)
				$$ = ($1->funcptr)($3);
			else {
				printf("%s not a function\n", $1->name);
				$$ = 0.0;
			}
		}
	;
%%
/* look up a symbol table entry, add if not present */
struct symtab *
symlook(char *s)
{
	struct symtab *sp;
	
	for(sp = symtab; sp < &symtab[NSYMS]; sp++) {
		/* is it already here? */
		if(sp->name && !strcmp(sp->name, s))
			return sp;
		
		/* is it free */
		if(!sp->name) {
			sp->name = strdup(s);
			return sp;
		}
		/* otherwise continue to next */
	}
	yyerror("Too many symbols");
	exit(1);	/* cannot continue */
} /* symlook */

void addfunc(char *name, double (*func)(double))
{
	struct symtab *sp = symlook(name);
	sp->funcptr = func;
}

int main()
{
	addfunc("sqrt", sqrt);
	addfunc("exp", exp);
	addfunc("log", log);
	yyparse();
}

void yyerror(char *s)
{
    fprintf(stderr, "%s\n", s);
}
