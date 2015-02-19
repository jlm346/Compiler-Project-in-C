#include<tokendef.h>
#include<stdio.h>

extern char *yytext;

extern int yylineno;
extern int yycol;

void printToken(int tokenNum) {
  switch(tokenNum) {
  case ID:
    printf("<ID, %s>\n", yytext);
    break;
  case INTCONST:
    printf("<INTEGER, %s>\n", yytext); //should print both integer value and data type (integer)
    break;
  case STRING:
    printf("<STRING, \"%s\">\n", yytext); 
    break;
  case COMMENT:
    printf("<COMMENTS>", yytext); 
    break;

  case KWD_IF:
    printf("<IF KEYWORD>\n");
    break;
  case KWD_ELSE:
    printf("<ELSE KEYWORD>\n");
    break;
  case KWD_WHILE:
    printf("<WHILE KEYWORD>\n");
    break;
  case KWD_INT:
    printf("<INT_KEYWORD>\n");
    break;
  case KWD_STRING:
    printf("<STRING KEYWORD>\n");
    break;
  case KWD_CHAR:
    printf("<CHAR KEYWORD>\n");
    break;
  case KWD_RETURN:
    printf("<RETURN KEYWORD>\n");
    break;
  case KWD_VOID:
    printf("<VOID KEYWORD>\n");
    break;


  case OPER_ADD:
    printf("<ADD OPERATOR>\n");
    break;
  case OPER_SUB:
    printf("<SUB OPERATOR>\n");
    break;
  case OPER_MUL:
    printf("<MUL OPERATOR>\n");
    break;
  case OPER_DIV:
    printf("<DIV OPERATOR>\n");
    break;

  case OPER_LT:
    printf("<LESSTH OPERATOR>\n");
    break;
  case OPER_GT:
    printf("<GREATERTH OPERATOR>\n");
    break;
  case OPER_GTE:
    printf("<GRTEQL OPERATOR>\n");
    break;
  case OPER_LTE:
    printf("<LESSEQL OPERATOR>\n");
    break;
  case OPER_EQ:
    printf("<EQUAL OPERATOR>\n");
    break;
  case OPER_NEQ:
    printf("<NOTEQ OPERATOR>\n");
    break;

  case OPER_ASGN:
    printf("<ASSIGN OPERATOR>\n");
    break;

  case LSQ_BRKT:
    printf("<LSQ_BRKT>\n");
    break;
  case RSQ_BRKT:
    printf("<RSQ_BRKT>\n");
    break;
  case LCRLY_BRKT:
    printf("<LCRLY_BRKT>\n");
    break;
  case RCRLY_BRKT:
    printf("<RCRLY_BRKT>\n");
    break;
  case LPAREN:
    printf("<LPAREN>\n");
    break;
  case RPAREN:
    printf("<RPAREN>\n");
    break;

  case COMMA:
    printf("<COMMA>\n");
    break;
  case SEMICLN:
    printf("<SEMICLN>\n");
    break;
  case UNTERMSTRING:
    printf("<UNTERMINATED STRING>\n");
    break;


  default:
    printf("<ILLEGAL TOKEN: %s>\n", yytext);
  }
  return;
  //will have ~100 ish different cases when finished
}

int main() {

  int ret = yylex();
  while (ret) {
    printToken(ret);
    ret = yylex();    
  }
  return 0;
}
