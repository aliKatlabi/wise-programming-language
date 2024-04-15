#ifndef WISE_SEM_BLOCK_H
#define WISE_SEM_BLOCK_H

#include "wise_h_semantics.h"



struct Block {
	
	indent  	 *block_ind;		//1
	std::string  *tag_name;		//2
	std::string  *attributs;		//3
	Descriptor   *text_desc; 		//5
	Descriptor   *follower_desc;		//6
	
	
	 Descriptor *block_desc;//to be generated
	

	Block(    indent* 	  block_i
			, std::string* tag_n
			, std::string* attr 
			, Descriptor*  text_d
			, Descriptor*  follower_d
		){

		block_ind 		 =block_i;
		tag_name 		 =tag_n;
		attributs 	     =attr;
		text_desc		 =text_d;
		follower_desc	 =follower_d;

	}
	Block(    indent* 	  block_i//1
			, std::string* tag_n//2
			, std::string* attr //3
			, Descriptor*  follower_d//6
		){

		block_ind 		 =block_i;
		tag_name 		 =tag_n;
		attributs 	     =attr;
		follower_desc	 =follower_d;

	}

	Block(    indent* 	  block_i
			, std::string* tag_n
			, std::string* attr
		){

		block_ind 		 =block_i;
		tag_name 		 =tag_n;
		attributs 	     =attr;

	}


	Descriptor apply_rule1();
	Descriptor apply_rule2();
	Descriptor apply_rule3();

};





#endif
