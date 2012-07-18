
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
%start start

%% /* language grammar */

start
    : initializer goal
    ;

initializer
    : '.'
        {
            log = console.log;
            INCLUDE("node");
            INCLUDE("underscore");

            Node = LocalNode;
            root = new Node("root", "ROOT_NODE");
        }
    ;

goal
    : main_class class_decl_list EOF
        {
            log("goal ::= main_class class_decl_list EOF");
            log("          \\_________|____ " + $main_class.desc);
            log("                     \\___ " + $class_decl_list.desc);
            log();

            var obj = {};

            obj.desc = $main_class.desc + " " + $class_decl_list.desc;
            $$ = obj;
        }
    ;




statement_list /* == (statement)* */
    : statement statement_list
        {
            log("0)  statement_list ::= statement statement_list");
            log("                        \\___ " + $statement.desc);
            log();
            
            var obj = {};
            obj.desc = $statement.desc + $statement_list.desc;

            $$ = obj;
        }
    |
        {
            log("1)  statement_list ::= ");
            log();
            
            var obj = {};
            obj.desc = "";

            $$ = obj;
            
        }
    ;

statement
    : '{' statement_list '}'
        {
            log("2)  statement ::= '{' statement_list '}'");
            log("                       \\___ " + $statement_list.desc);
            log();
            
            var obj = {};
            obj.desc = "{ " + $statement_list.desc + " }";

            $$ = obj;
            
        }
    | IF '(' expression ')' statement ELSE statement
        {
            log("3)  statement ::= IF '(' expression ')' statement ELSE statement");
            log("                          \\_____________|_______________|____ " + $expression.desc);
            log("                                         \\______________|____ " + $statement1.desc);
            log("                                                         \\___ " + $statement2.desc);
            log();

            var obj = {};
            obj.desc = "IF (" + $expression.desc + " ) " + $statement1.desc + " ELSE " + $statement2.desc;

            $$ = obj;
        }
    | WHILE '(' expression ')' statement
        {
            log("4)  statement ::= WHILE '(' expression ')' statement");
            log("                             \\_____________|____ " + $expression.desc);
            log();
            
            var obj = {};
            obj.desc = "WHILE ( " + $expression.desc + " ) " + $statement.desc;

            $$ = obj;
        }
    | SYSOUT '(' expression ')' ';'
        {
            log ("5)  statement ::= SYSOUT '(' expression ')' ';'");
            log("                              \\____ " + $expression.desc);
            log();

            var obj = {};
            obj.desc = "SYSO ( " + $expression.desc + " ) ;";

            $$ = obj;
        }
    | ID '=' expression ';'
        {
            log("6)  statement ::= ID '=' expression ';'");
            log("                   \\______|___ " + $ID);
            log("                           \\__ " + $expression.desc);
            log();
            
            var obj = {};
            obj.desc = $ID + " = (" + $expression.desc + ")";

            $$ = obj;
            
        }
    | ID '[' expression ']' '=' expression ';'
        {
            log("7)  statement ::= ID '[' expression ']' '=' expression ';'");
            log("                  \\______|__________________|__ " + $ID);
            log("                          \\_________________|__ " + $expression1.desc)
            log("                                             \\_ " + $expression2.desc);
            log();

            var obj = {};
            obj.desc = $ID + "[ (" + $expression1.desc + ") ] = (" + $expression2.desc + ");";

            $$ = obj;
            
        }
    ;


expression_list /* == ( expression (',' expression)* )* */
    : expression expression_comma_list
        {
            log("8)  expression_list ::= expression expression_comma_list");
            log("                          \\___ " + $expression.desc);
            log();

            var obj = {};
            obj.desc = "(" + $expression.desc + ")" + $expression_comma_list.desc;

            $$ = obj;
            
        }
    |
        {
            log("9)  expression_list ::= ");
            log();

            var obj = {};
            obj.desc = "";

            $$ = obj;
            
        }
    ;

expression_comma_list
    : ',' expression expression_comma_list
        {
            log("10) expression_comma_list ::= ',' expression expression_comma_list");
            log("                                   \\___ " + $expression.desc);
            log();

            var obj = {};
            obj.desc = ", (" + $expression.desc + ")" + $expression_comma_list.desc;

            $$ = obj;
            
        }
    |
        {
            log("11) expression_comma_list ::= ");
            log();

            var obj = {};
            obj.desc = "";

            $$ = obj;
            
        }
    ;

