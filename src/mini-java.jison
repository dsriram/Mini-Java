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
        {{
            log = console.log;
            
            INCLUDE("node");
            Node = LocalNode;
            Leaf = LocalLeaf;

            INCLUDE("underscore");
            
            root = new Node("root", "ROOT_NODE");
        }}
    ;

goal
    : main_class class_decl_list EOF
        {{
            var node = new Node ("goal", 1);

            node.print = function() {
                log("goal ::= main_class class_decl_list EOF");
                log("          \\_________|____ " + $main_class.desc);
                log("                     \\___ " + $class_decl_list.desc);
                log();
            }
            
            node.desc = $main_class.desc + " " + $class_decl_list.desc;

            // CHILDREN
            var children = new Array();
            
            children[0] = $main_class;
            children[0].parent = node;
            
            children[1] = $class_decl_list;
            children[1].parent = node;
//FIXME
            node.setChildren(children);


            $$ = node;
        }}
    ;




statement_list /* == (statement)* */
    : statement statement_list
        {{
            var node = new Node("statement_list", 1);
            
            node.print = function() {
                log("0)  statement_list ::= statement statement_list");
                log("                        \\___ " + $statement.desc);
                log();
            }
            node.desc = $statement.desc + $statement_list.desc;

            $$ = node;
        }}
    |
        {{
            var node = new Node("statement_list", 2);
            
            node.print = function() {
                log("1)  statement_list ::= ");
                log();
            }
            
            node.desc = "";

            // NO CHILDREN

            $$ = node;
            
        }}
    ;

statement
    : '{' statement_list '}'
        {{
            var node = new Node("statement", 1);
            
            node.print = function() {
                log("2)  statement ::= '{' statement_list '}'");
                log("                       \\___ " + $statement_list.desc);
                log();
            }
            
            node.desc = "{ " + $statement_list.desc + " }";

            $$ = node;
            
        }}
    | IF '(' expression ')' statement ELSE statement
        {{
            var node = new Node("statement", 2);
            
            node.print = function() {
                log("3)  statement ::= IF '(' expression ')' statement ELSE statement");
                log("                          \\_____________|_______________|____ " + $expression.desc);
                log("                                         \\______________|____ " + $statement1.desc);
                log("                                                         \\___ " + $statement2.desc);
                log();
            }

            node.desc = "IF (" + $expression.desc + " ) " + $statement1.desc + " ELSE " + $statement2.desc;

            $$ = node;
        }}
    | WHILE '(' expression ')' statement
        {{
            var node = new Node("statement", 3);
            
            node.print = function() {
                log("4)  statement ::= WHILE '(' expression ')' statement");
                log("                             \\_____________|____ " + $expression.desc);
                log();
            }
            
            node.desc = "WHILE ( " + $expression.desc + " ) " + $statement.desc;

            $$ = node;
        }}
    | SYSOUT '(' expression ')' ';'
        {{
            var node = new Node("statement", 4);
            
            node.print = function() {
            log ("5)  statement ::= SYSOUT '(' expression ')' ';'");
                log("                              \\____ " + $expression.desc);
                log();
            }

            node.desc = "SYSO ( " + $expression.desc + " ) ;";

            $$ = node;
        }}
    | ID '=' expression ';'
        {{
            var node = new Node("statement", 5);
            
            node.print = function() {
                log("6)  statement ::= ID '=' expression ';'");
                log("                   \\______|___ " + $ID);
                log("                           \\__ " + $expression.desc);
                log();
            }
            
            node.desc = $ID + " = (" + $expression.desc + ")";

            $$ = node;
            
        }}
    | ID '[' expression ']' '=' expression ';'
        {{
            var node = new Node("statement", 6);
            
            node.print = function() {
                log("7)  statement ::= ID '[' expression ']' '=' expression ';'");
                log("                  \\______|__________________|__ " + $ID);
                log("                          \\_________________|__ " + $expression1.desc)
                log("                                             \\_ " + $expression2.desc);
                log();
            }

            node.desc = $ID + "[ (" + $expression1.desc + ") ] = (" + $expression2.desc + ");";

            $$ = node;
            
        }}
    ;


expression_list /* == ( expression (',' expression)* )* */
    : expression expression_comma_list
        {{
            var node = new Node("expression_list", 1);
            
            node.print = function() {
                log("8)  expression_list ::= expression expression_comma_list");
                log("                          \\___ " + $expression.desc);
                log();
            }

            node.desc = "(" + $expression.desc + ")" + $expression_comma_list.desc;

            $$ = node;
            
        }}
    |
        {{
            var node = new Node("expression_list", 2);
            
            node.print = function() {
                log("9)  expression_list ::= ");
                log();
            }

            node.desc = "";

            $$ = node;
            
        }}
    ;

