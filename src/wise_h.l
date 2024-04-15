%option noyywrap c++ yylineno

%{
#include <iostream>
#include <stdlib.h>
#include "Parserbase.h"

#define RED     "\033[31m" 
#define WHITE   "\033[37m"
#define RESET   "\033[0m"
#define GREEN   "\033[32m"
#define MARGIN std::string(7,'\t')
#define LEXERR std::cerr<<MARGIN<<"line_ "<<lineno()<<" ====> "<<yytext<<" :\n"<<MARGIN<<"lexical error"<<RESET<<std::endl; 
#define OUT(a,b) (b?std::cerr<<GREEN<<MARGIN<<a<<" ====> "<<yytext<<RESET<<std::endl:std::cerr<<"");
bool lexeroutput_ = false;

#define VIS lexeroutput_ 


%}

DIGIT  		[0-9]
SPACE        [ ]
LETTER      [a-zA-Z]

%%


\'([^']*|\n*)*\' OUT("T_STR",VIS); return Parser::T_STR;
	

"html" 			OUT("TAG",VIS); return Parser::T_HTML;
"a"  		  	OUT("TAG",VIS); return Parser::T_A  ;
"abbr"     		OUT("TAG",VIS); return Parser::T_ABBR  ;
"acronym"     	OUT("TAG",VIS); return Parser::T_ACRONYM  ;
"address"     	OUT("TAG",VIS); return Parser::T_ADDRESS  ;
"applet"     	OUT("TAG",VIS); return Parser::T_APPLET ;
"area"     		OUT("TAG",VIS); return Parser::T_AREA  ;
"article"     	OUT("TAG",VIS); return Parser::T_ARTICLE  ;
"aside"     	OUT("TAG",VIS); return Parser::T_ASIDE  ;
"audio"     	OUT("TAG",VIS); return Parser::T_AUDIO  ;
"b"     		OUT("TAG",VIS); return Parser::T_B  ;
"base"     		OUT("TAG",VIS); return Parser::T_BASE  ;
"basefont"     	OUT("TAG",VIS); return Parser::T_BASEFONT  ;
"bdi"     		OUT("TAG",VIS); return Parser::T_BDI  ;
"bdo"     		OUT("TAG",VIS); return Parser::T_BDO  ;
"big"     		OUT("TAG",VIS); return Parser::T_BIG  ;
"blockquote"    OUT("TAG",VIS); return Parser::T_BLOCKQUOTE  ;
"body"     		OUT("TAG",VIS); return Parser::T_BODY  ;
"br"     		OUT("TAG",VIS); return Parser::T_BR  ;
"button"     	OUT("TAG",VIS); return Parser::T_BUTTON  ;
"canvas"     	OUT("TAG",VIS); return Parser::T_CANVAS  ;
"caption"     	OUT("TAG",VIS); return Parser::T_CAPTION  ;
"center"     	OUT("TAG",VIS); return Parser::T_CENTER  ;
"cite"     		OUT("TAG",VIS); return Parser::T_CITE  ;
"code"     		OUT("TAG",VIS); return Parser::T_CODE  ;
"col"     		OUT("TAG",VIS); return Parser::T_COL  ;
"colgroup"     	OUT("TAG",VIS); return Parser::T_COLGROUP  ;
"data"     		OUT("TAG",VIS); return Parser::T_DATA  ;
"datalist"     	OUT("TAG",VIS); return Parser::T_DATALIST  ;
"dd"     		OUT("TAG",VIS); return Parser::T_DD  ;
"del"     		OUT("TAG",VIS); return Parser::T_DEL  ;
"details"     	OUT("TAG",VIS); return Parser::T_DETAILS  ;
"dfn"     		OUT("TAG",VIS); return Parser::T_DFN  ;
"dialog"     	OUT("TAG",VIS); return Parser::T_DIALOG  ;
"dir"     		OUT("TAG",VIS); return Parser::T_DIR  ;
"div"     		OUT("TAG",VIS); return Parser::T_DIV  ;
"dl"     		OUT("TAG",VIS); return Parser::T_DL  ;
"dt"     		OUT("TAG",VIS); return Parser::T_DT  ;
"em"     		OUT("TAG",VIS); return Parser::T_EM  ;
"embed"     	OUT("TAG",VIS); return Parser::T_EMBED  ;
"fieldset"     	OUT("TAG",VIS); return Parser::T_FIELDSET  ;
"figcaption"    OUT("TAG",VIS); return Parser::T_FIGCAPTION  ;
"figure"     	OUT("TAG",VIS); return Parser::T_FIGURE  ;
"font"     		OUT("TAG",VIS); return Parser::T_FONT ;
"footer"     	OUT("TAG",VIS); return Parser::T_FOOTER  ;
"form"     		OUT("TAG",VIS); return Parser::T_FORM  ;
"frame"     	OUT("TAG",VIS); return Parser::T_FRAME  ;
"frameset"     	OUT("TAG",VIS); return Parser::T_FRAMESET  ;
"h1"	 		OUT("TAG",VIS); return Parser::T_H1; 
"h2"	 		OUT("TAG",VIS); return Parser::T_H2; 
"h3"	 		OUT("TAG",VIS); return Parser::T_H3; 
"h4"	 		OUT("TAG",VIS); return Parser::T_H4; 
"h5"	 		OUT("TAG",VIS); return Parser::T_H5; 
"h6"     		OUT("TAG",VIS); return Parser::T_H6  ;
"head"     		OUT("TAG",VIS); return Parser::T_HEAD  ;
"header"     	OUT("TAG",VIS); return Parser::T_HEADER  ;
"hr"     		OUT("TAG",VIS); return Parser::T_HR  ;
"i"     		OUT("TAG",VIS); return Parser::T_I  ;
"iframe"     	OUT("TAG",VIS); return Parser::T_IFRAME  ;
"img"     		OUT("TAG",VIS); return Parser::T_IMG  ;
"input"     	OUT("TAG",VIS); return Parser::T_INPUT  ;
"ins"     		OUT("TAG",VIS); return Parser::T_INS  ;
"kbd"     		OUT("TAG",VIS); return Parser::T_KBD  ;
"label"     	OUT("TAG",VIS); return Parser::T_LABEL  ;
"legend"     	OUT("TAG",VIS); return Parser::T_LEGEND  ;
"li"     		OUT("TAG",VIS); return Parser::T_LI  ;
"link"     		OUT("TAG",VIS); return Parser::T_LINK  ;
"main"     		OUT("TAG",VIS); return Parser::T_MAIN  ;
"map"     		OUT("TAG",VIS); return Parser::T_MAP  ;
"mark"     		OUT("TAG",VIS); return Parser::T_MARK  ;
"meta"     		OUT("TAG",VIS); return Parser::T_META  ;
"meter"     	OUT("TAG",VIS); return Parser::T_METER  ;
"nav"     		OUT("TAG",VIS); return Parser::T_NAV  ;
"noframes"     	OUT("TAG",VIS); return Parser::T_NOFRAMES  ;
"noscript"     	OUT("TAG",VIS); return Parser::T_NOSCRIPT  ;
"object"     	OUT("TAG",VIS); return Parser::T_OBJECT  ;
"ol"     		OUT("TAG",VIS); return Parser::T_OL  ;
"optgroup"     	OUT("TAG",VIS); return Parser::T_OPTGROUP  ;
"option"     	OUT("TAG",VIS); return Parser::T_OPTION  ;
"output"     	OUT("TAG",VIS); return Parser::T_OUTPUT  ;
"p"     		OUT("TAG",VIS); return Parser::T_P  ;
"param"     	OUT("TAG",VIS); return Parser::T_PARAM  ;
"picture"     	OUT("TAG",VIS); return Parser::T_PICTURE  ;
"pre"     		OUT("TAG",VIS); return Parser::T_PRE  ;
"progress"     	OUT("TAG",VIS); return Parser::T_PROGRESS  ;
"q"     		OUT("TAG",VIS); return Parser::T_Q  ;
"rp"     		OUT("TAG",VIS); return Parser::T_RP  ;
"rt"     		OUT("TAG",VIS); return Parser::T_RT  ;
"ruby"     		OUT("TAG",VIS); return Parser::T_RUBY  ;
"s"     		OUT("TAG",VIS); return Parser::T_S  ;
"samp"     		OUT("TAG",VIS); return Parser::T_SAMP  ;
"script"     	OUT("TAG",VIS); return Parser::T_SCRIPT  ;
"section"     	OUT("TAG",VIS); return Parser::T_SECTION  ;
"select"     	OUT("TAG",VIS); return Parser::T_SELECT  ;
"small"     	OUT("TAG",VIS); return Parser::T_SMALL  ;
"source"     	OUT("TAG",VIS); return Parser::T_SOURCE  ;
"span"     		OUT("TAG",VIS); return Parser::T_SPAN  ;
"strike"     	OUT("TAG",VIS); return Parser::T_STRIKE  ;
"strong"     	OUT("TAG",VIS); return Parser::T_STRONG  ;
"style"     	OUT("TAG",VIS); return Parser::T_STYLE  ;
"sub"     		OUT("TAG",VIS); return Parser::T_SUB  ;
"summary"     	OUT("TAG",VIS); return Parser::T_SUMMARY  ;
"sup"     		OUT("TAG",VIS); return Parser::T_SUP  ;
"svg"     		OUT("TAG",VIS); return Parser::T_SVG  ;
"table"     	OUT("TAG",VIS); return Parser::T_TABLE  ;
"tbody"     	OUT("TAG",VIS); return Parser::T_TBODY  ;
"td"     		OUT("TAG",VIS); return Parser::T_TD  ;
"template"     	OUT("TAG",VIS); return Parser::T_TEMPLATE  ;
"textarea"     	OUT("TAG",VIS); return Parser::T_TEXTAREA  ;
"tfoot"     	OUT("TAG",VIS); return Parser::T_TFOOT  ;
"th"     		OUT("TAG",VIS); return Parser::T_TH  ;
"thead"     	OUT("TAG",VIS); return Parser::T_THEAD  ;
"time"     		OUT("TAG",VIS); return Parser::T_TIME  ;
"title"     	OUT("TAG",VIS); return Parser::T_TITLE  ;
"tr"     		OUT("TAG",VIS); return Parser::T_TR  ;
"track"     	OUT("TAG",VIS); return Parser::T_TRACK  ;
"tt"     		OUT("TAG",VIS); return Parser::T_TT  ;
"u"     		OUT("TAG",VIS); return Parser::T_U  ;
"ul"     		OUT("TAG",VIS); return Parser::T_UL  ;
"var"     		OUT("TAG",VIS); return Parser::T_VAR  ;
"video"     	OUT("TAG",VIS); return Parser::T_VIDEO  ;
"wbr"     		OUT("TAG",VIS); return Parser::T_WBR  ;
	




\t 			OUT("IND",VIS); 	return Parser::T_INDENT;
\n 			OUT("NLINE",VIS); 	return Parser::T_NLINE;

"<-"		OUT("Assign",VIS); 		return Parser::T_ASSIGN;
"->"		OUT("Extract",VIS); 	return Parser::T_EXTRACT;
"("			OUT("(",VIS); 			return Parser::T_OPEN;
")"			OUT(")",VIS); 			return Parser::T_CLOSE;
"<"			OUT("<",VIS); 			return Parser::T_GLOBCONT;
"<:"		OUT("<.",VIS); 			return Parser::T_BLKCONT;
":"			OUT(":",VIS); 			return Parser::T_COLON;
"list" 		OUT("list",VIS); 		return Parser::T_LIST;
"group"		OUT("group",VIS); 		return Parser::T_GROUP;
"."			OUT("group",VIS); 		return Parser::T_DOT;
	

{LETTER}({LETTER}|{DIGIT}|[-_="; ])* OUT("VARIABLE",VIS); 	return Parser::T_VARIABLE;

. {	
	
    std::cerr << "Line " << lineno() << ": Lexical error." << std::endl;
    exit(1);
}

%%
