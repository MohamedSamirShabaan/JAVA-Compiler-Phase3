/* A Bison parser, made by GNU Bison 3.0.4.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015 Free Software Foundation, Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

#ifndef YY_YY_Y_TAB_H_INCLUDED
# define YY_YY_Y_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    SYSTEM_OUT = 258,
    INTEGER = 101,
    FLOAT = 102,
    SEMICOLON = 103,
    OPEN_ROUND = 104,
    CLOSE_ROUND = 105,
    OPEN_CURLY = 106,
    CLOSE_CURLY = 107,
    ELSE = 108,
    IF = 109,
    WHILE = 110,
    IDENTIFIER = 111,
    ASSIGN = 112,
    FLOAT_LITERAL = 113,
    INTEGER_LITERAL = 114,
    EQUAL_EQUAL = 115,
    NOT_EQUAL = 116,
    GREATER_THAN = 117,
    GREATER_EQUAL = 118,
    LESS_THAN = 119,
    LESS_EQUAL = 120,
    PLUS = 121,
    MINUS = 122,
    MULTIPLY = 123,
    DIVIDE = 124,
    MOD = 125,
    BOOLEAN = 126
  };
#endif
/* Tokens.  */
#define SYSTEM_OUT 258
#define INTEGER 101
#define FLOAT 102
#define SEMICOLON 103
#define OPEN_ROUND 104
#define CLOSE_ROUND 105
#define OPEN_CURLY 106
#define CLOSE_CURLY 107
#define ELSE 108
#define IF 109
#define WHILE 110
#define IDENTIFIER 111
#define ASSIGN 112
#define FLOAT_LITERAL 113
#define INTEGER_LITERAL 114
#define EQUAL_EQUAL 115
#define NOT_EQUAL 116
#define GREATER_THAN 117
#define GREATER_EQUAL 118
#define LESS_THAN 119
#define LESS_EQUAL 120
#define PLUS 121
#define MINUS 122
#define MULTIPLY 123
#define DIVIDE 124
#define MOD 125
#define BOOLEAN 126

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED

union YYSTYPE
{
#line 45 "ByteCodeGenerator.y" /* yacc.c:1909  */

    char*   str_t;
    int     int_t;
    double  dou_t;
    int     type_t;

#line 119 "y.tab.h" /* yacc.c:1909  */
};

typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_Y_TAB_H_INCLUDED  */
