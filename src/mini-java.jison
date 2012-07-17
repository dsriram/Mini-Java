
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
            /*obj.other_classes = $class_decl_list.list;*/
            $$ = obj;

            /*console.log("GOAL: " + JSON.stringify($$, null, 2));*/
            console.log("goal ::= main_class class_decl_list EOF");
            console.log("          \\_________|____ " + $main_class.name);
            console.log("                     \\___ " + $class_decl_list.list + "\n");
        }
    ;




statement_list /* == (statement)* */
    : statement statement_list
        {
            console.log("0)  statement_list ::= statement statement_list");
            console.log("                        \\___ " + $statement.desc + "\n");
        }
    |
        {
            console.log("1)  statement_list ::= ");
            
        }
    ;

statement
    : '{' statement_list '}'
        {
            console.log("2)  statement ::= '{' statement_list '}'");
            console.log("                       \\___ " + $statement_list.desc + "\n");
            
        }
    | IF '(' expression ')' statement ELSE statement
        {
            console.log("3)  statement ::= IF '(' expression ')' statement ELSE statement");
            console.log("                          \\_____________|_______________|____ " + $expression.desc);
            console.log("                                         \\______________|____ " + $statement1.desc);
            console.log("                                                         \\___ " + $statement2.desc + "\n");
            
        }
    | WHILE '(' expression ')' statement
        {
            console.log("4)  statement ::= WHILE '(' expression ')' statement");
            console.log("                             \\_____________|____ " + $expression.desc);
            
        }
    | SYSOUT '(' expression ')' ';'
        {
            console.log ("5)  statement ::= SYSOUT '(' expression ')' ';'");
            console.log("                              \\____ " + $expression.desc + "\n")
        }
    | ID '=' expression ';'
        {
            console.log("6)  statement ::= ID '=' expression ';'");
            console.log("                   \\______|___ " + $ID);
            console.log("                           \\__ " + $expression.desc + "\n")
            
        }
    | ID '[' expression ']' '=' expression ';'
        {
            console.log("7)  statement ::= ID '[' expression ']' '=' expression ';'");
            console.log("                  \\______|__________________|__ " + $ID);
            console.log("                          \\_________________|__ " + $expression1.desc)
            console.log("                                             \\_ " + $expression2.desc + "\n")
            
        }
    ;


expression_list /* == ( expression (',' expression)* )* */
    : expression expression_comma_list
        {
            console.log("8)  expression_list ::= expression expression_comma_list");
            console.log("                          \\___ " + $expression.desc + "\n");
            
        }
    |
        {
            console.log("9)  expression_list ::= ");
            
        }
    ;

expression_comma_list
    : ',' expression expression_comma_list
        {
            console.log("10) expression_comma_list ::= ',' expression expression_comma_list");
            console.log("                                   \\___ " + $expression.desc + "\n");
            
        }
    |
        {
            console.log("11) expression_comma_list ::= ");
            
        }
    ;

expression
    : expression '&' expression
        {
            console.log("12) expression ::= expression '&' expression");
            console.log("                    \\_____________|____ " + $expression1.desc);
            console.log("                                   \\___ " + $expression2.desc + "\n");
            
        }
    | expression '<' expression 
        {
            console.log("13) expression ::= expression '<' expression");
            console.log("                    \\_____________|____ " + $expression1.desc);
            console.log("                                   \\___ " + $expression2.desc + "\n");
            
        }
    | expression '+' expression 
        {
            console.log("14) expression ::= expression '+' expression");
            console.log("                    \\_____________|____ " + $expression1.desc);
            console.log("                                   \\___ " + $expression2.desc + "\n");
            
        }
    | expression '-' expression 
        {
            console.log("15) expression ::= expression '-' expression");
            console.log("                    \\_____________|____ " + $expression1.desc);
            console.log("                                   \\___ " + $expression2.desc + "\n");
            
        }
    | expression '*' expression 
        {
            console.log("16) expression ::= expression '*' expression");
            console.log("                    \\_____________|____ " + $expression1.desc);
            console.log("                                   \\___ " + $expression2.desc + "\n");
            
        }
    | expression '[' expression ']'
        {
            console.log("17) expression ::= expression '[' expression ']'");
            console.log("                    \\_____________|____ " + $expression1.desc);
            console.log("                                   \\___ " + $expression2.desc + "\n");
            
        }
    | expression '.' LENGTH
        {
            console.log("18) expression ::= expression '.' LENGTH");
            console.log("                    \\_______ " + $expression.desc + "\n");
            
        }
    | expression '.' ID '(' expression_list ')'
        {
            console.log("19) expression ::= expression '.' ID '(' expression_list ')'");
            console.log("                    \\_______|___ " + $expression.desc);
            console.log("                             \\__ " + $ID + "\n");
        }
    | INTEGER_LETERAL
        {
            console.log("20) expression ::= INTEGER_LETERAL");
            console.log("                     \\___ " + $INTEGER_LETERAL + "\n");
            
        }
    | TRUE
        {
            console.log("21) expression ::= TRUE");

            var obj = {};
            obj.type = "boolean";
            obj.value = "true";

            $$ = obj;
        }
    | FALSE
        {
            console.log("22) expression ::= FALSE");
            var obj = {};
            obj.type = "boolean";
            obj.value = "false";

            $$ = obj;
            
        }
    | ID
        {
            console.log("23) expression ::= ID");
            console.log("                    \\__ " + $ID + "\n");
            
        }
    | THIS
        {
            console.log("24) expression ::= THIS");
            
        }
    | NEW INT '[' expression ']'
        {
            console.log("25) expression ::= NEW INT '[' expression ']'");
            console.log("                                \\_______ " + $expression.desc + "\n");
            
        }
    | NEW ID '(' ')'
        {
            console.log("26) expression ::= NEW ID '(' ')'");
            console.log("                        \\___ " + $ID + "\n")

            /*console.log("new " + $ID + "()");*/
            $$ = "( new " + $ID + "() )";
        }
    | '!' expression
        {
            console.log("27) expression ::= '!' expression");
            console.log("                        \\_______ " + $expression.desc + "\n");

            var obj = {};
            obj.type = "boolean";

            $$ = obj;
        }
    | '(' expression ')'
        {
            console.log("28) expression ::= '(' expression ')'");
            console.log("                        \\_______ " + $expression.desc + "\n");

        }
    ;





