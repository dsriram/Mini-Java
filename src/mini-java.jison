
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
            Node = LocalNode;

            INCLUDE("underscore");
            
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

            var node = new Node ("goal", 1);

            node.desc = $main_class.desc + " " + $class_decl_list.desc;
            $$ = node;
        }
    ;




statement_list /* == (statement)* */
    : statement statement_list
        {
            log("0)  statement_list ::= statement statement_list");
            log("                        \\___ " + $statement.desc);
            log();
            
            var node = new Node("statement_list", 1);
            node.desc = $statement.desc + $statement_list.desc;

            $$ = node;
        }
    |
        {
            log("1)  statement_list ::= ");
            log();
            
            var node = new Node("statement_list", 2);
            node.desc = "";

            $$ = node;
            
        }
    ;

statement
    : '{' statement_list '}'
        {
            log("2)  statement ::= '{' statement_list '}'");
            log("                       \\___ " + $statement_list.desc);
            log();
            
            var node = new Node("statement", 1);
            node.desc = "{ " + $statement_list.desc + " }";

            $$ = node;
            
        }
    | IF '(' expression ')' statement ELSE statement
        {
            log("3)  statement ::= IF '(' expression ')' statement ELSE statement");
            log("                          \\_____________|_______________|____ " + $expression.desc);
            log("                                         \\______________|____ " + $statement1.desc);
            log("                                                         \\___ " + $statement2.desc);
            log();

            var node = new Node("statement", 2);
            node.desc = "IF (" + $expression.desc + " ) " + $statement1.desc + " ELSE " + $statement2.desc;

            $$ = node;
        }
    | WHILE '(' expression ')' statement
        {
            log("4)  statement ::= WHILE '(' expression ')' statement");
            log("                             \\_____________|____ " + $expression.desc);
            log();
            
            var node = new Node("statement", 3);
            node.desc = "WHILE ( " + $expression.desc + " ) " + $statement.desc;

            $$ = node;
        }
    | SYSOUT '(' expression ')' ';'
        {
            log ("5)  statement ::= SYSOUT '(' expression ')' ';'");
            log("                              \\____ " + $expression.desc);
            log();

            var node = new Node("statement", 4);
            node.desc = "SYSO ( " + $expression.desc + " ) ;";

            $$ = node;
        }
    | ID '=' expression ';'
        {
            log("6)  statement ::= ID '=' expression ';'");
            log("                   \\______|___ " + $ID);
            log("                           \\__ " + $expression.desc);
            log();
            
            var node = new Node("statement", 5);
            node.desc = $ID + " = (" + $expression.desc + ")";

            $$ = node;
            
        }
    | ID '[' expression ']' '=' expression ';'
        {
            log("7)  statement ::= ID '[' expression ']' '=' expression ';'");
            log("                  \\______|__________________|__ " + $ID);
            log("                          \\_________________|__ " + $expression1.desc)
            log("                                             \\_ " + $expression2.desc);
            log();

            var node = new Node("statement", 6);
            node.desc = $ID + "[ (" + $expression1.desc + ") ] = (" + $expression2.desc + ");";

            $$ = node;
            
        }
    ;


expression_list /* == ( expression (',' expression)* )* */
    : expression expression_comma_list
        {
            log("8)  expression_list ::= expression expression_comma_list");
            log("                          \\___ " + $expression.desc);
            log();

            var node = new Node("expression_list", 1);
            node.desc = "(" + $expression.desc + ")" + $expression_comma_list.desc;

            $$ = node;
            
        }
    |
        {
            log("9)  expression_list ::= ");
            log();

            var node = new Node("expression_list", 2);
            node.desc = "";

            $$ = node;
            
        }
    ;

expression_comma_list
    : ',' expression expression_comma_list
        {
            log("10) expression_comma_list ::= ',' expression expression_comma_list");
            log("                                   \\___ " + $expression.desc);
            log();

            var node = new Node("expression_comma_list", 1);
            node.desc = ", (" + $expression.desc + ")" + $expression_comma_list.desc;

            $$ = node;
            
        }
    |
        {
            log("11) expression_comma_list ::= ");
            log();

            var node = new Node("expression_comma_list", 2);
            node.desc = "";

            $$ = node;
            
        }
    ;

