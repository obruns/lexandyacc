%option noinput nounput noyywrap
%%
.|\n		ECHO;
%%
int main(int, char**) {
	yylex();
}
