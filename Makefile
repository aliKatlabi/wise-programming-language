

current_dir := ${CURDIR}

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
	@echo ... cleaning mess 
	@rm -rf $(SRC)/$(COMPILERNAME) $(SRC)/$(SCANNERTEST) $(SRC)/lex.yy.cc $(SRC)/Parserbase.h $(SRC)/parse.cc *~
	
lex.yy.cc: $(SRC)/$(COMPILERNAME).l
	@echo ... artifacting scanner 1)
	@flex -o$(SRC)/lex.yy.cc $(SRC)/$(COMPILERNAME).l 

parse.cc: $(SRC)/$(COMPILERNAME).y
	@echo ... generating parser  
	@bisonc++  --verbose -f $(SRC)/Parser  $(SRC)/$(COMPILERNAME).y 
	@mv parse.cc $(SRC)/ || (echo "mycommand failed $$?"; exit 1)
	
$(COMPILERNAME): $(SRC)/$(COMPILERNAME).cc lex.yy.cc parse.cc
	@echo ... linking 
	@g++ -std=c++11 -o $(SRC)/$(OUTNAME) $(SRC)/$(COMPILERNAME).cc $(SRC)/parse.cc $(SRC)/lex.yy.cc 
	@echo ... compiled 

$(SCANNERTEST): $(SRC)/$(SCANNERTEST).cc $(SRC)/lex.yy.cc
	@g++ -std=c++11 -o $(SRC)/$(OUTNAME) $(SRC)/$(SCANNERTEST).cc $(SRC)/lex.yy.cc
	

