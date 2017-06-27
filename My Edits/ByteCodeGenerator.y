%{
#include <map>
#include <iostream>
#include <fstream>
#include <cstdio>
#include <string>
#include <cassert>
#include <stack>
#include <cstdio>
#include <cstdlib>
#include <sstream>
    using namespace std;
    std::map<string, pair<int, int > > sym; // type, index
    extern int lineCounter;
    int labelCount;
    stack<int > labeling;
    stack<int > expectedDataType;

    const double EPS = 1e-9;

    int insideNested;
    int yylex(void);
    void yyerror(const char *s);

    void gen_code_begining()
    {
        std::cout << (".class public ByteCodeGenerator") << endl;
        std::cout << (".super java/lang/Object") << endl;
        std::cout << (".method public <init>()V") << endl;
        std::cout << ("aload_0") << endl;
        std::cout << ("invokenonvirtual java/lang/Object/<init>()V") << endl;
        std::cout << ("return") << endl;
        std::cout << (".end method") << endl;
        std::cout << (".method public static main([Ljava/lang/String;)V") << endl;
    }

//.j file
    void gen(string s)
    {
        std::cout << s;
    }
%}

%union
{
    char*   str_t;
    int     int_t;
    double  dou_t;
    int     type_t;
}

%token SYSTEM_OUT
%token<int_t> INTEGER 101
%token<int_t> FLOAT 102
%token<str_t> SEMICOLON 103
%token OPEN_ROUND 104
%token CLOSE_ROUND 105
%token OPEN_CURLY 106
%token CLOSE_CURLY 107
%token ELSE 108
%token IF 109
%token WHILE 110
%token<str_t> IDENTIFIER 111
%token ASSIGN 112
%token<dou_t> FLOAT_LITERAL 113
%token<int_t> INTEGER_LITERAL 114
%left EQUAL_EQUAL 115
%left NOT_EQUAL 116
%left GREATER_THAN 117
%left GREATER_EQUAL 118
%left LESS_THAN 119
%left LESS_EQUAL 120
%left PLUS 121
%left MINUS 122
%left MULTIPLY 123
%left DIVIDE 124
%left MOD 125
%token BOOLEAN 126
%type<int_t> primitive_type
%start method_body

%{
    void pushIndex (int type, int index)
    {
        char typeChar = (type == INTEGER ? 'i' : 'f');
        std::cout << typeChar << "load " << index << '\n';
    }

    void pushNum (int type, double val)
    {
        if(type == FLOAT)
        {
            std::cout << "ldc\t";
            if (val == (int)val)
                std::cout << val << ".0";
            else
                std::cout << val;
        }
        else
        {
            int value = (int)val;
            if( 0 <= value && value <= 5 )
            {
                std::cout << "iconst_" << value;
            }
            else if( -128 <= value && value <= 127 )
            {
                std::cout << "bipush    " << value;
            }
            else if( -32768 <= value && value <= 32767 )
            {
                std::cout << "sipush    " << value;
            }
            else
            {
                std::cout << "ldc\t" << value;
            }
        }
        std::cout << '\n';
    }
%}

%%
method_body:
{
    gen_code_begining();
    gen(".limit locals 100\n");
    gen(".limit stack 100\n");
}
statement_list
{
    gen("return\n");
    gen(".end method\n");
}
;
statement_list:
statement
| statement_list statement
;

statement:
declaration
| iff
| whilee
| assignment
| system_print
;

declaration:
primitive_type IDENTIFIER SEMICOLON
{
    if (sym.find ($2) != sym.end() && !insideNested)
    {
        string str($2);
        string err =  "variable " + str  + " is already defined";
        yyerror(err.c_str());
    }
    else{
        if(!insideNested)
        {
            int index = (int)sym.size() + 2;
            sym[$2] = make_pair($1, index);
        }
    }}
;

primitive_type:
INTEGER {$$ = $1; }| FLOAT {$$ = $1; };

