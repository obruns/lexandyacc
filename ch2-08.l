%option noinput nounput noyywrap
%{
	/* This example deliberately doesn't work! */
%}

%s MAGIC

%%
magic		BEGIN MAGIC;
.+		ECHO;
<MAGIC>.+ 	{ BEGIN 0; printf("Magic:"); ECHO; }
%%

int main()
{
	yylex();
}