expression
    : expression '&' expression
        {
            log("12) expression ::= expression '&' expression");
            log("                    \\_____________|____ " + $expression1.desc);
            log("                                   \\___ " + $expression2.desc);
            log();

            var obj = {};
            obj.desc = "(" + $expression1.desc + ") & (" + $expression2.desc + ")";

            $$ = obj;
        }
    | expression '<' expression 
        {
            log("13) expression ::= expression '<' expression");
            log("                    \\_____________|____ " + $expression1.desc);
            log("                                   \\___ " + $expression2.desc);
            log();

            var obj = {};
            obj.desc = "(" + $expression1.desc + ") < (" + $expression2.desc + ")";

            $$ = obj;
            
        }
    | expression '+' expression 
        {
            log("14) expression ::= expression '+' expression");
            log("                    \\_____________|____ " + $expression1.desc);
            log("                                   \\___ " + $expression2.desc);
            log();

            var obj = {};
            obj.desc = "(" + $expression1.desc + ") + (" + $expression2.desc + ")";

            $$ = obj;
            
        }
    | expression '-' expression 
        {
            log("15) expression ::= expression '-' expression");
            log("                    \\_____________|____ " + $expression1.desc);
            log("                                   \\___ " + $expression2.desc);
            log();

            var obj = {};
            obj.desc = "(" + $expression1.desc + ") - (" + $expression2.desc + ")";

            $$ = obj;
            
        }
    | expression '*' expression 
        {
            log("16) expression ::= expression '*' expression");
            log("                    \\_____________|____ " + $expression1.desc);
            log("                                   \\___ " + $expression2.desc);
            log();

            var obj = {};
            obj.desc = "(" + $expression1.desc + ") * (" + $expression2.desc + ")";

            $$ = obj;
            
        }
    | expression '[' expression ']'
        {
            log("17) expression ::= expression '[' expression ']'");
            log("                    \\_____________|____ " + $expression1.desc);
            log("                                   \\___ " + $expression2.desc);
            log();

            var obj = {};
            obj.desc = "(" + $expression1.desc + ")" + " [ (" + $expression2.desc + ") ]";

            $$ = obj;
            
        }
    | expression '.' LENGTH
        {
            log("18) expression ::= expression '.' LENGTH");
            log("                    \\_______ " + $expression.desc);
            log();

            var obj = {};
            obj.desc = "(" + $expression.desc + ").LENGTH ";

            $$ = obj;
            
        }
    | expression '.' ID '(' expression_list ')'
        {
            log("19) expression ::= expression '.' ID '(' expression_list ')'");
            log("                    \\_____________|___ " + $expression.desc);
            log("                                   \\__ " + $ID);
            log();

            var obj = {};
            obj.desc = "(" + $expression.desc + ")." + $ID + "(" + $expression_list.desc + ")";

            $$ = obj;
        }
    | INTEGER_LETERAL
        {
            log("20) expression ::= INTEGER_LETERAL");
            log("                     \\___ " + $INTEGER_LETERAL);
            log();

            var obj = {};
            obj.desc = $INTEGER_LETERAL;

            $$ = obj;
            
        }
    | TRUE
        {
            log("21) expression ::= TRUE");
            log();

            var obj = {};
            obj.desc = "true";

            $$ = obj;
        }
    | FALSE
        {
            log("22) expression ::= FALSE");
            log();
            
            var obj = {};
            obj.desc = "false";

            $$ = obj;
            
        }
    | ID
        {
            log("23) expression ::= ID");
            log("                    \\__ " + $ID);
            log();
            

            var obj = {};
            obj.desc = $ID;

            $$ = obj;
        }
    | THIS
        {
            log("24) expression ::= THIS");
            log();

            var obj = {};
            obj.desc = "this";

            $$ = obj;
            
        }
    | NEW INT '[' expression ']'
        {
            log("25) expression ::= NEW INT '[' expression ']'");
            log("                                \\_______ " + $expression.desc);
            log();


            var obj = {};
            obj.desc = "new int [" + $expression.desc + "]";

            $$ = obj;
            
        }
    | NEW ID '(' ')'
        {
            log("26) expression ::= NEW ID '(' ')'");
            log("                        \\___ " + $ID);
            log();

            var obj = {};
            obj.desc = "new " + $ID + "()";

            $$ = obj;
        }
    | '!' expression
        {
            log("27) expression ::= '!' expression");
            log("                        \\_______ " + $expression.desc);
            log();

            var obj = {};
            obj.desc = "! (" + $expression.desc + ")";

            $$ = obj;
        }
    | '(' expression ')'
        {
            log("28) expression ::= '(' expression ')'");
            log("                        \\_______ " + $expression.desc);
            log();

            var obj = {};
            obj.desc = "( " + $expression.desc + " )";

            $$ = obj;

        }
    ;





type
    : INT '[' ']'
        {
            log("29) type ::= INT '[' ']'");
            log();

            var obj = {};
            obj.desc = "int[]"

            $$ = obj;
        }
    | BOOLEAN
        {
            log("30) type ::= BOOLEAN");
            log();

            var obj = {};
            obj.desc = "boolean"

            $$ = obj;
        }
    | INT
        {
            log("31) type ::= INT");
            log();

            var obj = {};
            obj.desc = "int";

            $$ = obj;
        }
    ;

