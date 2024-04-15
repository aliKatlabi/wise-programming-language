%baseclass-preinclude "wise_h_semantics.h"

%lsp-needed

%token <str> T_HTML
%token <str> T_HEAD
%token <str> T_TITLE
%token <str> T_BODY 
%token <str> T_H1
%token <str> T_H2
%token <str> T_H3
%token <str> T_H4
%token <str> T_H5
%token <str> T_H6

%token <str> T_P
%token <str> T_BR
%token <str> T_HR

%token <str> T_ACRONYM
%token <str> T_ABBR
%token <str> T_ADDRESS
%token <str> T_B
%token <str> T_BDI
%token <str> T_BDO
%token <str> T_BIG
%token <str> T_BLOCKQUOTE
%token <str> T_CENTER
%token <str> T_CITE
%token <str> T_CODE

%token <str> T_DEL
%token <str> T_DFN
%token <str> T_EM
%token <str> T_FONT

%token <str> T_I 
%token <str> T_INS
%token <str> T_KBD
%token <str> T_MARK
%token <str> T_METER
%token <str> T_PRE
%token <str> T_PROGRESS
%token <str> T_Q
%token <str> T_RP
%token <str> T_RT
%token <str> T_RUBY
%token <str> T_S
%token <str> T_SAMP
%token <str> T_SMALL
%token <str> T_STRIKE
%token <str> T_STRONG
%token <str> T_SUB

%token <str> T_SUP
%token <str> T_TEMPLATE
%token <str> T_TIME
%token <str> T_TT
%token <str> T_U
%token <str> T_WBR
%token <str> T_VIDEO

%token <str> T_OPTION
%token <str> T_FORM
%token <str> T_INPUT
%token <str> T_TEXTAREA
%token <str> T_BUTTON
%token <str> T_SELECT
%token <str> T_OPTGROUP
%token <str> T_OPTON
%token <str> T_LABEL
%token <str> T_FIELDSET
%token <str> T_LEGEND
%token <str> T_DATALIST
%token <str> T_OUTPUT


%token <str> T_FRAME
%token <str> T_FRAMESET
%token <str> T_NOFRAMES
%token <str> T_IFRAME


%token <str> T_IMG
%token <str> T_MAP
%token <str> T_AREA
%token <str> T_CANVAS
%token <str> T_FIGCAPTION
%token <str> T_FIGURE
%token <str> T_PICTURE
%token <str> T_SVG


%token <str> T_AUDIO
%token <str> T_SOURCE
%token <str> T_TRACK
%token <str> T_VAREO

%token <str> T_A
%token <str> T_LINK
%token <str> T_NAV


%token <str> T_UL
%token <str> T_OL
%token <str> T_LI 
%token <str> T_DIR
%token <str> T_DL
%token <str> T_DT
%token <str> T_DD


%token <str> T_CAPTION
%token <str> T_TH
%token <str> T_TR
%token <str> T_TD 
%token <str> T_THEAD
%token <str> T_TBODY
%token <str> T_TFOOT
%token <str> T_COL
%token <str> T_COLGROUP

%token <str> T_STYLE
%token <str> T_DIV 
%token <str> T_SPAN
%token <str> T_HEADER
%token <str> T_FOOTER
%token <str> T_MAIN
%token <str> T_SECTION
%token <str> T_ARTICLE
%token <str> T_ASIDE
%token <str> T_DETAILS
%token <str> T_DIALOG
%token <str> T_SUMMARY
%token <str> T_DATA

%token <str> T_META
%token <str> T_BASE
%token <str> T_BASEFONT

%token <str> T_SCRIPT
%token <str> T_NOSCRIPT
%token <str> T_APPLET
%token <str> T_EMBED
%token <str> T_OBJECT
%token <str> T_PARAM
%token <str> T_VAR


%token <str> T_STR
%token <str> T_VARIABLE

%token  <str> T_NLINE;
%token  <str> T_INDENT;

%token  T_COLON;

%token  T_CLOSE;
%token  T_OPEN;

%token  T_ASSIGN;
%token  T_EXTRACT

%token  T_QM;
%token  T_SQM;


%token  T_LIST;
%token  T_GROUP;
%token  T_TABLE;

%token  T_GLOBCONT;
%token  T_BLKCONT;
%token  T_DOT;

%union
{
  std::string *str;
  descriptor  *Desc; 
  indent *Ind;
  
}

