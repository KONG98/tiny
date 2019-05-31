#
# Makefile for TINY
# Gnu C Version
# K. Louden 2/3/98
#

CC = gcc

CFLAGS =
 	
LEX = lex
YACC = bison

OBJS = main.o util.o scan.o parse.o

tiny.out: $(OBJS)
	$(CC) $(CFLAGS) $(OBJS) -o tiny.out
	
main.o: main.c globals.h util.h scan.h tiny.tab.h
	$(CC) $(CFLAGS) -c main.c
	
util.o: util.c util.h globals.h
	$(CC) $(CFLAGS) -c util.c

scan.o: lex.yy.c scan.h util.h globals.h tiny.tab.h
	$(CC) $(CFLAGS) -c lex.yy.c -o scan.o

parse.o: tiny.tab.c parse.h scan.h globals.h util.h
	$(CC) $(CFLAGS) -c tiny.tab.c -o parse.o

lex.yy.c: tiny.l
	$(LEX) tiny.l

tiny.tab.h: tiny.tab.c

tiny.tab.c: tiny.y
	$(YACC) -d tiny.y
	
clean:
	-rm tiny.out
	-rm $(OBJS) lex.yy.c tiny.tab.c tiny.tab.h

all: tiny.out

