/* definitions */

%{
#include <stdio.h>
#include <stdlib.h>
#include "tokendef.h"
%}

digit       [0-9]
number      {digit}+
letter      [a-zA-Z]
identifier  {letter}+
whitespace  [ \n\t]+


%%

 /* rules */ 



"if"|"IF"        		{return KWD_IF;}
"else"|"ELSE"         	{return KWD_ELSE;}
"while"|"WHILE"         {return KWD_WHILE;}
"int"|"INT"         	{return KWD_INT;}
"string"|"STRING"       {return KWD_STRING;}
"char"|"CHAR"        	{return KWD_CHAR;}
"return"|"RETURN"       {return KWD_RETURN;}
"void"|"VOID"       	{return KWD_VOID;}

{identifier}    {return ID;}
{number}        {return INTCONST;}


"+"             {return OPER_ADD;}
"-"|"-"			{return OPER_SUB;}
"*"				{return OPER_MUL;}
"/"				{
	unput();
	char next = input();
	printf("hiiiii%c\n", next);
	if (next != '*' && != '/') {
		printf("NOT HERE??");
		return OPER_DIV;
	}
	else if (next == '/') {
		while (next != '\n' || next == EOF || next == '\0') {
			next = input();
		}
		return COMMENT;
	}
	else if (next == '*') {
		bool breaker = false;
		while (next != '*' || next == EOF || next == '\0' || breaker == true) {
			unput();
			if (input() == '*') {
				unput();
				if (input == '/')
					breaker = true;
			}	
		}
		return COMMENT;
	}
}

"<"				{return OPER_LT;}
">"				{return OPER_GT;}
">="			{return OPER_GTE;}
"<="			{return OPER_LTE;}
"=="			{return OPER_EQ;}
"!="			{return OPER_NEQ;}
"="				{return OPER_ASGN;}

"\""			{
	printf("Entering Quote Rule\n");
	char * newString = (char*)(malloc(sizeof(char) * 256));
	char c = input();
	int i = 0;
	bool untermStr = false;
	if (c == '\n')
		untermStr = true;
	while (c != '"' && c != EOF && c != '\0' && c != '\n') {
		newString[i] = c;
		i++;
		c = input();
		if (c == '\n')
			untermStr = true;
		printf("%d ", i);
		printf("%c", c);
	}
	yytext = newString;
	printf("Exiting Quote Rule\n");
	if (c == '"')
		return STRING;
	else if (untermStr == true)
		return UNTERMSTRING;
	else
		return ERROR;

}

"["				{return LSQ_BRKT;}
"]"				{return RSQ_BRKT;}
"{"				{return LCRLY_BRKT;}
"}"				{return RCRLY_BRKT;}
"("				{return LPAREN;}
")"				{return RPAREN;}
","				{return COMMA;}
";"				{return SEMICLN;}

{whitespace}    {/* skip whitespace */}

.               {return ILLEGAL_TOK;}

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
