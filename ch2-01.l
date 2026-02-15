%option noinput nounput
%%
[\n\t ]	;

  /* order matters! */
0b[01]+  { printf("bin\n"); }
0[0-9a-f]+  { printf("oct\n"); }
(\+|-)?(([0-9]+)|([0-9]*\.[0-9]+)([eE][-+]?[0-9]+)?) { printf("decimal number\n"); }
0x[0-9a-f]+  { printf("hex\n"); }

.	ECHO;
%%
int main()
{
	yylex();
}