%type <str>  document statements statement assignment tag attributs string block_container
%type <Ind>  indents
%type <Desc>  textlines block




%start document

%%

document:
	statements{
		YOUTYel1("document-> statements");
		$$ = new std::string(*$1);
		std::cout<<*$$;	
		
		delete $1;
		
	
	}
;

statements:

    statement
    {
	   
	   $$ = new std::string(*$1);
	   delete $1;
	   
       YOUTYel1("statements -> statement");
    }
|
    statement statements
    {

		$$ = new std::string(*$1 + *$2);
	    delete $1;

		YOUTYel1("statements ->  statement statements");
    }
|
	statements T_GLOBCONT tag T_NLINE statements 
	{
		$$ =  new std::string("\n<"+*$3+">\n"+*$5+"\n</"+*$3+">\n");
		
		delete $1;
		delete $3;
		delete $4;
		delete $5;

		YOUTYel1("statements -> T_GLOBCONT tag T_NLINE statements");
	}
;

statement:
	block T_NLINE
	{
		std::string code = $1->code;
		$$ = new std::string(code);
		
		delete $2;
		delete $1;

		YOUTYel1("block statement");
	}
|
	assignment T_NLINE
	{
	
		$$ = new std::string(*$2);
		
		delete $2;

		YOUTYel1("assignment statement");
	}
|
	block_container
	{
		YOUTYel1("block_container");
		std::string code = *$1;
		$$ = new std::string(code);
		delete $1;
	}
|
	T_NLINE
	{
		$$ = new std::string("");
		delete $1;

		YOUTYel1("T_NLINE statement");
	}
;


block_container:
	T_BLKCONT tag attributs T_NLINE block T_NLINE
	{
		// block container : ~ tag : 'class=a' \n block \n
		//	
		/*
			it should be used to contain the block directly under it 
		
		*/
		
		YOUTYel1("block_container -> T_BLKCONT tag attributs T_NLINE block");
		
		($5->indent_s).lvl_++;
		($5->indent_s).indent_+="\t";
		$5->reform();
	
		std::string tag_name  		 = *$2 ;
	
		std::string attributs 		 = *$3 ;
		std::string blockcode =   $5->code ;
		
		std::string *code  = new std::string ("<"+tag_name+attributs+">\n" + blockcode +"\n</"+tag_name+">\n");
	
		$$ = code ;
		
		delete $2;
		delete $3;
		delete $4;
		delete $5;
	
	
	}

;
assignment:
  T_VARIABLE T_ASSIGN T_STR
	{
		YOUTRed("assignment->T_VAR T_LEFT T_HYP  T_STR");
		
			
		if(symbol_table.count(*$1) >0){
			std::stringstream ss;
			ss << "Re-declared variable: " <<*$1<<std::endl;
			
			error( ss.str().c_str() );
		}
		std::string tmp = *$3;
		std::string store = tmp.substr(1,tmp.length()-2);
		symbol_table[*$1] = var_data(d_loc__.first_line,store);
		
		delete $3;
		delete $1;
	}
;

block:
	T_DOT
	{
		indent i = indent("",0);
		$$  = new descriptor("" , i);
		YOUTYel1("block->indents");

	}