expression
    : expression '&' expression
        {
            log("12) expression ::= expression '&' expression");
            log("                    \\_____________|____ " + $expression1.desc);
            log("                                   \\___ " + $expression2.desc);
            log();

            var node = new Node("expression", 1);
            node.desc = "(" + $expression1.desc + ") & (" + $expression2.desc + ")";

            $$ = node;
        }
    | expression '<' expression 
        {
            log("13) expression ::= expression '<' expression");
            log("                    \\_____________|____ " + $expression1.desc);
            log("                                   \\___ " + $expression2.desc);
            log();

            var node = new Node("expression", 2);
            node.desc = "(" + $expression1.desc + ") < (" + $expression2.desc + ")";

            $$ = node;
            
        }
    | expression '+' expression 
        {
            log("14) expression ::= expression '+' expression");
            log("                    \\_____________|____ " + $expression1.desc);
            log("                                   \\___ " + $expression2.desc);
            log();

            var node = new Node("expression", 3);
            node.desc = "(" + $expression1.desc + ") + (" + $expression2.desc + ")";

            $$ = node;
            
        }
    | expression '-' expression 
        {
            log("15) expression ::= expression '-' expression");
            log("                    \\_____________|____ " + $expression1.desc);
            log("                                   \\___ " + $expression2.desc);
            log();

            var node = new Node("expression", 4);
            node.desc = "(" + $expression1.desc + ") - (" + $expression2.desc + ")";

            $$ = node;
            
        }
    | expression '*' expression 
        {
            log("16) expression ::= expression '*' expression");
            log("                    \\_____________|____ " + $expression1.desc);
            log("                                   \\___ " + $expression2.desc);
            log();

            var node = new Node("expression", 5);
            node.desc = "(" + $expression1.desc + ") * (" + $expression2.desc + ")";

            $$ = node;
            
        }
    | expression '[' expression ']'
        {
            log("17) expression ::= expression '[' expression ']'");
            log("                    \\_____________|____ " + $expression1.desc);
            log("                                   \\___ " + $expression2.desc);
            log();

            var node = new Node("expression", 6);
            node.desc = "(" + $expression1.desc + ")" + " [ (" + $expression2.desc + ") ]";

            $$ = node;
            
        }
    | expression '.' LENGTH
        {
            log("18) expression ::= expression '.' LENGTH");
            log("                    \\_______ " + $expression.desc);
            log();

            var node = new Node("expression", 7);
            node.desc = "(" + $expression.desc + ").LENGTH ";

            $$ = node;
            
        }
    | expression '.' ID '(' expression_list ')'
        {
            log("19) expression ::= expression '.' ID '(' expression_list ')'");
            log("                    \\_____________|___ " + $expression.desc);
            log("                                   \\__ " + $ID);
            log();

            var node = new Node("expression", 8);
            node.desc = "(" + $expression.desc + ")." + $ID + "(" + $expression_list.desc + ")";

            $$ = node;
        }
    | INTEGER_LETERAL
        {
            log("20) expression ::= INTEGER_LETERAL");
            log("                     \\___ " + $INTEGER_LETERAL);
            log();

            var node = new Node("expression", 9);
            node.desc = $INTEGER_LETERAL;

            $$ = node;
            
        }
    | TRUE
        {
            log("21) expression ::= TRUE");
            log();

            var node = new Node("expression", 10);
            node.desc = "true";

            $$ = node;
        }
    | FALSE
        {
            log("22) expression ::= FALSE");
            log();
            
            var node = new Node("expression", 11);
            node.desc = "false";

            $$ = node;
            
        }
    | ID
        {
            log("23) expression ::= ID");
            log("                    \\__ " + $ID);
            log();
            

            var node = new Node("expression", 12);
            node.desc = $ID;

            $$ = node;
        }
    | THIS
        {
            log("24) expression ::= THIS");
            log();

            var node = new Node("expression", 13);
            node.desc = "this";

            $$ = node;
            
        }
    | NEW INT '[' expression ']'
        {
            log("25) expression ::= NEW INT '[' expression ']'");
            log("                                \\_______ " + $expression.desc);
            log();


            var node = new Node("expression", 14);
            node.desc = "new int [" + $expression.desc + "]";

            $$ = node;
            
        }
    | NEW ID '(' ')'
        {
            log("26) expression ::= NEW ID '(' ')'");
            log("                        \\___ " + $ID);
            log();

            var node = new Node("expression", 15);
            node.desc = "new " + $ID + "()";

            $$ = node;
        }
    | '!' expression
        {
            log("27) expression ::= '!' expression");
            log("                        \\_______ " + $expression.desc);
            log();

            var node = new Node("expression", 16);
            node.desc = "! (" + $expression.desc + ")";

            $$ = node;
        }
    | '(' expression ')'
        {
            log("28) expression ::= '(' expression ')'");
            log("                        \\_______ " + $expression.desc);
            log();

            var node = new Node("expression", 17);
            node.desc = "( " + $expression.desc + " )";

            $$ = node;

        }
    ;





type
    : INT '[' ']'
        {
            log("29) type ::= INT '[' ']'");
            log();

            var node = new Node("type", 1);
            node.desc = "int[]"

            $$ = node;
        }
    | BOOLEAN
        {
            log("30) type ::= BOOLEAN");
            log();

            var node = new Node("type", 2);
            node.desc = "boolean"

            $$ = node;
        }
    | INT
        {
            log("31) type ::= INT");
            log();

            var node = new Node("type", 3);
            node.desc = "int";

            $$ = node;
        }
    ;

type_id
    : ID ID 
        {
            log("32) type_id ::= ID ID");
            log("                 \\_|____ " + $ID1);
            log("                    \\___ " + $ID2);
            log();

            var node = new Node("type_id", 1);
            node.desc = $ID + " " + $ID;

            $$ = node;
        }
    | type ID
        {
            log("33) type_id ::= type ID");
            log("                 \\___|____ " + $type.desc);
            log("                      \\___ " + $ID);
            log();


            var node = new Node("type_id", 2);
            node.desc = $type.desc + " " + $ID;

            $$ = node;
        }
    ;

