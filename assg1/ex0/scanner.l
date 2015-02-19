/* definitions */

%{
#include<stdio.h>
#include<tokendef.h>
%}

digit       [0-9]
number      {digit}+

letter      [a-zA-Z]
identifier  {letter}+

whitespace  [ \n\t]+

%%

 /* rules */ 

{number}        {return INTCONST;}

int|INT         {return KWD_INT;}
"+"             {return OPER_ADD;}

{identifier}    {return ID;}
{whitespace}    {/* skip whitespace */}

.               {return ILLEGAL_TOK;}

%%


/* user routines */
