/* cs152-miniL phase3 */


%{
void yyerror(const char *msg);
extern int yylex();

extern int currLine;
extern int currPosition;

#include "lib.h"

%}
struct CodeNode {
  std::string code;
  std::string name;
}


%union {
  int numToken;
  char* stringToken;
  struct CodeNode* code_node;
}


%error-verbose

%token<int_val> DIGIT


%start Program_Start

%token FUNCTION
%token BEGIN_PARAMS
%token END_PARAMS
%token BEGIN_LOCALS
%token END_LOCALS
%token BEGIN_BODY
%token END_BODY
%token INTEGER
%token ARRAY
%token OF
%token IF
%token THEN
%token ENDIF
%token ELSE
%token WHILE
%token DO
%token BEGINLOOP
%token ENDLOOP
%token CONTINUE
%token BREAK
%token READ
%token WRITE
%right NOT
%token TRUE
%token FALSE
%token RETURN
%left SUB
%left ADD
%left MULT
%left DIV
%left MOD
%left EQ
%left NEQ
%left LT
%left GT
%left LTE
%left GTE
%token SEMICOLON
%token COLON
%token COMMA
%left L_PAREN
%left R_PAREN
%left L_SQUARE_BRACKET
%left R_SQUARE_BRACKET
%right ASSIGN
%token <numToken> NUMBER
%token <stringToken> IDENT
%type <code_node> Function Functions
%type <code_node> Declarations Declaration
%type <code_node> Identifiers Ident
%type <code_node> Statements Statement
%type <code_node> BoolExp
%type <code_node> MultiplicativeExpr Term
%type <code_node> Var 
%type <code_node> Comparison
%type <code_node> Expression Expressions
%type <code_node> Term


%% 

  /* write your rules here */
Program_Start Functions {

};

Functions: %empty {
CodeNode* node = new CodeNode;
$$ = node;


} |

Function Functions {

}

Function: FUNCTION IDENT SEMICOLON BEGIN_PARAMS Declarations END_PARAMS BEGIN_LOCALS Declarations END_LOCALS BEGIN_BODY Statements END_BODY {

};

Declarations: %empty {
CodeNode* node = new CodeNode;
  $$ = node;
} | Declaration SEMICOLON Declarations {

} ;

Declaration: Identifiers COLON INTEGER {

} |
Identifiers COLON ARRAY L_SQUARE_BRACKET NUMBER R_SQUARE_BRACKET OF INTEGER{

};

Identifiers: Ident {

};

Ident: IDENT {

};

Statements: %empty{
  CodeNode* node = new CodeNode;
  $$ = node;
} | Statement SEMICOLON Statements {

} ;

Statement: Var ASSIGN Expression {

} | IF BoolExp THEN Statements ENDIF {

} | IF BoolExp THEN Statements ELSE Statements ENDIF {

} | WHILE BoolExp BEGINLOOP Statements ENDLOOP{

} | DO BEGINLOOP Statements ENDLOOP WHILE BoolExp{

} | READ Var {

} | Write Var {

} | CONTINUE {

} | RETURN Expression {

};

BoolExp: Expression Comparison Expression {

} | NOT BoolExp {

};

Comparison: EQ {
  CodeNode* node = new CodeNode;
  node->name = "==";
  $$ = node;
} | NEQ {
 CodeNode* node = new CodeNode;
  node->name = "!=";
  $$ = node;
} | LT {
 CodeNode* node = new CodeNode;
  node->name = "<";
  $$ = node;
} | GT {
 CodeNode* node = new CodeNode;
  node->name = ">";
  $$ = node;
} | LTE {
 CodeNode* node = new CodeNode;
  node->name = "<=";
  $$ = node;
} | GTE {
 CodeNode* node = new CodeNode;
  node->name = ">=";
  $$ = node;
};

Expression: MultiplicativeExpr {

} | MultiplicativeExpr ADD Expression {

} | MultiplicativeExpr SUB Expression {

};

Expressions {

} | Expression {

} | Expression COMMA Expressions {

};

MultiplicativeExpr: Term {

} | Term MULT MultiplicativeExpr {

} | Term DIV MultiplicativeExpr {

} | Term MOD MultiplicativeExpr{

};

Term: Var {

} |
NUMBER {

} | L_PAREN Expression R_PAREN {

} | Ident L_PAREN Expressions R_PAREN {

};

Var: IDENT {

} | IDENT L_SQUARE_BRACKET Expression R_SQUARE_BRACKET {

};

%% 

int main(int argc, char **argv) {
   yyparse();
   return 0;
}

void yyerror(const char *msg) {
    /* implement your error handling */
}