type_id_list
    : type_id type_id_comma_list
        {
            log("34) type_id_list ::= type_id type_id_comma_list");
            log("                      \\___ " + $type_id.desc);
            log();

            var node = new Node("type_id_list", 1);
            node.desc = $type_id.desc + " " + $type_id_comma_list.desc;

            $$ = node;

        }
    |
        {
            log("35) type_id_list");
            log();

            var node = new Node("type_id_list", 2);
            node.desc = "";

            $$ = node;

        }
    ;

type_id_comma_list
    : ',' type_id type_id_comma_list
        {
            log("36) type_id_comma_list ::= ',' type_id type_id_comma_list");
            log("                                \\___ " + $type_id.desc);
            log();


            var node = new Node("type_id_comma_list", 1);
            node.desc = ", " + $type_id.desc + $type_id_comma_list.desc

            $$ = node;

        }
    |
        {
            log("37) type_id_comma_list ::=");
            log();


            var node = new Node("type_id_comma_list", 2);
            node.desc = "";

            $$ = node;

        }
    ;




var_decl_list
    : var_decl_list var_decl /* used left recursion to fix shift/reduce conflict! */
        {
            log("38) var_decl_list ::= var_decl_list var_decl");
            log("                                     \\___ " + $var_decl.desc);
            log();


            var node = new Node("var_decl_list", 1);
            node.desc = $var_decl_list.desc + " " + $var_decl.desc

            $$ = node;

        }
    |
        {
            log("39) var_decl_list ::=");
            log();


            var node = new Node("var_decl_list", 2);
            node.desc = "";

            $$ = node;

        }
    ;

var_decl
    : type_id ';'
        {
            log("40) var_decl ::= type_id ';'");
            log("                  \\___ " + $type_id.desc);
            log();


            var node = new Node("var_decl", 1);
            node.desc = $type_id.desc + ";";

            $$ = node;

        }
    ;




main_class
    : CLASS ID '{' PUBLIC STATIC VOID MAIN '(' STRING '[' ']' ID ')' '{' statement_list '}' '}'
        {
            log("41) main_class ::= CLASS ID '{' PUBLIC STATIC VOID MAIN '(' STRING '[' ']' ID ')' '{' statement_list '}' '}'");
            log("                          \\________________________________________________|___ " + $ID1)
            log("                                                                            \\__ " + $ID2)
            log();

            var node = new Node("main_class", 1);
            node.desc = "Main class: " + $ID;

            $$ = node;
        }
    ;





class_decl_list
    : class_decl class_decl_list
        {
            log("42) class_decl_list ::= class_decl class_decl_list");
            log();


            var node = new Node("class_decl_list", 1);
            node.desc = $class_decl.desc + "        " + $class_decl_list.desc;

            $$ = node;

        }
    |
        {
            log("43) class_decl_list ::= ");
            log();


            var node = new Node("class_decl_list", 2);
            node.desc = "";

            $$ = node;

        }
    ;

class_decl
    : CLASS ID class_extension_signature '{' var_decl_list method_decl_list '}'
        {
            log("44) class_decl ::= CLASS ID class_extension_signature '{' var_decl_list method_decl_list '}'");
            log("                          \\___ " + $ID);
            log();


            var node = new Node("class_decl", 1);
            node.desc = "Class: " + $ID;

            $$ = node;

        }
    ;

class_extension_signature
    : EXTENDS ID 
        {
            log("45) class_extension_signature ::= EXTENDS ID");
            log("                                           \\___ " + $ID);
            log();


            var node = new Node("class_extension_signature", 1);
            node.desc = "extends " + $ID;

            $$ = node;

        }
    |
        {
            log("46) class_extension_signature ::= ");
            log();


            var node = new Node("class_extension_signature", 2);
            node.desc = "";

            $$ = node;

        }
    ;




method_decl_list
    : method_decl method_decl_list
        {
            log("47) method_decl_list ::= method_decl method_decl_list");
            log();


            var node = new Node("method_decl_list", 1);
            node.desc = $method_decl.desc + " " + $method_decl_list.desc;

            $$ = node;

        }
    |
        {
            log("48) method_decl_list ::= ");
            log();


            var node = new Node("method_decl_list", 2);
            node.desc = "";

            $$ = node;

        }
    ;

method_decl
    : PUBLIC type_id '(' type_id_list ')' '{' var_decl_list statement_list RETURN expression ';' '}'
        {
            log("49) method_decl ::= PUBLIC type_id '(' type_id_list ')' '{' var_decl_list statement_list RETURN expression ';' '}'");
            log();


            var node = new Node("method_decl", 1);
            node.desc = "public " + $type_id.desc + "(" + $type_id_list.desc + ") { " + $var_decl_list.desc + "   " + $statement_list.desc + "   return (" + $expression.desc + ";}";

            $$ = node;

        }
    ;









