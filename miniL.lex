   /* cs152-miniL phase1 */
   
%{   
   /* write your C code here for definitions of variables and including headers */
   #include "miniL-parser.h"
   int currPosition = 1;
   int currLine = 1;
%}
   /* some common rules */
DIGIT        [0-9]
LETTER       [A-Za-z]
UNDERSCORE     [_]
%%
   /* specific lexer rules in regex */
"function"           {return FUNCTION; currPosition += yyleng;}
"beginparams"        {return BEGIN_PARAMS; currPosition += yyleng;}
"endparams"          {return END_PARAMS; currPosition += yyleng;}
"beginlocals"        {return BEGIN_LOCALS; currPosition += yyleng;}
"endlocals"          {return END_LOCALS; currPosition += yyleng;}
"beginbody"          {return BEGIN_BODY; currPosition += yyleng;}
"endbody"            {return END_BODY; currPosition += yyleng;}
"integer"            {return INTEGER; currPosition += yyleng;}
"array"              {return ARRAY; currPosition += yyleng;}
"of"                 {return OF; currPosition += yyleng;}
"if"                 {return IF; currPosition += yyleng;}
"then"               {return THEN; currPosition += yyleng;}
"endif"              {return ENDIF; currPosition += yyleng;}
"else"               {return ELSE; currPosition += yyleng;}
"while"              {return WHILE; currPosition += yyleng;}
"do"                 {return DO; currPosition += yyleng;}
"beginloop"          {return BEGINLOOP; currPosition += yyleng;}
"endloop"            {return ENDLOOP; currPosition += yyleng;}
"continue"           {return CONTINUE; currPosition += yyleng;}
"break"              {return BREAK; currPosition += yyleng;}
"read"               {return READ; currPosition += yyleng;}
"write"              {return WRITE; currPosition += yyleng;}
"not"                {return NOT; currPosition += yyleng;}
"true"               {return TRUE; currPosition += yyleng;}
"false"              {return FALSE; currPosition += yyleng;}
"return"             {return RETURN; currPosition += yyleng;}

"-"                  {return SUB; currPosition += yyleng;}
"+"                  {return ADD; currPosition += yyleng;}
"*"                  {return MULT; currPosition += yyleng;}
"/"                  {return DIV; currPosition += yyleng;}
"%"                  {return MOD; currPosition += yyleng;}
"=="                 {return EQ; currPosition += yyleng;}
"<>"                 {return NEQ; currPosition += yyleng;}
"<"                  {return LT; currPosition += yyleng;}
">"                  {return GT; currPosition += yyleng;}
"<="                 {return LTE; currPosition += yyleng;}
">="                 {return GTE; currPosition += yyleng;}

[A-Za-z0-9_]*{UNDERSCORE} {printf("Error at line %d, column %d: identifier \"%s\" cannot end with underscore\n", currLine, currPosition, yytext); exit(0);}
[a-zA-Z][A-Za-z0-9_]* {yylval.stringToken = strdup(yytext); return IDENT; currPosition += yyleng; }
{DIGIT}+             {yylval.numToken= atoi(yytext); return NUMBER; currPosition += yyleng;}

";"                  {return SEMICOLON; currPosition += yyleng;}
":"                  {return COLON; currPosition += yyleng;}
","                  {return COMMA; currPosition += yyleng;}
"("                  {return L_PAREN; currPosition += yyleng;}
")"                  {return R_PAREN; currPosition += yyleng;}
"["                  {return L_SQUARE_BRACKET; currPosition += yyleng;}
"]"                  {return R_SQUARE_BRACKET; currPosition += yyleng;}
":="                 {return ASSIGN; currPosition += yyleng;}


"##".*               { currPosition += yyleng; currLine++;}
"\n"                 { currPosition = 1; currLine++;}
"\t"                 { currPosition += yyleng;}
" "                  { currPosition += yyleng;}       

[0-9_]+[A-Za-z0-9_]* {printf("Error at line %d, column %d: identifier \"%s\" must begin with a letter\n", currLine, currPosition, yytext); exit(0);}

.                    {printf("Error at line %d, column %d unrecognized symbol: \"%s\"\n", currLine, currPosition, yytext); exit(0);}

%%
	/* C functions used in lexer */

