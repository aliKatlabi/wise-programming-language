#include "wise_h_semantics.h"


Block::descriptor apply_rule1()
{
		// GETTIN INFO

		// BLOCK CLASS :  current_block indent
		int     current_block_lvl	 		=    block_ind->lvl_;
		std::string current_block_indent 	=    block_ind->indent_;
		// BLOCK CLASS :  follower block information
		std::string follower_code	 =    (follower_desc->code);
		std::string follower_indent	 =    (follower_desc->indent_s).indent_;
		int         follower_lvl 	 =    (follower_desc->indent_s).lvl_;
		// BLOCK CLASS :  textlines 
		textlines_code   				 = (text_desc->code);
		textlines_indent   				 = (text_desc->indent_s).indent_;
		textlines_lvl      			 	 = (text_desc->indent_s).lvl_;
		// BLOCK CLASS : tag name 
		std::string tag_name  		 = *$2 ;
		// BLOCK CLASS :  attributes 
		std::string attributs 		 = *$3 ;
		
		std::string open_tag_attr        = "<" + tag_name + attributs + ">" ;
		std::string close_tag            = "</" + tag_name + ">";
		
// TODO
// CHECK   : textlines indent_lvl =  the current block 
// IF TRUE : concatenate  textlines code to block code 
// ELSE    : semantic error 
		
		
// always must :   textlines_lvl = current_block_lvl


		//int         textlines_lvl 		= 0;
		//std::string textlines_code    = "";
		//std::string textlines_indent    = "";
		


		bool textlines_cond			 = (textlines_lvl == current_block_lvl+1)?true:false ;
		bool sibling_follower_cond	 = (current_block_lvl == follower_lvl)?true:false ;
		bool child_follower_cond 	 = (current_block_lvl+1 == follower_lvl)?true:false ;
		bool outside_follower_cond	 = (follower_lvl < current_block_lvl)?true:false ;

		

		if( sibling_follower_cond && textlines_cond ){
		
			YOUTYel1("sibling follower");
			
			// SAME LEVEL
			// follower code comes after 
			
			std::string block_code =	current_block_indent	+  open_tag_attr + "\n"+
										textlines_code  +
										current_block_indent	+  close_tag + "\n"+
										follower_code ;
										
			
			
			indent *IND = new indent(current_block_indent,current_block_lvl);
			block_desc = new descriptor(block_code , *IND);
		
			
		}

		
		
		if(child_follower_cond && textlines_condition ){
			//YOUTYel1("child follower");
		
			std::string block_code =	 current_block_indent  + open_tag_attr +"\n" +
										 textlines_code +
										 follower_code + "\n" +
										 current_block_indent  + close_tag +"\n";
			
		
			indent *IND = new indent(current_block_indent,current_block_lvl);
			block_desc = new descriptor(block_code , *IND);
		
			
		}

		if( outside_follower_cond && textlines_condition  ){
			//YOUTYel1("child follower");
		
			std::string block_code =	 current_block_indent  + open_tag_attr + "\n"+
										 textlines_code +
										 current_block_indent  + close_tag     + "\n"+
										 follower_indent +follower_code  + "\n";
										 
			
			indent *IND = new indent(current_block_indent,current_block_lvl);
			block_desc = new descriptor(block_code , *IND);
		
			
		}
		else{
			
			std::ostringstream lvl_s;
			lvl_s << "line(" << d_loc__.first_line << ") .... semantic error " ;
			YOUTYel1(lvl_s.str());
			
			// semantic ERROR .... 
			
		}
		
		std::ostringstream lvl_s;
		lvl_s << "LVL(" << current_block_lvl << "):block-> indents tag attributs T_NLINE follower " ;
		YOUTYel1(lvl_s.str());
		
		return block_desc;



}
;
Block::descriptor apply_rule2() // :  NO TEXT RULE
{

		// GETTIN INFO

		// BLOCK CLASS :  current_block indent
		int     current_block_lvl	 		=    block_ind->lvl_;
		std::string current_block_indent 	=    block_ind->indent_;
		// BLOCK CLASS :  follower block information
		std::string follower_code	 =    (follower_desc->code);
		std::string follower_indent	 =    (follower_desc->indent_s).indent_;
		int         follower_lvl 	 =    (follower_desc->indent_s).lvl_;
		// BLOCK CLASS :  NO TEXT RULE 
		// BLOCK CLASS : tag name 
		std::string tag_name  		 = *$2 ;
		// BLOCK CLASS :  attributes 
		std::string attributs 		 = *$3 ;
		
		std::string open_tag_attr        = "<" + tag_name + attributs + ">" ;
		std::string close_tag            = "</" + tag_name + ">";
		
// TODO
// CHECK   : textlines indent_lvl =  the current block 
// IF TRUE : concatenate  textlines code to block code 
// ELSE    : semantic error 
		
		
// always must :   textlines_lvl = current_block_lvl


		//int         textlines_lvl 		= 0;
		//std::string textlines_code    = "";
		//std::string textlines_indent    = "";
		


		bool textlines_cond			 = (textlines_lvl == current_block_lvl+1)?true:false ;
		bool sibling_follower_cond	 = (current_block_lvl == follower_lvl)?true:false ;
		bool child_follower_cond 	 = (current_block_lvl+1 == follower_lvl)?true:false ;
		bool outside_follower_cond	 = (follower_lvl < current_block_lvl)?true:false ;

		

		if( sibling_follower_cond && textlines_cond ){
		
			YOUTYel1("sibling follower");
			
			// SAME LEVEL
			// follower code comes after 
			
			std::string block_code =	current_block_indent	+  open_tag_attr + "\n"+
										current_block_indent	+  close_tag + "\n"+
										follower_code ;
										
			
			
			indent *IND = new indent(current_block_indent,current_block_lvl);
			block_desc = new descriptor(block_code , *IND);
		
			
		}

		
		
		if(child_follower_cond && textlines_condition ){
			//YOUTYel1("child follower");
		
			std::string block_code =	 current_block_indent  + open_tag_attr +"\n" +
										 follower_code + "\n" +
										 current_block_indent  + close_tag +"\n";
			
		
			indent *IND = new indent(current_block_indent,current_block_lvl);
			block_desc = new descriptor(block_code , *IND);
		
			
		}

		if( outside_follower_cond && textlines_condition  ){
			//YOUTYel1("child follower");
		
			std::string block_code =	 current_block_indent  + open_tag_attr + "\n"+
										 current_block_indent  + close_tag     + "\n"+
										 follower_indent +follower_code  + "\n";
										 
			
			indent *IND = new indent(current_block_indent,current_block_lvl);
			block_desc = new descriptor(block_code , *IND);
		
			
		}
		else{
			
			std::ostringstream lvl_s;
			lvl_s << "line(" << d_loc__.first_line << ") .... semantic error " ;
			YOUTYel1(lvl_s.str());
			
			// semantic ERROR .... 
			
		}
		
		std::ostringstream lvl_s;
		lvl_s << "LVL(" << current_block_lvl << "):block-> indents tag attributs T_NLINE follower " ;
		YOUTYel1(lvl_s.str());
		
		return block_desc;


}
;
Block::descriptor apply_rule3() // NO ATTRIBUTES / NO TEXT RULE
{
	
		// GETTIN INFO

		// BLOCK CLASS :  current_block indent
		int     current_block_lvl	 		=    block_ind->lvl_;
		std::string current_block_indent 	=    block_ind->indent_;
		// BLOCK CLASS :  follower block information
		std::string follower_code	 =    (follower_desc->code);
		std::string follower_indent	 =    (follower_desc->indent_s).indent_;
		int         follower_lvl 	 =    (follower_desc->indent_s).lvl_;
		// BLOCK CLASS :  NO TEXT RULE 
		// BLOCK CLASS : tag name 
		std::string tag_name  		 = *$2 ;
		// BLOCK CLASS :  NO attributes 
	

		std::string open_tag_attr        = "<" + tag_name  + ">" ;
		std::string close_tag            = "</" + tag_name + ">";
		
// TODO
// CHECK   : textlines indent_lvl =  the current block 
// IF TRUE : concatenate  textlines code to block code 
// ELSE    : semantic error 
		
		
// always must :   textlines_lvl = current_block_lvl


		//int         textlines_lvl 		= 0;
		//std::string textlines_code    = "";
		//std::string textlines_indent    = "";
		


		bool textlines_cond			 = (textlines_lvl == current_block_lvl+1)?true:false ;
		bool sibling_follower_cond	 = (current_block_lvl == follower_lvl)?true:false ;
		bool child_follower_cond 	 = (current_block_lvl+1 == follower_lvl)?true:false ;
		bool outside_follower_cond	 = (follower_lvl < current_block_lvl)?true:false ;

		

		if( sibling_follower_cond && textlines_cond ){
		
			YOUTYel1("sibling follower");
			
			// SAME LEVEL
			// follower code comes after 
			
			std::string block_code =	current_block_indent	+  open_tag_attr + "\n"+
										current_block_indent	+  close_tag + "\n"+
										follower_code ;
										
			
			
			indent *IND = new indent(current_block_indent,current_block_lvl);
			block_desc = new descriptor(block_code , *IND);
		
			
		}

		
		
		if(child_follower_cond && textlines_condition ){
			//YOUTYel1("child follower");
		
			std::string block_code =	 current_block_indent  + open_tag_attr +"\n" +
										 follower_code + "\n" +
										 current_block_indent  + close_tag +"\n";
			
		
			indent *IND = new indent(current_block_indent,current_block_lvl);
			block_desc = new descriptor(block_code , *IND);
		
			
		}

		if( outside_follower_cond && textlines_condition  ){
			//YOUTYel1("child follower");
		
			std::string block_code =	 current_block_indent  + open_tag_attr + "\n"+
										 current_block_indent  + close_tag     + "\n"+
										 follower_indent +follower_code  + "\n";
										 
			
			indent *IND = new indent(current_block_indent,current_block_lvl);
			block_desc = new descriptor(block_code , *IND);
		
			
		}
		else{
			
			std::ostringstream lvl_s;
			lvl_s << "line(" << d_loc__.first_line << ") .... semantic error " ;
			YOUTYel1(lvl_s.str());
			
			// semantic ERROR .... 
			
		}
		
		std::ostringstream lvl_s;
		lvl_s << "LVL(" << current_block_lvl << "):block-> indents tag attributs T_NLINE follower " ;
		YOUTYel1(lvl_s.str());
		
		return block_desc;




}
;