type_id
    : ID ID 
        {
            log("32) type_id ::= ID ID");
            log("                 \\_|____ " + $ID1);
            log("                    \\___ " + $ID2);
            log();

            var obj = {};
            obj.desc = $ID + " " + $ID;

            $$ = obj;
        }
    | type ID
        {
            log("33) type_id ::= type ID");
            log("                 \\___|____ " + $type.desc);
            log("                      \\___ " + $ID);
            log();


            var obj = {};
            obj.desc = $type.desc + " " + $ID;

            $$ = obj;
        }
    ;

type_id_list
    : type_id type_id_comma_list
        {
            log("34) type_id_list ::= type_id type_id_comma_list");
            log("                      \\___ " + $type_id.desc);
            log();

            var obj = {};
            obj.desc = $type_id.desc + " " + $type_id_comma_list.desc;

            $$ = obj;

        }
    |
        {
            log("35) type_id_list");
            log();

            var obj = {};
            obj.desc = "";

            $$ = obj;

        }
    ;

type_id_comma_list
    : ',' type_id type_id_comma_list
        {
            log("36) type_id_comma_list ::= ',' type_id type_id_comma_list");
            log("                                \\___ " + $type_id.desc);
            log();


            var obj = {};
            obj.desc = ", " + $type_id.desc + $type_id_comma_list.desc

            $$ = obj;

        }
    |
        {
            log("37) type_id_comma_list ::=");
            log();


            var obj = {};
            obj.desc = "";

            $$ = obj;

        }
    ;




var_decl_list
    : var_decl_list var_decl /* used left recursion to fix shift/reduce conflict! */
        {
            log("38) var_decl_list ::= var_decl_list var_decl");
            log("                                     \\___ " + $var_decl.desc);
            log();


            var obj = {};
            obj.desc = $var_decl_list.desc + " " + $var_decl.desc

            $$ = obj;

        }
    |
        {
            log("39) var_decl_list ::=");
            log();


            var obj = {};
            obj.desc = "";

            $$ = obj;

        }
    ;

var_decl
    : type_id ';'
        {
            log("40) var_decl ::= type_id ';'");
            log("                  \\___ " + $type_id.desc);
            log();


            var obj = {};
            obj.desc = $type_id.desc + ";";

            $$ = obj;

        }
    ;




main_class
    : CLASS ID '{' PUBLIC STATIC VOID MAIN '(' STRING '[' ']' ID ')' '{' statement_list '}' '}'
        {
            log("41) main_class ::= CLASS ID '{' PUBLIC STATIC VOID MAIN '(' STRING '[' ']' ID ')' '{' statement_list '}' '}'");
            log("                          \\________________________________________________|___ " + $ID1)
            log("                                                                            \\__ " + $ID2)
            log();

            var obj = {};
            obj.desc = "Main class: " + $ID;

            $$ = obj;
        }
    ;





class_decl_list
    : class_decl class_decl_list
        {
            log("42) class_decl_list ::= class_decl class_decl_list");
            log();


            var obj = {};
            obj.desc = $class_decl.desc + "        " + $class_decl_list.desc;

            $$ = obj;

        }
    |
        {
            log("43) class_decl_list ::= ");
            log();


            var obj = {};
            obj.desc = "";

            $$ = obj;

        }
    ;

class_decl
    : CLASS ID class_extension_signature '{' var_decl_list method_decl_list '}'
        {
            log("44) class_decl ::= CLASS ID class_extension_signature '{' var_decl_list method_decl_list '}'");
            log("                          \\___ " + $ID);
            log();


            var obj = {};
            obj.desc = "Class: " + $ID;

            $$ = obj;

        }
    ;

class_extension_signature
    : EXTENDS ID 
        {
            log("45) class_extension_signature ::= EXTENDS ID");
            log("                                           \\___ " + $ID);
            log();


            var obj = {};
            obj.desc = "extends " + $ID;

            $$ = obj;

        }
    |
        {
            log("46) class_extension_signature ::= ");
            log();


            var obj = {};
            obj.desc = "";

            $$ = obj;

        }
    ;




method_decl_list
    : method_decl method_decl_list
        {
            log("47) method_decl_list ::= method_decl method_decl_list");
            log();


            var obj = {};
            obj.desc = $method_decl.desc + " " + $method_decl_list.desc;

            $$ = obj;

        }
    |
        {
            log("48) method_decl_list ::= ");
            log();


            var obj = {};
            obj.desc = "";

            $$ = obj;

        }
    ;

method_decl
    : PUBLIC type_id '(' type_id_list ')' '{' var_decl_list statement_list RETURN expression ';' '}'
        {
            log("49) method_decl ::= PUBLIC type_id '(' type_id_list ')' '{' var_decl_list statement_list RETURN expression ';' '}'");
            log();


            var obj = {};
            obj.desc = "public " + $type_id.desc + "(" + $type_id_list.desc + ") { " + $var_decl_list.desc + "   " + $statement_list.desc + "   return (" + $expression.desc + ";}";

            $$ = obj;

        }
    ;