iff:
IF OPEN_ROUND expression { labelCount += 3; insideNested++; }
{
    if (expectedDataType.top() != BOOLEAN)
    {
        string err = "type cannot be converted into boolean";
        yyerror(err.c_str());
    }
    else {
        std::cout << "goto L" << labelCount - 2 << endl;
        expectedDataType.pop();
    }
}
CLOSE_ROUND OPEN_CURLY
{
    std::cout << "L" << labelCount - 1 << ": " << endl;
    labeling.push(labelCount);
} statement
{
    labelCount = labeling.top();
    labeling.pop();
    std::cout << "goto L" << labelCount - 3 << endl;
} CLOSE_CURLY ELSE
OPEN_CURLY
{
    std::cout << "L" << labelCount - 2 << ": " << endl;
    labeling.push(labelCount);
} statement
{
    labelCount = labeling.top();
    labeling.pop();
    std::cout << "L" << labelCount - 3 << ": " << endl;
} CLOSE_CURLY { insideNested--; }
;

whilee:
WHILE
{
    cout << "L" << labelCount + 1 << ": " << endl;
}
OPEN_ROUND expression { labelCount += 3; insideNested++; }
{
    if (expectedDataType.top() != BOOLEAN)
    {
        string err = "type cannot be converted into boolean";
        yyerror(err.c_str());
    }
    else {
        cout << "goto L" << labelCount - 3 << endl;
    }
}
CLOSE_ROUND OPEN_CURLY
{
    cout << "L" << labelCount - 1 << ": " << endl;
    labeling.push(labelCount);
}
statement CLOSE_CURLY
{
    labelCount = labeling.top();
    labeling.pop();
    cout << "goto L" << labelCount - 2 << endl;
    cout << "L" << labelCount - 3 << ": " << endl;
    insideNested--;
}
;

assignment:
IDENTIFIER ASSIGN expression SEMICOLON
{
    if (sym.find ($1) == sym.end())
    {
        string str($1);
        string err = "error: cannot find symbol " + str ;
        yyerror(err.c_str());
    }
    else {
        int idType = sym[$1].first;
        if ( idType < expectedDataType.top() )
        {
            string s;
            if (expectedDataType.top() == BOOLEAN)s = "boolean";
            else if (expectedDataType.top() == INTEGER)s = "int";
            else
            {
                s = "float";
            }
            string err = "error: incompatible types: "
                         +  s
                         + " cannot be converted to "
                         + (idType == BOOLEAN ? "boolean" : (idType == INTEGER ? "int" : "float"));
            yyerror(err.c_str());
        }
        else{
            if ( idType > expectedDataType.top() )
            {
                std::cout << "i2f\n";
            }
            expectedDataType.pop();

            int index = sym[$1].second;
            char typeChar = (idType == INTEGER ? 'i' : 'f');
            std::cout << typeChar << "store " << index << '\n';

            if( idType == INTEGER )
            {
                cout << "getstatic java/lang/System/out Ljava/io/PrintStream;\niload   " << sym[$1].second << "\ninvokevirtual java/io/PrintStream/println(I)V" << endl;
            }
            else
            {
                cout << "getstatic java/lang/System/out Ljava/io/PrintStream;\nfload   " << sym[$1].second << "\ninvokevirtual java/io/PrintStream/println(F)V" << endl;
            }
        }
    }
}
;
expression:
simple_expression
|
simple_expression EQUAL_EQUAL simple_expression
{
    if (expectedDataType.top() == BOOLEAN)
    {
        string err = "bad operand type boolean for binary operator '=='";
        yyerror(err.c_str());
    }
    else if(expectedDataType.top() == FLOAT)
    {
        string err = "we don't support floating point comparisons";
        yyerror(err.c_str());
    }
    else {
        std::cout << "if_" << (expectedDataType.top() == INTEGER ? 'i' : 'f') << "cmpeq     " << "L" << labelCount + 2 << "\n";
        expectedDataType.pop();
        expectedDataType.push( BOOLEAN );
    }}
|
simple_expression GREATER_THAN simple_expression
{
    if (expectedDataType.top() == BOOLEAN)
    {
        string err = "bad operand type boolean for binary operator '>'";
        yyerror(err.c_str());
    }
    else if(expectedDataType.top() == FLOAT)
    {
        string err = "we don't support floating point comparisons";
        yyerror(err.c_str());
    }
    else{
        std::cout << "if_" << (expectedDataType.top() == INTEGER ? 'i' : 'f') << "cmpgt     " << "L" << labelCount + 2 << "\n";
        expectedDataType.pop();
        expectedDataType.push( BOOLEAN );
    }}
