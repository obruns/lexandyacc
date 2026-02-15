%{
void yyerror(char *s);
int yylex();
%}
%token NAME NUMBER
%%
  /* The symbol on the LHS of the first rule in the
     grammar is normally the start symbol. */
statement:	NAME '=' expression
  /* By default yacc makes all values of type `int` */
	|	expression		{ printf("= %d\n", $1); }
	;

expression:	expression '+' NUMBER	{ $$ = $1 + $3; }
	|	expression '-' NUMBER	{ $$ = $1 - $3; }
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
