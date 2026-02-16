#pragma once
/*
 *	Header for calculator program
 */

#define NSYMS 20	/* maximum number of symbols */

struct symtab {
	char *name;
	double (*funcptr)();
	double value;
};

struct symtab *symlook();