|
simple_expression GREATER_EQUAL simple_expression
{
    if (expectedDataType.top() == BOOLEAN)
    {
        string err = "bad operand type boolean for binary operator '>='";
        yyerror(err.c_str());
    }
    else if(expectedDataType.top() == FLOAT)
    {
        string err = "we don't support floating point comparisons";
        yyerror(err.c_str());
    }
    else {
        std::cout << "if_" << (expectedDataType.top() == INTEGER ? 'i' : 'f') << "cmpge     " << "L" << labelCount + 2 << "\n";
        expectedDataType.pop();
        expectedDataType.push( BOOLEAN );
    }}
|
simple_expression LESS_THAN simple_expression
{
    if (expectedDataType.top() == BOOLEAN)
    {
        string err = "bad operand type boolean for binary operator '<'";
        yyerror(err.c_str());
    }
    else if(expectedDataType.top() == FLOAT)
    {
        string err = "we don't support floating point comparisons";
        yyerror(err.c_str());
    }
    else{
        std::cout << "if_" << (expectedDataType.top() == INTEGER ? 'i' : 'f') << "cmplt     " << "L" << labelCount + 2 << "\n";
        expectedDataType.pop();
        expectedDataType.push( BOOLEAN );
    }}
|
simple_expression LESS_EQUAL simple_expression
{
    if (expectedDataType.top() == BOOLEAN)
    {
        string err = "bad operand type boolean for binary operator '<='";
        yyerror(err.c_str());
    }
    else if(expectedDataType.top() == FLOAT)
    {
        string err = "we don't support floating point comparisons";
        yyerror(err.c_str());
    }
    else{
        std::cout << "if_" << (expectedDataType.top() == INTEGER ? 'i' : 'f') << "cmple     " << "L" << labelCount + 2 << "\n";
        expectedDataType.pop();
        expectedDataType.push( BOOLEAN );
    }}
|
simple_expression NOT_EQUAL simple_expression
{
    if (expectedDataType.top() == BOOLEAN)
    {
        string err = "bad operand type boolean for binary operator '!='";
        yyerror(err.c_str());
    }
    else if(expectedDataType.top() == FLOAT)
    {
        string err = "we don't support floating point comparisons";
        yyerror(err.c_str());
    }
    else {
        std::cout << "if_" << (expectedDataType.top() == INTEGER ? 'i' : 'f') << "cmpne     " << "L" << labelCount + 2 << "\n";
        expectedDataType.pop();
        expectedDataType.push( BOOLEAN );
    } }
;


simple_expression:
term
|
PLUS term
{
    if (expectedDataType.top() == BOOLEAN)
    {
        string err = "bad operand type boolean for unary operator '+'\n";
        yyerror(err.c_str());
    }
}
|
MINUS term
{
    if (expectedDataType.top() == BOOLEAN)
    {
        string err = "bad operand type boolean for unary operator '-'\n";
        yyerror(err.c_str());
    }
    else {
        char typeChar = (expectedDataType.top() == INTEGER ? 'i' : 'f');
        std::cout << typeChar << "neg\n";
    }      }
|
simple_expression PLUS
{
    if (expectedDataType.top() == BOOLEAN)
    {
        string err = "bad operand type boolean for binary operator '+'" ;
        yyerror(err.c_str());
    }
}
term
{
    if (expectedDataType.top() == BOOLEAN)
    {
        string err = "bad operand type boolean for binary operator '+'";
        yyerror(err.c_str());
    }
    else {
        char typeChar = (expectedDataType.top() == INTEGER ? 'i' : 'f');
        std::cout << typeChar << "add\n";
    }      }
|
simple_expression MINUS
{
    if (expectedDataType.top() == BOOLEAN)
    {
        string err = "bad operand type boolean for binary operator '-'";
        yyerror(err.c_str());
    }
}
term
{
    if (expectedDataType.top() == BOOLEAN)
    {
        string err = "bad operand type boolean for binary operator '-'";
        yyerror(err.c_str());
    }
    else {
        char typeChar = (expectedDataType.top() == INTEGER ? 'i' : 'f');
        std::cout << typeChar << "sub\n";
    }      }
