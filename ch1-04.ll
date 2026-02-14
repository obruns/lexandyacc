%{
/*
 * Word recognizer with a symbol table.
 */
#include <string>
#include <unordered_map>
#include <vector>

enum class states {
	LOOKUP = 0, /* default - looking rather than defining. */
	VERB,
	ADJ,
	ADV,
	NOUN,
	PREP,
	PRON,
	CONJ
};

states state;

int add_word(states type, char *word);
states lookup_word(char *word);
%}

%option noyywrap c++

%%
\n	{ state = states::LOOKUP; }	/* end of line, return to default state */

^verb	{ state = states::VERB; }
^adj	{ state = states::ADJ; }
^adv	{ state = states::ADV; }
^noun	{ state = states::NOUN; }
^prep	{ state = states::PREP; }
^pron	{ state = states::PRON; }
^conj	{ state = states::CONJ; }

[a-zA-Z]+  {
		/* a normal word, define it or look it up */
	     if(state != states::LOOKUP) {
	        /* define the current word */
		add_word(state, yytext);
	     } else {
		switch(lookup_word(yytext)) {
		case states::VERB: printf("%s: verb\n", yytext); break;
		case states::ADJ: printf("%s: adjective\n", yytext); break;
		case states::ADV: printf("%s: adverb\n", yytext); break;
		case states::NOUN: printf("%s: noun\n", yytext); break;
		case states::PREP: printf("%s: preposition\n", yytext); break;
		case states::PRON: printf("%s: pronoun\n", yytext); break;
		case states::CONJ: printf("%s: conjunction\n", yytext); break;
		default:
			printf("%s:  don't recognize\n", yytext);
			break;
		}
            }
          }

.	/* ignore anything else */ ;

%%
int main()
{
        FlexLexer* lexer = new yyFlexLexer;
        while(lexer->yylex() != 0)
            ;
}

std::unordered_map<states, std::vector<std::string>> word_list{
	{states::VERB, {}},
	{states::ADJ, {}},
	{states::ADV, {}},
	{states::NOUN, {}},
	{states::PREP, {}},
	{states::PRON, {}},
	{states::CONJ, {}}
};

int
add_word(states type, char *word)
{
	if(lookup_word(word) != states::LOOKUP) {
		printf("!!! warning: word %s already defined \n", word);
		return 0;
	}

	/* word not there, allocate a new entry and link it on the list */
	word_list[type].push_back(word);

	return 1;	/* it worked */
}

states
lookup_word(char *word)
{
	for (const auto& kv: word_list) {
		if (std::find(kv.second.begin(), kv.second.end(), word) != kv.second.end()) {
			return kv.first;
		}
	}

	return states::LOOKUP;	/* not found */
}
