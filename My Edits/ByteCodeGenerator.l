%{
    #include "y.tab.h"
    #include <stdlib.h>
    #include <cstring>
    int lineCounter = 1;
    void yyerror(const char *);
%}

letter 		[a-zA-Z]
number 		[0-9]+(\L|[eE][-+]?[0-9]+)?
float 		[0-9]*\.[0-9]+(\L|[eE][-+]?[0-9]+)?
assign 		"="
plus 		"+"
minus		"-"
multiply 	"*"
divide		"/"
semicolon	";"
open_round	"("
close_round	")"
open_curly	"{"
close_curly	"}"
greater_than ">"
less_than "<"
greater_equal ">="
less_equal "<="
equal_equal "=="
not_equal "!="
%%





[ \t]+
";" { return SEMICOLON; }
"(" {  return OPEN_ROUND; }
")" {  return CLOSE_ROUND; }
"{" {  return OPEN_CURLY; }
"}" {  return CLOSE_CURLY; }
("else") { return ELSE; }
("if") { return IF; }
("while")	{ return WHILE; }
("int") { yylval.type_t = INTEGER; return INTEGER; }
("float") { yylval.type_t = FLOAT; return FLOAT; }
("boolean") { return BOOLEAN; }
{letter}({letter}|{number})* { char* ret = (char *)malloc(strlen(yytext)+1); memcpy(ret,yytext,strlen(yytext)); ret[strlen(yytext)] = '\0'; yylval.str_t = ret; return IDENTIFIER; }
{assign} { return ASSIGN; }
{float}	{ yylval.dou_t = atof(yytext); return FLOAT_LITERAL; }
{number}+ { yylval.int_t = atoi(yytext); return INTEGER_LITERAL; }
{plus} { return PLUS; }
{minus} { return MINUS; }
{divide} { return DIVIDE; }
{multiply} { return MULTIPLY; }
{greater_than} { return GREATER_THAN; }
{less_than} { return LESS_THAN; }
{greater_equal} { return GREATER_EQUAL; }
{less_equal} { return LESS_EQUAL; }
{equal_equal} { return EQUAL_EQUAL; }
{not_equal} { return NOT_EQUAL; }
\n	{++lineCounter;}
"System.out.println"	{return SYSTEM_OUT;}
%%

int yywrap(void) {
    return 1;
}