;

term:
factor
|
term MULTIPLY factor
{
    if (expectedDataType.top() == BOOLEAN)
    {
        string err = "bad operand type boolean for binary operator '*'";
        yyerror(err.c_str());
    }
    else {
        char typeChar = (expectedDataType.top() == INTEGER ? 'i' : 'f');
        std::cout << typeChar << "mul\n";
    }      }
|
term DIVIDE factor
{
    if (expectedDataType.top() == BOOLEAN)
    {
        string err = "bad operand type boolean for binary operator '/'";
        yyerror(err.c_str());
    }
    else {
        char typeChar = (expectedDataType.top() == INTEGER ? 'i' : 'f');
        std::cout << typeChar << "div\n";
    }      }
;


factor:
IDENTIFIER
{
    //assert ($2.type != BOOLEAN && "Error in factor logic!!");

    if (sym.find ($1) == sym.end())
    {
        string str($1);
        string err = "error: cannot find symbol " + str;
        yyerror(err.c_str());
    }
    else {
        int idType = sym[$1].first;
        int type = max (idType, expectedDataType.size() ? ( expectedDataType.top() == BOOLEAN ? INTEGER : expectedDataType.top() ) : INTEGER );

        if (expectedDataType.size() && ( expectedDataType.top() == BOOLEAN ? FLOAT : expectedDataType.top() ) < type)
        {
            std::cout << "i2f\n";
        }

        pushIndex (type, sym[$1].second);

        if (idType < type)
        {
            std::cout << "i2f\n";
        }
        if(expectedDataType.size() && expectedDataType.top() != BOOLEAN) expectedDataType.pop();
        expectedDataType.push( type );
    }
}
|
INTEGER_LITERAL
{
    //assert ($2.type != BOOLEAN && "Error in factor logic!!");

    int type = expectedDataType.size() ? ( expectedDataType.top() == BOOLEAN ? INTEGER : expectedDataType.top() ) : INTEGER;
    pushNum (type, $1);
    if(expectedDataType.size() && expectedDataType.top() != BOOLEAN) expectedDataType.pop();
    expectedDataType.push( type );
}
|
FLOAT_LITERAL
{
    //assert ($2.type != BOOLEAN && "Error in factor logic!!");
    int type = FLOAT;

    if (expectedDataType.size() && ( expectedDataType.top() == BOOLEAN ? FLOAT : expectedDataType.top() ) < type)
    {
        std::cout << "i2f\n";
    }

    pushNum (type, $1);
    if(expectedDataType.size() && expectedDataType.top() != BOOLEAN) expectedDataType.pop();
    expectedDataType.push( type );
}
|
OPEN_ROUND expression CLOSE_ROUND
;

system_print:
SYSTEM_OUT OPEN_ROUND IDENTIFIER CLOSE_ROUND SEMICOLON
{
    if (sym.find ($3) == sym.end())
    {
        string str($3);
        string err = "error: cannot find symbol " + str ;
        yyerror(err.c_str());
    }
    else {
        int idType = sym[$3].first;
        int index = sym[$3].second;
        pushIndex (idType, sym[$3].second);

        char typeChar = (idType == INTEGER ? 'i' : 'f');
        string str($3);
        std::cout << typeChar << "store " << index << '\n';

        if( idType == INTEGER )
        {
            cout << "getstatic java/lang/System/out Ljava/io/PrintStream;\niload   " << sym[$3].second << "\ninvokevirtual java/io/PrintStream/println(I)V" << endl;
        }
        else
        {
            cout << "getstatic java/lang/System/out Ljava/io/PrintStream;\nfload   " << sym[$3].second << "\ninvokevirtual java/io/PrintStream/println(F)V" << endl;
        }
    }
}
;

%%

void yyerror(const char * s)
{
    fprintf(stderr, "line = %d : %s\n", lineCounter, s);
}
int main(void)
{
    freopen("ByteCodeGeneratorIn.txt", "r", stdin);
    freopen("ByteCodeGeneratorOut.j", "w", stdout);
    yyparse();
    return 0;
}

