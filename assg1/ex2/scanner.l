
/* definitions */

%{
#include<stdio.h>
#include"tokendef.h"

int yycol = 0;

%}

newline     \n
whitespace  [ \t]+

yylineno = 1;

%%

 /* rules */ 

"int"           {yycol = yycol + yyleng; return KWD_INT;}
{newline}       {yycol = 0;}
{whitespace}    {/* skip whitespace */}
.               {return ILLEGAL_TOK;}

%%

// user routines 