expression_comma_list
    : ',' expression expression_comma_list
        {{
            var node = new Node("expression_comma_list", 1);
            
            node.print = function() {
                log("10) expression_comma_list ::= ',' expression expression_comma_list");
                log("                                   \\___ " + $expression.desc);
                log();
            }

            node.desc = ", (" + $expression.desc + ")" + $expression_comma_list.desc;

            $$ = node;
            
        }}
    |
        {{
            var node = new Node("expression_comma_list", 2);
            
            node.print = function() {
                log("11) expression_comma_list ::= ");
                log();
            }

            node.desc = "";

            $$ = node;
            
        }}
    ;

expression
    : expression '&' expression
        {{
            var node = new Node("expression", 1);
            
            node.print = function() {
                log("12) expression ::= expression '&' expression");
                log("                    \\_____________|____ " + $expression1.desc);
                log("                                   \\___ " + $expression2.desc);
                log();
            }

            node.desc = "(" + $expression1.desc + ") & (" + $expression2.desc + ")";

            $$ = node;
        }}
    | expression '<' expression 
        {{
            var node = new Node("expression", 2);
            
            node.print = function() {
                log("13) expression ::= expression '<' expression");
                log("                    \\_____________|____ " + $expression1.desc);
                log("                                   \\___ " + $expression2.desc);
                log();
            }

            node.desc = "(" + $expression1.desc + ") < (" + $expression2.desc + ")";

            $$ = node;
            
        }}
    | expression '+' expression 
        {{
            var node = new Node("expression", 3);
            
            node.print = function() {
                log("14) expression ::= expression '+' expression");
                log("                    \\_____________|____ " + $expression1.desc);
                log("                                   \\___ " + $expression2.desc);
                log();
            }

            node.desc = "(" + $expression1.desc + ") + (" + $expression2.desc + ")";

            $$ = node;
            
        }}
    | expression '-' expression 
        {{
            var node = new Node("expression", 4);
            
            node.print = function() {
                log("15) expression ::= expression '-' expression");
                log("                    \\_____________|____ " + $expression1.desc);
                log("                                   \\___ " + $expression2.desc);
                log();
            }

            node.desc = "(" + $expression1.desc + ") - (" + $expression2.desc + ")";

            $$ = node;
            
        }}
    | expression '*' expression 
        {{
            var node = new Node("expression", 5);
            
            node.print = function() {
                log("16) expression ::= expression '*' expression");
                log("                    \\_____________|____ " + $expression1.desc);
                log("                                   \\___ " + $expression2.desc);
                log();
            }

            node.desc = "(" + $expression1.desc + ") * (" + $expression2.desc + ")";

            $$ = node;
            
        }}
    | expression '[' expression ']'
        {{
            var node = new Node("expression", 6);
            
            node.print = function() {
                log("17) expression ::= expression '[' expression ']'");
                log("                    \\_____________|____ " + $expression1.desc);
                log("                                   \\___ " + $expression2.desc);
                log();
            }

            node.desc = "(" + $expression1.desc + ")" + " [ (" + $expression2.desc + ") ]";

            $$ = node;
            
        }}
    | expression '.' LENGTH
        {{
            var node = new Node("expression", 7);
            
            node.print = function() {
                log("18) expression ::= expression '.' LENGTH");
                log("                    \\_______ " + $expression.desc);
                log();
            }

            node.desc = "(" + $expression.desc + ").LENGTH ";

            $$ = node;
            
        }}
    | expression '.' ID '(' expression_list ')'
        {{
            var node = new Node("expression", 8);
            
            node.print = function() {
                log("19) expression ::= expression '.' ID '(' expression_list ')'");
                log("                    \\_____________|___ " + $expression.desc);
                log("                                   \\__ " + $ID);
                log();
            }

            node.desc = "(" + $expression.desc + ")." + $ID + "(" + $expression_list.desc + ")";

            $$ = node;
        }}
    | INTEGER_LETERAL
        {{
            var node = new Node("expression", 9);
            
            node.print = function() {
                log("20) expression ::= INTEGER_LETERAL");
                log("                     \\___ " + $INTEGER_LETERAL);
                log();
            }

            node.desc = $INTEGER_LETERAL;

            $$ = node;
            
        }}
    | TRUE
        {{
            var node = new Node("expression", 10);
            
            node.print = function() {
                log("21) expression ::= TRUE");
                log();
            }

            node.desc = "true";

            $$ = node;
        }}
    | FALSE
        {{
            var node = new Node("expression", 11);
            
            node.print = function() {
                log("22) expression ::= FALSE");
                log();
            }
            
            node.desc = "false";

            $$ = node;
            
        }}
    | ID
        {{
            var node = new Node("expression", 12);
            
            node.print = function() {
                log("23) expression ::= ID");
                log("                    \\__ " + $ID);
                log();
            }
            

            node.desc = $ID;

            $$ = node;
        }}
    | THIS
        {{
            var node = new Node("expression", 13);
            
            node.print = function() {
                log("24) expression ::= THIS");
                log();
            }

            node.desc = "this";

            $$ = node;
            
        }}
    | NEW INT '[' expression ']'
        {{
            var node = new Node("expression", 14);
            
            node.print = function() {
                log("25) expression ::= NEW INT '[' expression ']'");
                log("                                \\_______ " + $expression.desc);
                log();
            }


            node.desc = "new int [" + $expression.desc + "]";

            $$ = node;
            
        }}
    | NEW ID '(' ')'
        {{
            var node = new Node("expression", 15);
            
            node.print = function() {
                log("26) expression ::= NEW ID '(' ')'");
                log("                        \\___ " + $ID);
                log();
            }

            node.desc = "new " + $ID + "()";

            // CHILDREN
            var children = new Array();
            
            children[0] = new Leaf("new", "new", node);
            
            children[1] = new Leaf("id", $ID, node);
            
            children[2] = new Leaf("(", "(", node);
            
            children[3] = new Leaf(")", ")", node);

            node.setChildren(children);

            
            $$ = node;
        }}
    | '!' expression
        {{
            var node = new Node("expression", 16);
            
            node.print = function() {
                log("27) expression ::= '!' expression");
                log("                        \\_______ " + $expression.desc);
                log();
            }

            node.desc = "! (" + $expression.desc + ")";

            $$ = node;
        }}
    | '(' expression ')'
        {{
            var node = new Node("expression", 17);
            
            node.print = function() {
                log("28) expression ::= '(' expression ')'");
                log("                        \\_______ " + $expression.desc);
                log();
            }

            node.desc = "( " + $expression.desc + " )";

            $$ = node;

        }}
    ;





