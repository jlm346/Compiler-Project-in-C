/* definitions */

%{
#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include "tokendef.h"
int yycol = 0;
%}

yylineno = 1;

digit       [0-9]
number      [1-9][0-9]*
letter      [a-zA-Z]
identifier  [a-zA-Z][a-zA-Z,0-9]*
newline     \n
whitespace  [ \n\t]+


%%

 /* rules */ 

{newline}       {yycol = 0; yylineno++;}

"if"        		{yycol = yycol + yyleng; return KWD_IF;}
"else"        	{yycol = yycol + yyleng; return KWD_ELSE;}
"while"       {yycol = yycol + yyleng; return KWD_WHILE;}
"int"      	{yycol = yycol + yyleng; return KWD_INT;}
"string"       {yycol = yycol + yyleng; return KWD_STRING;}
"char"    	{yycol = yycol + yyleng; return KWD_CHAR;}
"return"       {yycol = yycol + yyleng; return KWD_RETURN;}
"void"       	{yycol = yycol + yyleng; return KWD_VOID;}

{identifier}    {/*

	char c = input();
	if (c == ' ' || c == '\n' || c == '\0' || c == '\t' || c == EOF ||
	    c == ';' || c == '+' || c == '-' || c == '*' || c == '/' || c == '<'
	    || c == '>' || c == '=' || c == '!' || c == ']' || c == ')' ||
		c == '}' || c == ',') {
		return ID;
}
	else {
		char * newString = (char*)(malloc(sizeof(char) * 256));
		int i = 0;
		while (c !=  '+' &&
      		   c !=  '-' &&
      		   c !=  '*' &&
      		   c !=  '/' &&
      		   c !=  '<' &&
      		   c !=  '>' &&
      		   c !=  '=' &&
      		   c !=  '!' &&
      		   c !=  ']' &&
      		   c !=  ')' &&
      		   c !=  '}' &&
      		   c !=  ',' &&
      		   c !=  ';' &&
      		   c != '\0' &&
      		   c != '\n' &&
      		   c != '\t' &&
      		   c !=  ' ' &&
      		   c != EOF) {

			newString[i] = c;
			i++;
			c = input();
		}
		for (int k = 0; k < i; k++) {
			yytext[yyleng + k] = newString[k];
		}
		return ILLEGALID;
	}*/
		yycol = yycol + yyleng;
		return ID;
}


{number}        {

	char c = input();
	if (c == ' ' || c == '\n' || c == '\0' || c == '\t') {
		yycol = yycol + yyleng;
		return INTCONST;
	}
	else {
		char * newString = (char*)(malloc(sizeof(char) * 256));
		int i = 0;
		newString[i] = c;
		c = input();
		while (c != ' ' && c != '\n' && c != '\0' && c != '\t') {
			i++;
			newString[i] = c;
			c = input();
		}
		i++;
		newString[i] = c;
		for (int k = 0; k < i; k++) {
			yytext[yyleng + k] = newString[k];
		}
		yycol = yycol + yyleng;

		return ILLEGALID;
	}
}


"0"				{

	char * newString = (char*)(malloc(sizeof(char) * 256));
	int i = 0;
	newString[i] = '0';
	char c = input();
	int val;
	bool stillNum = true;
	bool cequalsi = false;
	while (stillNum == true) {
		val = c - '0';
		for (int i = 0; i < 10; i++) {
			if (val == i) {
				cequalsi = true;
			}
		}
		if (cequalsi == true) {
			i++;
			newString[i] = c;
			c = input();
		}
		else
			stillNum = false;
		cequalsi = false;
	}
	yytext = newString;
	yycol = yycol + yyleng;
	return ILLEGALNUM;

}
"'"				{
	char * newString = (char*)(malloc(sizeof(char) * 3));
	char c = input();
	newString[0] = '\'';
	newString[1] = c;
	c = input();
	if (c == '\'') {
		newString[2] = '\'';
		yytext = newString;
		yycol = yycol + yyleng;
		return CHARCONST;
	}
	else {
		yycol = yycol + yyleng;
		return UNTERMCHAR;
	}


}