|
	indents tag attributs T_NLINE textlines block 
	{
		YOUTYel1("block->indents tag attributs T_NLINE textlines block");
		
		// GETTIN INFO

		// BLOCK CLASS :  current_block indent
		int     current_block_lvl	 		=    $1->lvl_;
		std::string current_block_indent 	=    $1->indent_;
		// BLOCK CLASS :  follower block information

		std::string follower_code	 =    ($6->code);
		std::string follower_indent	 =    ($6->indent_s).indent_;
		int         follower_lvl 	 =    ($6->indent_s).lvl_;
		// BLOCK CLASS :  textlines 
		std::string textlines_code   				 = ($5->code);
		std::string textlines_indent   				 = ($5->indent_s).indent_;
		int 		textlines_lvl      			 	 = ($5->indent_s).lvl_;

		// BLOCK CLASS : tag name 
		std::string tag_name  		 = *$2 ;
		// BLOCK CLASS :  attributes 
		std::string attributs 		 = *$3 ;
		
		std::string open_tag_attr        = "<" + tag_name +" "+ attributs + ">" ;
		std::string close_tag            = "</" + tag_name + ">";


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
			$$ = new descriptor(block_code , *IND);
		
			
		}
		
		if(child_follower_cond && textlines_cond ){
			//YOUTYel1("child follower");
		
			std::string block_code =	 current_block_indent  + open_tag_attr +"\n" +
										 textlines_code +
										 follower_code + "\n" +
										 current_block_indent  + close_tag +"\n";
			
		
			indent *IND = new indent(current_block_indent,current_block_lvl);
			$$  = new descriptor(block_code , *IND);
		
			
		}
		if( outside_follower_cond && textlines_cond  ){
			//YOUTYel1("child follower");
		
			std::string block_code =	 current_block_indent  + open_tag_attr + "\n"+
										 textlines_code +
										 current_block_indent  + close_tag     + "\n"+
										 follower_indent +follower_code  + "\n";
										 
			
			indent *IND = new indent(current_block_indent,current_block_lvl);
			$$  = new descriptor(block_code , *IND);
		
			
		}
		if(!sibling_follower_cond&&!outside_follower_cond&&!child_follower_cond&&!textlines_cond){
			
			std::ostringstream lvl_s;
			
			
			lvl_s << "line(" << d_loc__.first_line <<"semantic error\n"<<"\ntxt lvl :"<<textlines_lvl
													<<"\ncurrent block"
													<<current_block_lvl
													<<"\nfollow block"<<follower_lvl<<"\n";
			YOUTYel1(lvl_s.str());
													
			// semantic ERROR .... 
			
		}


		delete $1;
		delete $2;
		delete $3;
		delete $5;
		delete $6;
	}
|
	indents tag attributs T_NLINE block 
	{
		YOUTYel1("block->indents tag attributs T_NLINE block");
		
			// GETTIN INFO

		// BLOCK CLASS :  current_block indent
		int     current_block_lvl	 			 =    $1->lvl_;
		std::string current_block_indent 		 =    $1->indent_;
		// BLOCK CLASS :  follower block information
		std::string follower_code				 =    ($5->code);
		std::string follower_indent	 			 =    ($5->indent_s).indent_;
		int         follower_lvl 	 			 =    ($5->indent_s).lvl_;
		// BLOCK CLASS :  NO TEXT RULE 
		// BLOCK CLASS : tag name 
		std::string tag_name  		 = *$2 ;
		// BLOCK CLASS :  attributes 
		std::string attributs 		 = *$3 ;
		
		std::string open_tag_attr        = "<" + tag_name +  attributs + ">" ;
		std::string close_tag            = "</" + tag_name + ">";
		


		bool sibling_follower_cond	 = (current_block_lvl == follower_lvl)?true:false ;
		bool child_follower_cond 	 = (current_block_lvl+1 == follower_lvl)?true:false ;
		bool outside_follower_cond	 = (follower_lvl < current_block_lvl)?true:false ;

		
		bool rule;
		
		
		if( sibling_follower_cond  ){
		
			YOUTYel1("sibling follower");
			
			// SAME LEVEL
			// follower code comes after 
			
			std::string block_code =	current_block_indent	+  open_tag_attr + "\n"+
										current_block_indent	+  close_tag + "\n"+
										follower_code ;
										
			
			
			indent *IND = new indent(current_block_indent,current_block_lvl);
			$$ = new descriptor(block_code , *IND);
		
			
		}

		
		
		if(child_follower_cond  ){
			//YOUTYel1("child follower");
		
			std::string block_code =	 current_block_indent  + open_tag_attr +"\n" +
										 follower_code + "\n" +
										 current_block_indent  + close_tag +"\n";
			
		
			indent *IND = new indent(current_block_indent,current_block_lvl);
			$$ = new descriptor(block_code , *IND);
		
			
		}

		if( outside_follower_cond   ){
			//YOUTYel1("child follower");
		
			std::string block_code =	 current_block_indent  + open_tag_attr + "\n"+
										 current_block_indent  + close_tag     + "\n"+
										 follower_code  + "\n";
										 
			
			indent *IND = new indent(current_block_indent,current_block_lvl);
			$$ = new descriptor(block_code , *IND);
		
			
		}
		if(!sibling_follower_cond&&!outside_follower_cond&&!child_follower_cond){
			
			std::ostringstream lvl_s;
			
			lvl_s << "line(" << d_loc__.first_line <<"semantic error\n"<<"\ncurrent_block_lvl :"
													<<current_block_lvl
													<<"\nfollower_lvl : "<<follower_lvl<<"\n";
													
			YOUTYel1(lvl_s.str());
			// semantic ERROR .... 
			
		}
		
		delete $1;
		delete $2;
		delete $3;
		delete $5;
	}