type
    : INT '[' ']'
        {{
            $$ = new Leaf("type", "int[]");
        }}
    | BOOLEAN
        {{
            $$ = new Leaf("type", "boolean");
        }}
    | INT
        {{
            $$ = new Leaf("type", "int");
        }}
    ;

type_id
    : ID ID 
        {{
            var node = new Node("type_id", 1);
            
            node.print = function() {
                log("32) type_id ::= ID ID");
                log("                 \\_|____ " + $ID1);
                log("                    \\___ " + $ID2);
                log();
            }

            node.desc = $ID1 + " " + $ID2;

            // CHILDREN
            var children = new Array();
            
            children[0] = new Leaf("type", $ID1, node);
            
            children[1] = new Leaf("id", $ID2, node);

            node.setChildren(children);

            
            $$ = node;
        }}
    | type ID
        {{
            var node = new Node("type_id", 2);
            
            node.print = function() {
                log("33) type_id ::= type ID");
                log("                 \\___|____ " + $type.desc);
                log("                      \\___ " + $ID);
                log();
            }

            node.desc = $type.desc + " " + $ID;

            // CHILDREN
            var children = new Array();
            
            children[0] = $type;
            children[0].parent = node;
            
            children[1] = new Leaf("id", $ID, node);

            node.setChildren(children);

            
            $$ = node;
        }}
    ;

type_id_list
    : type_id type_id_comma_list
        {{
            var node = new Node("type_id_list", 1);
            
            node.print = function() {
                log("34) type_id_list ::= type_id type_id_comma_list");
                log("                      \\___ " + $type_id.desc);
                log();
            }

            node.desc = $type_id.desc + " " + $type_id_comma_list.desc;

            $$ = node;

        }}
    |
        {{
            var node = new Node("type_id_list", 2);
            
            node.print = function() {
                log("35) type_id_list");
                log();
            }

            node.desc = "";

            $$ = node;

        }}
    ;

type_id_comma_list
    : ',' type_id type_id_comma_list
        {{
            var node = new Node("type_id_comma_list", 1);
            
            node.print = function() {
                log("36) type_id_comma_list ::= ',' type_id type_id_comma_list");
                log("                                \\___ " + $type_id.desc);
                log();
            }


            node.desc = ", " + $type_id.desc + $type_id_comma_list.desc

            $$ = node;

        }}
    |
        {{
            var node = new Node("type_id_comma_list", 2);
            
            node.print = function() {
                log("37) type_id_comma_list ::=");
                log();
            }


            node.desc = "";

            $$ = node;

        }}
    ;




