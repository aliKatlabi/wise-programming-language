#ifndef SEMANTICS_H
#define SEMANTICS_H

#include<iostream>
#include<string>
#include<map>
#include<sstream>
#include<vector>

#include "Parserbase.h"

#define YELLOW  "\033[33m"
#define RESET   "\033[0m"
#define RED     "\033[31m"


#define YOUTYel1(a) semanticout_?std::cerr<<YELLOW<<a<<RESET<<std::endl:std::cerr<<"";
#define YOUTYel2(a,b) semanticout_?std::cerr <<YELLOW<<a<<b<<RESET<<std::endl:std::cerr<<"";
#define YOUTRed(a) semanticout_?std::cerr <<RED<<a<<RESET<<std::endl:std::cerr<<"";

extern bool semanticout_;

struct indent {
	int 		lvl_ ;
	std::string indent_;
	indent() {}
	indent(std::string I , int level_) {
		indent_ = I;
		lvl_= level_;
		
	}
};
struct descriptor {

	std::string code;
	indent 		indent_s;
	
	descriptor() {}
	
	descriptor(std::string code_ , indent IN) {
		code = code_;
		indent_s = IN;
		
	}

	void reform(){
		std::stringstream ss;
		ss<<'\t';
		
		for (char const &c: this->code) {
			ss<<c;
			if(c=='\n'){
				ss<<'\t';
			};
		}
		
		 this->code =ss.str() ;
	}
};



struct var_data {
	int decl_row;
	std::string store;
	var_data(){}
	var_data(int i,  std::string s)
	{
		decl_row = i;
		store = s;
		
	}
};

#endif