|
	indents tag attributs T_NLINE textlines 
	{
		YOUTYel1("block->indents tag attributs T_NLINE indents");
		
		
		// GETTIN INFO
		
		// BLOCK CLASS :  NO TEXT RULE 
		// BLOCK CLASS :  NO FOLLOWER RULE 
		//std::string follower_indent	 =    (follower_desc->indent_s).indent_;
		//int         follower_lvl 	 =    (follower_desc->indent_s).lvl_;
		std::string follower_code	 =    "";
		
		std::string textlines_code   				 = ($5->code);
		std::string textlines_indent   				 = ($5->indent_s).indent_;
		int 		textlines_lvl      			 	 = ($5->indent_s).lvl_;

		// BLOCK CLASS :  current_block indent
		int     current_block_lvl	 		=    $1->lvl_;
		std::string current_block_indent 	=    $1->indent_;

		// BLOCK CLASS :  follower block information
	
		// BLOCK CLASS : tag name 
		std::string tag_name  		 = *$2 ;
		// BLOCK CLASS :  attributes 

		std::string attributes = *$3;


		std::string open_tag_attr        = "<" + tag_name+  attributes  + ">" ;
		std::string close_tag            = "</" + tag_name + ">";
	
		std::string block_code =		current_block_indent	+  open_tag_attr + "\n"+
										textlines_code  +
										current_block_indent	+  close_tag + "\n"+
										follower_code ;
										
			
			
		indent *IND = new indent(current_block_indent,current_block_lvl);
		$$ = new descriptor(block_code , *IND);
	
		delete $1;
		delete $2;
		delete $3;
	}

;


textlines:
	indents T_STR T_NLINE 
	{
		YOUTYel1("textlines ->indents T_STR T_NLINE");
		
		$$ = new descriptor("", *$1);
		
		
		int  		curr_line_lvl    	= $1->lvl_;
		std::string curr_line_indent 	= $1->indent_;
		std::string tmptext= *$2;
		
		std::string curr_line_code   	= tmptext.substr(1,tmptext.length()-2);
		//textlines
		//std::string next_line_code   		= ($5->code);
		//std::string next_line_indent   	= ($5->indent_s).indent_;
		//int next_line_lvl      			 = ($5->indent_s).lvl_;

		std::string line_code = curr_line_indent + curr_line_code +*$3;

		$$ = new descriptor(line_code ,*$1);
		
		

		delete $1;
		delete $2;
		delete $3;
	}
|
	indents T_EXTRACT T_VARIABLE T_NLINE 
	{
		if(symbol_table.count(*$3) < 0){
			std::stringstream ss;
			ss << "undeclared variable : " <<*$3<<std::endl;
			
			error( ss.str().c_str() );
		}else{
			int  		curr_line_lvl    	= $1->lvl_;
			std::string curr_line_indent 	= $1->indent_;
			std::string tmptext				= curr_line_indent+symbol_table[*$3].store+*$4;
			
			$$ = new descriptor(tmptext ,*$1);
		
		
		
		}
}
;


indents:
	
	{
		$$ = new indent("",0);
		
		YOUTRed("indents-> e");
	}
|
	T_INDENT indents
	{
		int lvl = $2->lvl_ +1 ;
		std::string idt =  $2->indent_ + *$1;
		
		$$ = new indent(idt,lvl) ;
		delete $1;
		delete $2;
		YOUTRed("indents-> INDENT indents");
		
	}
;


attributs:
	T_COLON 
	{
		
		$$ = new std::string("");
		
		YOUTRed("attr->T_COLON ");
	}
| 
	T_COLON  T_STR  
	{
		std::string tmp = *$2;
		
		std::string store = tmp.substr(1,tmp.length()-2);
		$$ = new std::string(store);
		
		delete $2;
		YOUTRed("attr->T_COLON T_STR ");
	}
| 
	T_COLON T_EXTRACT T_VARIABLE 
	{
		
		// : (VARIABLE)
		// TODO : implent sympole table 
		
		if(symbol_table.count(*$3) < 0){
			std::stringstream ss;
			ss << "undeclared variable : " <<*$3<<std::endl;
			
			error( ss.str().c_str() );
		}else{
		
			$$ = new std::string(symbol_table[*$3].store);
			}
			
			delete $3;
		
		YOUTRed("attr->T_COLON T_EXTRACT T_VAR ");
	}
