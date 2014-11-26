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

./%: %.o help.o
	$(CXX) -o $@ $^ $(LDFLAGS)

%.o: %.c
	$(CXX) -c -x c++ $(CXXFLAGS) $<

%.c: %.lex
	$(LEX) -o $@ $<

clean:
	$(RM) -fv $(EXE) core.* *~ *.o

############################################################################### 