"+"             {yycol = yycol + yyleng; return OPER_ADD;}
"-"			{yycol = yycol + yyleng; return OPER_SUB;}
"*"				{yycol = yycol + yyleng; return OPER_MUL;}
"/"				{

	char next = input();
	if (next != '*' && next != '/') {
		yycol = yycol + yyleng;
		return OPER_DIV;
	}
	else if (next == '/') {
		while (next != '\n' || next == EOF || next == '\0') {
			next = input();
		}
		yycol = yycol + yyleng;
		return COMMENT;
	}
	else if (next == '*') {
		//printf("ASDFASDF\n");
		bool breaker = false;
		next = input();
		if (next == EOF || next == '\0') {
				yycol = yycol + yyleng;
				return UNTERMCOMMENT;
			}
		while (next != '*' && next != EOF && next != '\0' && breaker == false) {
			//printf("ENTERED?\n");
			next = input();
			if (next == '*') {
				next = input();
				if (next == '/')
					breaker = true;
			}
			if (next == EOF || next == '\0') {
				//printf("SHOULD BE HERE?\n");
				yycol = yycol + yyleng;
				return UNTERMCOMMENT;
			}
		}
		yycol = yycol + yyleng;
		return COMMENT;
	}
}

"<"				{yycol = yycol + yyleng; return OPER_LT;}
">"				{yycol = yycol + yyleng; return OPER_GT;}
">="			{yycol = yycol + yyleng; return OPER_GTE;}
"<="			{yycol = yycol + yyleng; return OPER_LTE;}
"=="			{yycol = yycol + yyleng; return OPER_EQ;}
"!="			{yycol = yycol + yyleng; return OPER_NEQ;}
"="				{yycol = yycol + yyleng; return OPER_ASGN;}

"\""			{
	char * newString = (char*)(malloc(sizeof(char) * 256));
	char c = input();
	int i = 0;
	bool untermStr = false;
	bool slashFlag = false;
	if (c == '\n')
		untermStr = true;
	while (c != '"' && c != EOF && c != '\0' && c != '\n') {
		
		
		if (c == '\\' && slashFlag == false) {
			c = input();
			if (c == '\\') {
				slashFlag = true;
			}
			else if (c == '"') {
				unput('\"');
			}
			else if (c == 'n') {
				unput('\n');
				c = '\n';
			}
			else if (c == 't') {
				c = '\t';
			}
		}
		else if (c == '\\')
			slashFlag = false;
		newString[i] = c;
		i++;
		c = input();
		if (c == '\n')
			untermStr = true;
	}
	yytext = newString;
	yycol = yycol + yyleng;
	if (c == '"')
		return STRING;
	else if (untermStr == true)
		return UNTERMSTRING;
	else
		return ERROR;

}


"["				{yycol = yycol + yyleng; return LSQ_BRKT;}
"]"				{yycol = yycol + yyleng; return RSQ_BRKT;}
"{"				{yycol = yycol + yyleng; return LCRLY_BRKT;}
"}"				{yycol = yycol + yyleng; return RCRLY_BRKT;}
"("				{yycol = yycol + yyleng; return LPAREN;}
")"				{yycol = yycol + yyleng; return RPAREN;}
","				{yycol = yycol + yyleng; return COMMA;}
";"				{yycol = yycol + yyleng; return SEMICLN;}

{whitespace}    {yycol = yycol + yyleng;}

.               {yycol = yycol + yyleng; return ILLEGAL_TOK;}

%%

// user routines 

//operators and keywords are the easy parts
//string matching will be difficult
//you need to be able to find illegal string literals
//like unending double quotes or 
// strings ending on a different line
//you have to add code in here. any type of c code
//yytext yymore <-- look up
//input(char &) unput(char)