;

tag:
	T_A
	{
		$$ = new std::string(*$1);
		YOUTRed("<" + *$1 +">"); delete $1;
		
	}
| 
	T_DIV 
	{
		$$ = new std::string(*$1);
		YOUTRed("<" + *$1 +">"); delete $1;
	}
| 
	T_SPAN
	{
		$$ = new std::string(*$1);
		YOUTRed("<" + *$1 +">"); delete $1;
	}
| 
	T_P
	{
		$$ = new std::string(*$1);
		YOUTRed("<" + *$1 +">"); delete $1;
	}

|
	T_HTML
	{
		$$ = new std::string(*$1);
		YOUTRed("<" + *$1 +">"); delete $1;
	}
|
	
	T_HEAD
	{
		$$ = new std::string(*$1);
		YOUTRed("<" + *$1 +">"); delete $1;
	}
|
	
	T_TITLE
	{
		$$ = new std::string(*$1);
		YOUTRed("<" + *$1 +">"); delete $1;
	}
|
	
	T_BODY
	{
		$$ = new std::string(*$1);
		YOUTRed("<" + *$1 +">"); delete $1;
	}
|

	T_H1
	{
		$$ = new std::string(*$1);
		YOUTRed("<" + *$1 +">"); delete $1;
	}
|
	

	T_H2
	{
		$$ = new std::string(*$1);
		YOUTRed("<" + *$1 +">"); delete $1;
	}
|
	

	T_H3
	{
		$$ = new std::string(*$1);
		YOUTRed("<" + *$1 +">"); delete $1;
	}
|
	

	T_H4
	{
		$$ = new std::string(*$1);
		YOUTRed("<" + *$1 +">"); delete $1;
	}
|
	

	T_H5
	{
		$$ = new std::string(*$1);
		YOUTRed("<" + *$1 +">"); delete $1;
	}
|
	

	T_H6
	{
		$$ = new std::string(*$1);
		YOUTRed("<" + *$1 +">"); delete $1;
	}
|
	

	T_BR
	{
		$$ = new std::string(*$1);
		YOUTRed("<" + *$1 +">"); delete $1;
	}
|
	

	T_HR
	{
		$$ = new std::string(*$1);
		YOUTRed("<" + *$1 +">"); delete $1;
	}
|
	

	T_ACRONYM
	{
		$$ = new std::string(*$1);
		YOUTRed("<" + *$1 +">"); delete $1;
	}
|
	T_ABBR
	{
		$$ = new std::string(*$1);
		YOUTRed("<" + *$1 +">"); delete $1;
	}
|
	
	T_ADDRESS
	{
		$$ = new std::string(*$1);
		YOUTRed("<" + *$1 +">"); delete $1;
	}
|
	
	T_B
	{
		$$ = new std::string(*$1);
		YOUTRed("<" + *$1 +">"); delete $1;
	}
|
	
	T_BDI
	{
		$$ = new std::string(*$1);
		YOUTRed("<" + *$1 +">"); delete $1;
	}
|
	
	T_BDO
	{
		$$ = new std::string(*$1);
		YOUTRed("<" + *$1 +">"); delete $1;
	}
|
	
	T_BIG
	{
		$$ = new std::string(*$1);
		YOUTRed("<" + *$1 +">"); delete $1;
	}
|
	
	T_BLOCKQUOTE
	{
		$$ = new std::string(*$1);
		YOUTRed("<" + *$1 +">"); delete $1;
	}
|
	
	T_CENTER
	{
		$$ = new std::string(*$1);
		YOUTRed("<" + *$1 +">"); delete $1;
	}
|
	
	T_CITE
	{
		$$ = new std::string(*$1);
		YOUTRed("<" + *$1 +">"); delete $1;
	}
|
	
	T_CODE
	{
		$$ = new std::string(*$1);
		YOUTRed("<" + *$1 +">"); delete $1;
	}
|
	
	
	T_DEL
	{
		$$ = new std::string(*$1);
		YOUTRed("<" + *$1 +">"); delete $1;
	}
|
	
	T_DFN
	{
		$$ = new std::string(*$1);
		YOUTRed("<" + *$1 +">"); delete $1;
	}
|
	
	T_EM
	{
		$$ = new std::string(*$1);
		YOUTRed("<" + *$1 +">"); delete $1;
	}
