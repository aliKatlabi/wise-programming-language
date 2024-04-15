#include <iostream>
#include <fstream>
#include <sstream>

#include <cstdlib>
#include "Parser.h"
#include <FlexLexer.h>

using namespace std;

#define T(a) 	 terminal::t[(a>-1&&a<4)?a:0]
#define TER 	 T(0)
#define VIS 	 terminal::t[1]
#define ON 	 	 terminal::t[2]
#define OFF	 	 terminal::t[3]

extern bool lexeroutput_;
bool semanticout_ = false ;

char* t_buffer;
	
namespace terminal
{
	const std::string  t[4] ={"-t","-vis","on","off"};

}

void input_handler(yyFlexLexer& lexer, std::ifstream& in , int argc , char* argv[]);

int main(int argc , char* argv[])
{
	std::ifstream in;
	Parser pars(in);
	input_handler(pars.d_scanner, in, argc, argv);
	pars.parse();
	return 0;
}

/*

.\wise 		filename -vis (on|off)
.\wise 		-t  for terminal typing (type your wise program)
.\wise 		-t -vis (on|off) turn on and off lexical output

*/
void input_handler(yyFlexLexer& lexer, std::ifstream& in , int argc , char* argv[])
{
   	if(argc==1){
		std::cerr<<	".\\wise -t  for terminal typing (type your wise program)\n"<<
					".\\wise -t -vis (on|off) turn on and off lexical output\n"<<
					".\\wise filename -vis (on|off)"<<std::endl;
		exit(1);
	}
#define ARGV23 	(std::string(argv[2])+std::string(argv[3]))
	if(argc>4)
	{
		std::cerr<<"one argument expected"<<std::endl;
		exit(1);
	}
	if(argc==4){
#define VIS_OFF ARGV23==VIS+OFF
#define VIS_ON  ARGV23==VIS+ON
		if(VIS_ON){
			lexeroutput_= true;
			semanticout_=true;
		}

		if(VIS_OFF){
			lexeroutput_ = false;
			semanticout_= false;
		}
	}
	
	if(argv[1] == TER)
	{
		std::cerr<<"switching to terminal\n..\n..\n";
		lexer.switch_streams(&(std::cin.get(t_buffer,std::cin.gcount(),' ')), 
					&std::cerr);
	}else{
		in.open(argv[1]);
		if(!in)
		{
			std::cerr<<"Cannot open file:"<<argv[1]<<std::endl;
			exit(1);
		}
	}

}
