  // definition section
%{
unsigned charCount = 0, wordCount = 0, lineCount = 0;
%}
%option noinput nounput

  // definitions
word [^ \t\n]+
eol  \n
%%
  /* rules section */
{word}	{ wordCount++; charCount += yyleng; }
  /* yyleng contains the lenght of the string our lexer recognized */
{eol}	{ charCount++; lineCount++; }
.	charCount++;
%%
  /* user subroutines section */
int main(argc,argv)
int argc;
char **argv;
{

	if (argc > 1) {
		FILE *file;

		file = fopen(argv[1], "r");
		if (!file) {
			fprintf(stderr,"could not open %s\n",argv[1]);
			exit(1);
		}
		yyin = file;
	}
	yylex();
	printf(" %d  %d %d %s\n", lineCount, wordCount, charCount, argc > 1 ? argv[1] : "");
	return 0;
}