|
	
	T_FONT
	{
		$$ = new std::string(*$1);
		YOUTRed("<" + *$1 +">"); delete $1;
	}
|
	
	T_I
	{
		$$ = new std::string(*$1);
		YOUTRed("<" + *$1 +">"); delete $1;
	}
|
	
	T_INS
	{
		$$ = new std::string(*$1);
		YOUTRed("<" + *$1 +">"); delete $1;
	}
|
	
	T_KBD
	{
		$$ = new std::string(*$1);
		YOUTRed("<" + *$1 +">"); delete $1;
	}
|
	
	T_MARK
	{
		$$ = new std::string(*$1);
		YOUTRed("<" + *$1 +">"); delete $1;
	}
|
	
	T_METER
	{
		$$ = new std::string(*$1);
		YOUTRed("<" + *$1 +">"); delete $1;
	}
|
	
	T_PRE
	{
		$$ = new std::string(*$1);
		YOUTRed("<" + *$1 +">"); delete $1;
	}
|
	
	T_PROGRESS
	{
		$$ = new std::string(*$1);
		YOUTRed("<" + *$1 +">"); delete $1;
	}
|
	
	T_Q
	{
		$$ = new std::string(*$1);
		YOUTRed("<" + *$1 +">"); delete $1;
	}
|
	
	T_RP
	{
		$$ = new std::string(*$1);
		YOUTRed("<" + *$1 +">"); delete $1;
	}
|
	
	T_RT
	{
		$$ = new std::string(*$1);
		YOUTRed("<" + *$1 +">"); delete $1;
	}
|
	
	T_RUBY
	{
		$$ = new std::string(*$1);
		YOUTRed("<" + *$1 +">"); delete $1;
	}
|
	
	T_S
	{
		$$ = new std::string(*$1);
		YOUTRed("<" + *$1 +">"); delete $1;
	}
|
	
	T_SAMP
	{
		$$ = new std::string(*$1);
		YOUTRed("<" + *$1 +">"); delete $1;
	}
|
	
	T_SMALL
	{
		$$ = new std::string(*$1);
		YOUTRed("<" + *$1 +">"); delete $1;
	}
|
	
	T_STRIKE
	{
		$$ = new std::string(*$1);
		YOUTRed("<" + *$1 +">"); delete $1;
	}
|
	
	T_STRONG
	{
		$$ = new std::string(*$1);
		YOUTRed("<" + *$1 +">"); delete $1;
	}
|
	
	T_SUB
	{
		$$ = new std::string(*$1);
		YOUTRed("<" + *$1 +">"); delete $1;
	}
|
	
	T_TEMPLATE
	{
		$$ = new std::string(*$1);
		YOUTRed("<" + *$1 +">"); delete $1;
	}
|
	
	T_TIME
	{
		$$ = new std::string(*$1);
		YOUTRed("<" + *$1 +">"); delete $1;
	}
|
	
	T_TT
	{
		$$ = new std::string(*$1);
		YOUTRed("<" + *$1 +">"); delete $1;
	}
|
	
	T_U
	{
		$$ = new std::string(*$1);
		YOUTRed("<" + *$1 +">"); delete $1;
	}
|
	
	T_WBR
	{
		$$ = new std::string(*$1);
		YOUTRed("<" + *$1 +">"); delete $1;
	}
|
	
	T_OPTION
	{
		$$ = new std::string(*$1);
		YOUTRed("<" + *$1 +">"); delete $1;
	}
|
	
	T_FORM
	{
		$$ = new std::string(*$1);
		YOUTRed("<" + *$1 +">"); delete $1;
	}
|
	
	T_INPUT
	{
		$$ = new std::string(*$1);
		YOUTRed("<" + *$1 +">"); delete $1;
	}
|
	T_TEXTAREA
	{
		$$ = new std::string(*$1);
		YOUTRed("<" + *$1 +">"); delete $1;
	}
|
	
	T_BUTTON
	{
		$$ = new std::string(*$1);
		YOUTRed("<" + *$1 +">"); delete $1;
	}
|
	T_SELECT
	{
		$$ = new std::string(*$1);
		YOUTRed("<" + *$1 +">"); delete $1;
	}
|
	
	T_OPTGROUP
	{
		$$ = new std::string(*$1);
		YOUTRed("<" + *$1 +">"); delete $1;
	}
|
	T_OPTON
	{
		$$ = new std::string(*$1);
		YOUTRed("<" + *$1 +">"); delete $1;
	}