type
    : INT '[' ']'
        {
            console.log("29) type ::= INT '[' ']'");

            $$ = "int[]";
        }
    | BOOLEAN
        {
            console.log("30) type ::= BOOLEAN");

            $$ = "boolean";
        }
    | INT
        {
            console.log("31) type ::= INT");

            $$ = "int";
        }
    ;

type_id
    : ID ID 
        {
            console.log("32) type_id ::= ID ID");
            console.log("                 \\_|___ " + $ID1);
            console.log("                    \\_____ " + $ID2 + "\n")

            /*console.log("ID ID :: " + $ID1 + " " + $ID2);*/
        }
    | type ID
        {
            console.log("33) type_id ::= type ID");
            console.log("                 \\___|__ " + $type);
            console.log("                      \\_____ " + $ID + "\n")

            $$ = $type + " " + $ID;
            /*console.log("type ID :: " + $$);*/
        }
    ;

type_id_list
    : type_id type_id_comma_list
        {
            console.log("34) type_id_list ::= type_id type_id_comma_list");
            console.log("                      \\___ " + $type_id.desc + "\n");

        }
    |
        {
            console.log("35) type_id_list");

        }
    ;

type_id_comma_list
    : ',' type_id type_id_comma_list
        {
            console.log("36) type_id_comma_list ::= ',' type_id type_id_comma_list");
            console.log("                                \\___ " + $type_id.desc + "\n");

        }
    |
        {
            console.log("37) type_id_comma_list ::=");

        }
    ;




var_decl_list
    : var_decl_list var_decl /* used left recursion to fix shift/reduce conflict! */
        {
            console.log("38) var_decl_list ::= var_decl_list var_decl");
            console.log("                                     \\___ " + $var_decl.desc + "\n");

        }
    |
        {
            console.log("39) var_decl_list ::=");

        }
    ;

var_decl
    : type_id ';'
        {
            console.log("40) var_decl ::= type_id ';'");
            console.log("                  \\___ " + $type_id.desc + "\n");

        }
    ;




main_class
    : CLASS ID '{' PUBLIC STATIC VOID MAIN '(' STRING '[' ']' ID ')' '{' statement_list '}' '}'
        {
            console.log("41) main_class ::= CLASS ID '{' PUBLIC STATIC VOID MAIN '(' STRING '[' ']' ID ')' '{' statement_list '}' '}'");
            console.log("                          \\________________________________________________|___ " + $ID1)
            console.log("                                                                            \\__ " + $ID2 + "\n")

            var obj = {};
            obj.name = $ID;

            $$ = obj;
            /*console.log("main_class");*/
        }
    ;





class_decl_list
    : class_decl class_decl_list
        {
            console.log("42) class_decl_list ::= class_decl class_decl_list");

        }
    |
        {
            console.log("43) class_decl_list ::= ");

        }
    ;

class_decl
    : CLASS ID class_extension_signature '{' var_decl_list method_decl_list '}'
        {
            console.log("44) class_decl ::= CLASS ID class_extension_signature '{' var_decl_list method_decl_list '}'");
            console.log("                          \\___ " + $ID + "\n");

        }
    ;

class_extension_signature
    : EXTENDS ID 
        {
            console.log("45) class_extension_signature ::= EXTENDS ID");
            console.log("                                           \\___ " + $ID + "\n");

        }
    |
        {
            console.log("46) class_extension_signature ::= ");

        }
    ;




method_decl_list
    : method_decl method_decl_list
        {
            console.log("47) method_decl_list ::= method_decl method_decl_list");

        }
    |
        {
            console.log("48) method_decl_list ::= ");

        }
    ;

method_decl
    : PUBLIC type_id '(' type_id_list ')' '{' var_decl_list statement_list RETURN expression ';' '}'
        {
            console.log("49) method_decl ::= PUBLIC type_id '(' type_id_list ')' '{' var_decl_list statement_list RETURN expression ';' '}'");

        }
    ;









