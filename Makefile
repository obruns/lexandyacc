# %W% %G%

# make and run all the example programs for
# lex & yacc, Second Edition
include compiler.make
DEBUGFLAGS ?= -g -DYYDEBUG=1
LIBS =
LEX = flex
YACC = bison
CFLAGS = ${DEBUGFLAGS} -D_POSIX_C_SOURCE -std=c23 -Wall -Wextra -Wpedantic -Werror
CXXFLAGS = ${CFLAGS} -std=c++23

PROGRAMS1 = ch1-01.pgm ch1-02.pgm ch1-03.pgm ch1-04.pgm ch1-05.pgm ch1-06.pgm
PROGRAMS2 = ch2-01.pgm ch2-02.pgm ch2-03.pgm ch2-04.pgm ch2-05.pgm \
	ch2-06.pgm ch2-07.pgm ch2-08.pgm ch2-09.pgm

PROGRAMS3 = ch3-01.pgm ch3-02.pgm ch3-03.pgm ch3-04.pgm ch3-05.pgm
PROGRAMS4 = mgl
PROGRAMS5 = sql1 sql2

PROGRAMSE = ape-05.pgm ape-06.pgm

all:	${PROGRAMS1} ${PROGRAMS2} ${PROGRAMS3} ${PROGRAMS4} ${PROGRAMS5} \
	${PROGRAMSE}

progs.tar:
	tar cvf $@ \
	Makefile ape-05.l ape-06.l ch1-01.l ch1-02.l ch1-03.l ch1-04.l \
	ch1-05.l ch1-05.y ch1-05y.h ch1-06.l ch1-06.y ch1-06y.h ch2-01.l \
	ch2-02.l ch2-03.l ch2-04.l ch2-05.l ch2-06.l ch2-07.l ch2-08.l \
	ch2-09.l ch3-01.l ch3-01.y ch3-02.y ch3-03.l ch3-03.y ch3-04.l \
	ch3-04.y ch3-05.l ch3-05.y ch3hdr.h ch3hdr2.h magic.input \
	mgl-code mgl-in mgllex.l mglyac.y mmain.c sample.c subr.c \
	scn1.l scn2.l sql1.y sql2.y sqltext.c

# Chapter 1
#	implied by the other rules

# Chapter 2
#	all use single lex source files

# Chapter 3

%.yy.c: %.l
	${LEX} --outfile=$*.yy.c $<

# Make sure Bison runs first
%.yy.c: %.l | %.tab.h
	${LEX} --outfile=$*.yy.c $<

%.yy.cpp: %.ll
	${LEX} --c++ --outfile $*.yy.cpp $<

%.tab.c %.tab.h: %.y
	${YACC} --language=c --report=all -Wall -Werror -Wno-error=precedence -d $<

%.pgm: %.tab.o %.yy.o | %.tab.h
	${CC} ${CFLAGS} -o $@ $^ ${LIBS}

# dedicated rule because we need -lm here
ch3-05.pgm: ch3-05.tab.o ch3-05.yy.o | ch3-05.tab.h
	${CC} ${CFLAGS} -o $@ $^ ${LIBS} -lm

# chapter 4

mgl: subr.o mglyac.tab.o mgllex.yy.o
	${CC} ${CFLAGS} -o $@ $^ ${LIBS}

subr.o: subr.c | mglyac.tab.h mgl-code

# chapter 5

sql1: sql1.tab.o scn1.yy.o
	${CC} ${CFLAGS} -o $@ $^

sql2: sql2.tab.o scn2.yy.o sqltext.o
	${CC} ${CFLAGS} -o $@ $^

%.cgm: %.yy.cpp
	${CXX} ${CXXFLAGS} -o $@ $*.yy.cpp ${LIBS}

%.pgm: %.yy.c
	${CC} ${CFLAGS} -o $@ $*.yy.c ${LIBS}

compiler.make:
	echo "CC ?= $(CC)" > $@
	echo "CXX ?= $(CXX)" > $@
