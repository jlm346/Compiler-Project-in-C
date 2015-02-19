#include"tokendef.h"
#include<stdio.h>

extern char *yytext;

extern int yylineno;
extern int yycol;

void printToken(int tokenNum) {
  switch(tokenNum) {
  case ID:
    printf("<ID>\n");
    break;
  case INTCONST:
    printf("<INTEGER>\n");
    break;
  case KWD_INT:
      printf("<INT_KEYWORD, %s> : (%d:%d)\n", yytext, yylineno, yycol);
    break;
  default:
    printf("<ILLEGAL TOKEN>\n");
  }
  return;
}

int main() {

  int ret = yylex();
  while (ret) {
    printToken(ret);
    //if you type cout yytext it will give you the currently identified token
    
    ret = yylex();    
  }
  return 0;
}
