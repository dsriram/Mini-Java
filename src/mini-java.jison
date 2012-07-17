
/* description: Parses end executes mathematical expressions. */

/* lexical grammar */
%lex

digit                 [0-9]
id                    [a-zA-Z][a-zA-Z0-9]*

%%

\s+                     /* skip whitespaces */
"class"                 return 'CLASS'
"extends"               return 'EXTENDS'
"public"                return 'PUBLIC'
"static"                return 'STATIC'
"void"                  return 'VOID'
"main"                  return 'MAIN'
"return"                return 'RETURN'
"this"                  return 'THIS'
"new"                   return 'NEW'
"length"                return 'LENGTH'
"System.out.println"    return 'SYSOUT'

"if"                    return 'IF'
"else"                  return 'ELSE'
"while"                 return 'WHILE'

"boolean"               return 'BOOLEAN'
"int"                   return 'INT'
"String"                return 'STRING'

"true"                  return 'TRUE'
"false"                 return 'FALSE'
"nothing"               return 'NOTHING'

{id}                    return 'ID'
{digit}+                return 'INTEGER_LETERAL';

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

<<EOF>>                 return 'EOF'
.                       return 'INVALID'

/lex

/* operator associations and precedence */
/* TODO: FIXME!!! */
%left '+' '-'
%left '*' '/'
%left '<'
%left '['
%left '.'
%right '!'
%right '&'

/* start at goal */
%start goal

%% /* language grammar */

goal
    : main_class multiple_class_declarations EOF
    ;




statement_list /* == (statement)* */
    : statement statement_list
    |
    ;

statement
    : '{' statement_list '}'
    | IF '(' expression ')' statement ELSE statement
    | WHILE '(' expression ')' statement
    | SYSOUT '(' expression ')' ';'
    | ID '=' expression ';'
    | ID '[' expression ']' '=' expression ';'
    | NOTHING
    ;





expression_list
    : expression comma_expression_list
    |
    ;

comma_expression_list
    : ',' expression comma_expression_list
    |
    ;

expression
    : expression '&' expression 
    | expression '<' expression 
    | expression '+' expression 
    | expression '-' expression 
    | expression '*' expression 
    | expression '[' expression ']'
    | expression '.' LENGTH
    | expression '.' ID '(' expression_list ')'
    | INTEGER_LETERAL
    | TRUE
    | FALSE
    | ID
    | THIS
    | NEW INT '[' expression ']'
    | NEW ID '(' ')'
    | '!' expression
    | '(' expression ')'
    ;






type
    : INT '[' ']'
    | BOOLEAN
    | INT
    | ID
    ;

var_decl
    : type ID ';'
    ;

main_class
    : CLASS ID '{' PUBLIC STATIC VOID MAIN '(' STRING '[' ']' ID ')' '{' statement_list '}' '}'
    ;

multiple_class_declarations
    : 
    ;
