|
	
	T_LABEL
	{
		$$ = new std::string(*$1);
		YOUTRed("<" + *$1 +">"); delete $1;
	}
|
	T_FIELDSET
	{
		$$ = new std::string(*$1);
		YOUTRed("<" + *$1 +">"); delete $1;
	}
|
	
	T_LEGEND
	{
		$$ = new std::string(*$1);
		YOUTRed("<" + *$1 +">"); delete $1;
	}
|
	T_DATALIST
	{
		$$ = new std::string(*$1);
		YOUTRed("<" + *$1 +">"); delete $1;
	}
|
	
	T_OUTPUT
	{
		$$ = new std::string(*$1);
		YOUTRed("<" + *$1 +">"); delete $1;
	}
|
	T_FRAME
	{
		$$ = new std::string(*$1);
		YOUTRed("<" + *$1 +">"); delete $1;
	}
|
	
	T_FRAMESET
	{
		$$ = new std::string(*$1);
		YOUTRed("<" + *$1 +">"); delete $1;
	}
|
	T_NOFRAMES
	{
		$$ = new std::string(*$1);
		YOUTRed("<" + *$1 +">"); delete $1;
	}
|
	
	T_IFRAME
	{
		$$ = new std::string(*$1);
		YOUTRed("<" + *$1 +">"); delete $1;
	}
|
	T_IMG
	{
		$$ = new std::string(*$1);
		YOUTRed("<" + *$1 +">"); delete $1;
	}
|
	T_MAP
	{
		$$ = new std::string(*$1);
		YOUTRed("<" + *$1 +">"); delete $1;
	}
|

	
	T_AREA
	{
		$$ = new std::string(*$1);
		YOUTRed("<" + *$1 +">"); delete $1;
	}
|
	T_CANVAS
	{
		$$ = new std::string(*$1);
		YOUTRed("<" + *$1 +">"); delete $1;
	}
|
	
	T_FIGCAPTION
	{
		$$ = new std::string(*$1);
		YOUTRed("<" + *$1 +">"); delete $1;
	}
|
	T_FIGURE
	{
		$$ = new std::string(*$1);
		YOUTRed("<" + *$1 +">"); delete $1;
	}
|
	
	T_PICTURE
	{
		$$ = new std::string(*$1);
		YOUTRed("<" + *$1 +">"); delete $1;
	}
|
	T_SVG
	{
		$$ = new std::string(*$1);
		YOUTRed("<" + *$1 +">"); delete $1;
	}
|
	
	T_AUDIO
	{
		$$ = new std::string(*$1);
		YOUTRed("<" + *$1 +">"); delete $1;
	}
|
	T_SOURCE
	{
		$$ = new std::string(*$1);
		YOUTRed("<" + *$1 +">"); delete $1;
	}
|
	
	T_TRACK
	{
		$$ = new std::string(*$1);
		YOUTRed("<" + *$1 +">"); delete $1;
	}
|
	T_VAREO
	{
		$$ = new std::string(*$1);
		YOUTRed("<" + *$1 +">"); delete $1;
	}
|
	
	T_LINK
	{
		$$ = new std::string(*$1);
		YOUTRed("<" + *$1 +">"); delete $1;
	}
|
	T_NAV
	{
		$$ = new std::string(*$1);
		YOUTRed("<" + *$1 +">"); delete $1;
	}
|
	
	T_UL
	{
		$$ = new std::string(*$1);
		YOUTRed("<" + *$1 +">"); delete $1;
	}
|
	T_OL
	{
		$$ = new std::string(*$1);
		YOUTRed("<" + *$1 +">"); delete $1;
	}
|
	
	T_LI
	{
		$$ = new std::string(*$1);
		YOUTRed("<" + *$1 +">"); delete $1;
	}
|
	T_DIR
	{
		$$ = new std::string(*$1);
		YOUTRed("<" + *$1 +">"); delete $1;
	}
|
	
	T_DL
	{
		$$ = new std::string(*$1);
		YOUTRed("<" + *$1 +">"); delete $1;
	}
|
	T_DT
	{
		$$ = new std::string(*$1);
		YOUTRed("<" + *$1 +">"); delete $1;
	}
|
	
	T_DD
	{
		$$ = new std::string(*$1);
		YOUTRed("<" + *$1 +">"); delete $1;
	}
