
mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
current_dir := $(notdir $(patsubst %/,%,$(dir $(mkfile_path))))

COMPILERNAME=wise_h
OUTNAME=wise
SCANNERTEST=scantest
BIN=$(current_dir)/bin
SRC=$(current_dir)/src

all: $(COMPILERNAME)
	-

compiler: $(COMPILERNAME)
	-

scanner: lex.yy.cc
	-

parser: parse.cc
	-

clean:
	rm -rf $(COMPILERNAME) $(SCANNERTEST) lex.yy.cc Parserbase.h parse.cc *~

lex.yy.cc: $(COMPILERNAME).l
	flex $(COMPILERNAME).l

parse.cc: $(COMPILERNAME).y
	bisonc++  --verbose  $(COMPILERNAME).y 

$(COMPILERNAME): $(COMPILERNAME).cc lex.yy.cc parse.cc 
	g++ -std=c++11 -o $(BIN)/$(OUTNAME) $(COMPILERNAME).cc parse.cc lex.yy.cc 


$(SCANNERTEST): $(SCANNERTEST).cc lex.yy.cc
	g++ -std=c++11 -o $(BIN)/$(SCANNERTEST) $(SCANNERTEST).cc lex.yy.cc
