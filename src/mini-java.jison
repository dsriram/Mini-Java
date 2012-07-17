
/* lexical grammar */
%lex

digit                 [0-9]
id                    [a-zA-Z][a-zA-Z0-9_]*

%%

\s+                     /* skip whitespaces */
"class"                 return "CLASS"
"extends"               return "EXTENDS"
"public"                return "PUBLIC"
"static"                return "STATIC"
"void"                  return "VOID"
"main"                  return "MAIN"
"return"                return "RETURN"
"this"                  return "THIS"
"new"                   return "NEW"
"length"                return "LENGTH"
"System.out.println"    return "SYSOUT"

"if"                    return "IF"
"else"                  return "ELSE"
"while"                 return "WHILE"

"boolean"               return "BOOLEAN"
"int"                   return "INT"
"String"                return "STRING"

"true"                  return "TRUE"
"false"                 return "FALSE"

{id}                    return "ID"
{digit}+                return "INTEGER_LETERAL"

"{"                     return '{'
"}"                     return '}'
"("                     return '('
")"                     return ')'
"["                     return '['
"]"                     return ']'

";"                     return ';'
","                     return ','
"."                     return '.'

"="                     return '='
"<"                     return '<'
"+"                     return '+'
"-"                     return '-'
"*"                     return '*'
"&&"                    return '&'
"!"                     return '!'

<<EOF>>                 return "EOF"
.                       return "INVALID"

/lex






/* operator associations and precedence */
/* TODO: FIXME!!! */
%left '+' '-'
%left '*' '/'
%left '<'
%left '['
%left '.'
%left '='
%right '!'
%right '&'






/* start at goal */
%start goal

%% /* language grammar */

goal
    : main_class class_decl_list EOF
        {
            var obj = {};
            obj.type = "goal";
            obj.main_class = $main_class.name;
            obj.other_classes = $class_decl_list.list;
            $$ = obj;

            console.log("GOAL: " + JSON.stringify($$, null, 2));
        }
    ;




statement_list /* == (statement)* */
    : statement statement_list
        {
            
        }
    |
        {
            
        }
    ;

statement
    : '{' statement_list '}'
        {
            
        }
    | IF '(' expression ')' statement ELSE statement
        {
            
        }
    | WHILE '(' expression ')' statement
        {
            
        }
    | SYSOUT '(' expression ')' ';'
        {
            
        }
    | ID '=' expression ';'
        {
            
        }
    | ID '[' expression ']' '=' expression ';'
        {
            
        }
    ;


expression_list /* == ( expression (',' expression)* )* */
    : expression expression_comma_list
        {
            
        }
    |
        {
            
        }
    ;

expression_comma_list
    : ',' expression expression_comma_list
        {
            
        }
    |
        {
            
        }
    ;

expression
    : expression '&' expression
        {
            
        }
    | expression '<' expression 
        {
            
        }
    | expression '+' expression 
        {
            
        }
    | expression '-' expression 
        {
            
        }
    | expression '*' expression 
        {
            
        }
    | expression '[' expression ']'
        {
            
        }
    | expression '.' LENGTH
        {
            
        }
    | expression '.' ID '(' expression_list ')'
        {
            
        }
    | INTEGER_LETERAL
        {
            
        }
    | TRUE
        {
            
        }
    | FALSE
        {
            
        }
    | ID
        {
            
        }
    | THIS
        {
            
        }
    | NEW INT '[' expression ']'
        {
            
        }
    | NEW ID '(' ')'
        {
            
        }
    | '!' expression
        {
            
        }
    | '(' expression ')'
        {

        }
    ;





type
    : INT '[' ']'
        {
            $$ = "int[]";
        }
    | BOOLEAN
        {
            $$ = "boolean";
        }
    | INT
        {
            $$ = "int";
        }
    ;

type_id
    : ID ID | type ID
        {
            $$ = $type + " " + $ID;
        }
    ;

type_id_list
    : type_id type_id_comma_list
        {

        }
    |
        {

        }
    ;

type_id_comma_list
    : ',' type_id type_id_comma_list
        {

        }
    |
        {

        }
    ;




var_decl_list
    : var_decl_list var_decl /* used left recursion to fix shift/reduce conflict! */
        {

        }
    |
        {

        }
    ;

var_decl
    : type_id ';'
        {

        }
    ;




main_class
    : CLASS ID '{' PUBLIC STATIC VOID MAIN '(' STRING '[' ']' ID ')' '{' statement_list '}' '}'
        {
            var obj = {};
            obj.name = $ID;

            $$ = obj;
        }
    ;





class_decl_list
    : class_decl class_decl_list
        {

        }
    |
        {

        }
    ;

class_decl
    : CLASS ID class_extension_signature '{' var_decl_list method_decl_list '}'
        {

        }
    ;

class_extension_signature
    : EXTENDS ID 
        {

        }
    |
        {

        }
    ;




method_decl_list
    : method_decl method_decl_list
        {

        }
    |
        {

        }
    ;

method_decl
    : PUBLIC type_id '(' type_id_list ')' '{' var_decl_list statement_list RETURN expression ';' '}'
        {

        }
    ;









