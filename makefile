###############################################################################
# Makefile
# Compiles Lex programs in C++
###############################################################################

SHELL = /bin/bash

SRC = $(wildcard *.lex)
EXE = $(basename $(SRC))

CFLAGS = -Wall -Wl,--no-as-needed
CXXFLAGS = $(CFLAGS) -std=c++0x
LDFLAGS = -ll -I/usr/include

###############################################################################

default: $(EXE)

./%: %.o help.o help.cc
	$(CXX) -o $@ $^ $(LDFLAGS)

%.o: %.c lex.yy.c y.tab.c help.cc
	$(CXX) -c -x c++ $(CXXFLAGS) $<

%.c: %.lex
	$(LEX) -o $@ $<

y.tab.c: lambdalit.y
	$(YACC) lambdalit.y

Lambdalit: Lambdalit.hs
	ghc Lambdalit.hs 

clean:
	$(RM) -fv $(EXE) core.* *~ *.o

############################################################################### 
