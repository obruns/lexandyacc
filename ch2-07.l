%option noinput nounput noyywrap
%s MAGIC

%%
<MAGIC>.+	{ BEGIN 0; printf("Magic:"); ECHO; }
magic		BEGIN MAGIC;
.+		ECHO;
%%

int main()
{
	yylex();
}
