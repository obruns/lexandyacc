%{
void yyerror(char *s);
int yylex();
%}
%token NAME NUMBER
  /* specify precedence explicitly */
%left '-' '+'
%left '*' '/'
%precedence UMINUS

%%

statement:	NAME '=' expression
	|	expression		{ printf("= %d\n", $1); }
	;

expression:	expression '+' expression { $$ = $1 + $3; }
	|	expression '-' expression { $$ = $1 - $3; }
	|	expression '*' expression { $$ = $1 * $3; }
	|	expression '/' expression
				{	if($3 == 0)
						yyerror("divide by zero");
					else
						$$ = $1 / $3;
				}
	|	'-' expression %prec UMINUS	{ $$ = -$2; }
	|	'(' expression ')'	{ $$ = $2; }
	|	NUMBER			{ $$ = $1; }
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