|
	T_CAPTION
	{
		$$ = new std::string(*$1);
		YOUTRed("<" + *$1 +">"); delete $1;
	}
|
	
	T_TH
	{
		$$ = new std::string(*$1);
		YOUTRed("<" + *$1 +">"); delete $1;
	}
|
	T_TR
	{
		$$ = new std::string(*$1);
		YOUTRed("<" + *$1 +">"); delete $1;
	}
|
	
	T_TD
	{
		$$ = new std::string(*$1);
		YOUTRed("<" + *$1 +">"); delete $1;
	}
|
	T_THEAD
	{
		$$ = new std::string(*$1);
		YOUTRed("<" + *$1 +">"); delete $1;
	}
|
	
	T_TBODY
	{
		$$ = new std::string(*$1);
		YOUTRed("<" + *$1 +">"); delete $1;
	}
|
	T_TFOOT
	{
		$$ = new std::string(*$1);
		YOUTRed("<" + *$1 +">"); delete $1;
	}
|
	
	T_COL
	{
		$$ = new std::string(*$1);
		YOUTRed("<" + *$1 +">"); delete $1;
	}
|
	T_COLGROUP
	{
		$$ = new std::string(*$1);
		YOUTRed("<" + *$1 +">"); delete $1;
	}
|
	
	T_STYLE
	{
		$$ = new std::string(*$1);
		YOUTRed("<" + *$1 +">"); delete $1;
	}
|
	T_DIV
	{
		$$ = new std::string(*$1);
		YOUTRed("<" + *$1 +">"); delete $1;
	}
|
	
	T_SPAN
	{
		$$ = new std::string(*$1);
		YOUTRed("<" + *$1 +">"); delete $1;
	}
|
	T_HEADER
	{
		$$ = new std::string(*$1);
		YOUTRed("<" + *$1 +">"); delete $1;
	}
|
	
	T_FOOTER
	{
		$$ = new std::string(*$1);
		YOUTRed("<" + *$1 +">"); delete $1;
	}
|
	T_MAIN
	{
		$$ = new std::string(*$1);
		YOUTRed("<" + *$1 +">"); delete $1;
	}
|
	
	T_SECTION
	{
		$$ = new std::string(*$1);
		YOUTRed("<" + *$1 +">"); delete $1;
	}
|
	T_ARTICLE
	{
		$$ = new std::string(*$1);
		YOUTRed("<" + *$1 +">"); delete $1;
	}
|
	
	T_ASIDE
	{
		$$ = new std::string(*$1);
		YOUTRed("<" + *$1 +">"); delete $1;
	}
|
	T_DETAILS
	{
		$$ = new std::string(*$1);
		YOUTRed("<" + *$1 +">"); delete $1;
	}
|
	
	T_DIALOG
	{
		$$ = new std::string(*$1);
		YOUTRed("<" + *$1 +">"); delete $1;
	}
|
	T_SUMMARY
	{
		$$ = new std::string(*$1);
		YOUTRed("<" + *$1 +">"); delete $1;
	}
|
	
	T_DATA
	{
		$$ = new std::string(*$1);
		YOUTRed("<" + *$1 +">"); delete $1;
	}
|
	T_META
	{
		$$ = new std::string(*$1);
		YOUTRed("<" + *$1 +">"); delete $1;
	}
|
	
	T_BASE
	{
		$$ = new std::string(*$1);
		YOUTRed("<" + *$1 +">"); delete $1;
	}
|
	T_BASEFONT
	{
		$$ = new std::string(*$1);
		YOUTRed("<" + *$1 +">"); delete $1;
	}
|
	
	T_SCRIPT
	{
		$$ = new std::string(*$1);
		YOUTRed("<" + *$1 +">"); delete $1;
	}
|
	T_NOSCRIPT
	{
		$$ = new std::string(*$1);
		YOUTRed("<" + *$1 +">"); delete $1;
	}
|
	
	T_APPLET
	{
		$$ = new std::string(*$1);
		YOUTRed("<" + *$1 +">"); delete $1;
	}
|
	T_EMBED
	{
		$$ = new std::string(*$1);
		YOUTRed("<" + *$1 +">"); delete $1;
	}
|
	
	T_OBJECT
	{
		$$ = new std::string(*$1);
		YOUTRed("<" + *$1 +">"); delete $1;
	}
|
	T_PARAM
	{
		$$ = new std::string(*$1);
		YOUTRed("<" + *$1 +">"); delete $1;
	}
;

