%{
void yyerror(char *s);
int yylex();
double vbltable[26];
%}

  /* define the possible symbol types */
  /* YYSTYPE C typedef */
%union {
	double dval;
	int vblno;
}

%token <vblno> NAME
%token <dval> NUMBER
%left '-' '+'
%left '*' '/'
%nonassoc UMINUS

  /* sets the type for non-terminals which otherwise need no declaration */
%type <dval> expression
%%
statement_list:	statement '\n'
	|	statement_list statement '\n'
	;

statement:	NAME '=' expression	{ vbltable[$1] = $3; }
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
	|	NAME			{ $$ = vbltable[$1]; }
	;
%%

extern FILE *yyin;

int main()
{
	yyin = stdin;
	while(!feof(yyin)) {
		yyparse();
	}
}

void yyerror(char *s)
{
    fprintf(stderr, "%s\n", s);
}