var_decl_list
    : var_decl_list var_decl /* used left recursion to fix shift/reduce conflict! */
        {{
            var node = new Node("var_decl_list", 1);
            
            node.print = function() {
                log("38) var_decl_list ::= var_decl_list var_decl");
                log("                                     \\___ " + $var_decl.desc);
                log();
            }


            node.desc = $var_decl_list.desc + " " + $var_decl.desc

            $$ = node;

        }}
    |
        {{
            var node = new Node("var_decl_list", 2);
            
            node.print = function() {
                log("39) var_decl_list ::=");
                log();
            }


            node.desc = "";

            $$ = node;

        }}
    ;

var_decl
    : type_id ';'
        {{
            var node = new Node("var_decl", 1);
            
            node.print = function() {
                log("40) var_decl ::= type_id ';'");
                log("                  \\___ " + $type_id.desc);
                log();
            }

            node.desc = $type_id.desc + ";";

            $$ = node;

        }}
    ;




main_class
    : CLASS ID '{' PUBLIC STATIC VOID MAIN '(' STRING '[' ']' ID ')' '{' statement_list '}' '}'
        {{
            var node = new Node("main_class", 1);
            
            node.print = function() {
                log("41) main_class ::= CLASS ID '{' PUBLIC STATIC VOID MAIN '(' STRING '[' ']' ID ')' '{' statement_list '}' '}'");
                log("                          \\________________________________________________|___ " + $ID1)
                log("                                                                            \\__ " + $ID2)
                log();
            }

            node.desc = "Main class: " + $ID;

            $$ = node;
        }}
    ;





class_decl_list
    : class_decl class_decl_list
        {{
            var node = new Node("class_decl_list", 1);
            
            node.print = function() {
                log("42) class_decl_list ::= class_decl class_decl_list");
                log();
            }


            node.desc = $class_decl.desc + "        " + $class_decl_list.desc;

            $$ = node;

        }}
    |
        {{
            var node = new Node("class_decl_list", 2);
            
            node.print = function() {
                log("43) class_decl_list ::= ");
                log();
            }


            node.desc = "";

            $$ = node;

        }}
    ;

class_decl
    : CLASS ID class_extension_signature '{' var_decl_list method_decl_list '}'
        {{
            var node = new Node("class_decl", 1);
            
            node.print = function() {
                log("44) class_decl ::= CLASS ID class_extension_signature '{' var_decl_list method_decl_list '}'");
                log("                          \\___ " + $ID);
                log();
            }


            node.desc = "Class: " + $ID;

            $$ = node;

        }}
    ;

class_extension_signature
    : EXTENDS ID 
        {{
            var node = new Node("class_extension_signature", 1);
            
            node.print = function() {
                log("45) class_extension_signature ::= EXTENDS ID");
                log("                                           \\___ " + $ID);
                log();
            }


            node.desc = "extends " + $ID;

            $$ = node;

        }}
    |
        {{
            var node = new Node("class_extension_signature", 2);
            
            node.print = function() {
                log("46) class_extension_signature ::= ");
                log();
            }


            node.desc = "";

            $$ = node;

        }}
    ;




method_decl_list
    : method_decl method_decl_list
        {{
            var node = new Node("method_decl_list", 1);
            
            node.print = function() {
                log("47) method_decl_list ::= method_decl method_decl_list");
                log();
            }


            node.desc = $method_decl.desc + " " + $method_decl_list.desc;

            $$ = node;

        }}
    |
        {{
            var node = new Node("method_decl_list", 2);
            
            node.print = function() {
                log("48) method_decl_list ::= ");
                log();
            }


            node.desc = "";

            $$ = node;

        }}
    ;

method_decl
    : PUBLIC type_id '(' type_id_list ')' '{' var_decl_list statement_list RETURN expression ';' '}'
        {{
            var node = new Node("method_decl", 1);
            
            node.print = function() {
                log("49) method_decl ::= PUBLIC type_id '(' type_id_list ')' '{' var_decl_list statement_list RETURN expression ';' '}'");
                log();
            }


            node.desc = "public " + $type_id.desc + "(" + $type_id_list.desc + ") { " + $var_decl_list.desc + "   " + $statement_list.desc + "   return (" + $expression.desc + ";}";

            $$ = node;

        }}
    ;









