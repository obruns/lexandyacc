  // lex comments must be indented with whitespace

%{
// this section is called the `definition section`
// any initial C program code can go here

/*
 * this sample demonstrates (very) simple recognition:
 * a verb/not a verb.
 */

%}
%option noinput nounput
%%
  // the `rules section`
  // pattern<whitespace>action
  // ';' - do nothing statement in C

[\t ]+		/* ignore white space */ ;

  /* '|' - use the action specified for the last pattern */
is |
am |
are |
were |
was |
be |
being |
been |
do |
does |
did |
will |
would |
should |
can |
could |
has |
have |
had |
go		{ printf("%s: is a verb\n", yytext); }
  /* `yytext` contains the text that matched the pattern */

[a-zA-Z]+ 	{ printf("%s: is not a verb\n", yytext); }
  /*
     Lex patterns only match a given input character or string once.
     Lex executes the action fo rthe longest possible match for the current input.
     Thus, lex would see "island" as matching our all-inclusive rule because that
     was a longer match than "is".
   */

.|\n		{ ECHO; /* normal default anyway */ }
%%

  // `user subroutines section`

  // this `main()` is superfluous because -lfl has one
int main()
{
	yylex();
}
