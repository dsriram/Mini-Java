
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
            console.log("goal ::= main_class class_decl_list EOF");
            console.log("          \\_________|____ " + $main_class.desc);
            console.log("                     \\___ " + $class_decl_list.desc);
            console.log();
            
            var obj = {};
            obj.desc = $main_class.desc + " " + $class_decl_list.desc;

            $$ = obj;
        }
    ;




statement_list /* == (statement)* */
    : statement statement_list
        {
            console.log("0)  statement_list ::= statement statement_list");
            console.log("                        \\___ " + $statement.desc);
            console.log();
            
            var obj = {};
            obj.desc = $statement.desc + $statement_list.desc;

            $$ = obj;
        }
    |
        {
            console.log("1)  statement_list ::= ");
            console.log();
            
            var obj = {};
            obj.desc = "";

            $$ = obj;
            
        }
    ;

statement
    : '{' statement_list '}'
        {
            console.log("2)  statement ::= '{' statement_list '}'");
            console.log("                       \\___ " + $statement_list.desc);
            console.log();
            
            var obj = {};
            obj.desc = "{ " + $statement_list.desc + " }";

            $$ = obj;
            
        }
    | IF '(' expression ')' statement ELSE statement
        {
            console.log("3)  statement ::= IF '(' expression ')' statement ELSE statement");
            console.log("                          \\_____________|_______________|____ " + $expression.desc);
            console.log("                                         \\______________|____ " + $statement1.desc);
            console.log("                                                         \\___ " + $statement2.desc);
            console.log();

            var obj = {};
            obj.desc = "IF (" + $expression.desc + " ) " + $statement1.desc + " ELSE " + $statement2.desc;

            $$ = obj;
        }
    | WHILE '(' expression ')' statement
        {
            console.log("4)  statement ::= WHILE '(' expression ')' statement");
            console.log("                             \\_____________|____ " + $expression.desc);
            console.log();
            
            var obj = {};
            obj.desc = "WHILE ( " + $expression.desc + " ) " + $statement.desc;

            $$ = obj;
        }
    | SYSOUT '(' expression ')' ';'
        {
            console.log ("5)  statement ::= SYSOUT '(' expression ')' ';'");
            console.log("                              \\____ " + $expression.desc);
            console.log();

            var obj = {};
            obj.desc = "SYSO ( " + $expression.desc + " ) ;";

            $$ = obj;
        }
    | ID '=' expression ';'
        {
            console.log("6)  statement ::= ID '=' expression ';'");
            console.log("                   \\______|___ " + $ID);
            console.log("                           \\__ " + $expression.desc);
            console.log();
            
            var obj = {};
            obj.desc = $ID + " = (" + $expression.desc + ")";

            $$ = obj;
            
        }
    | ID '[' expression ']' '=' expression ';'
        {
            console.log("7)  statement ::= ID '[' expression ']' '=' expression ';'");
            console.log("                  \\______|__________________|__ " + $ID);
            console.log("                          \\_________________|__ " + $expression1.desc)
            console.log("                                             \\_ " + $expression2.desc);
            console.log();

            var obj = {};
            obj.desc = $ID + "[ (" + $expression1.desc + ") ] = (" + $expression2.desc + ");";

            $$ = obj;
            
        }
    ;


expression_list /* == ( expression (',' expression)* )* */
    : expression expression_comma_list
        {
            console.log("8)  expression_list ::= expression expression_comma_list");
            console.log("                          \\___ " + $expression.desc);
            console.log();

            var obj = {};
            obj.desc = "(" + $expression.desc + ") " + $expression_comma_list.desc;

            $$ = obj;
            
        }
    |
        {
            console.log("9)  expression_list ::= ");
            console.log();

            var obj = {};
            obj.desc = "";

            $$ = obj;
            
        }
    ;

expression_comma_list
    : ',' expression expression_comma_list
        {
            console.log("10) expression_comma_list ::= ',' expression expression_comma_list");
            console.log("                                   \\___ " + $expression.desc);
            console.log();

            var obj = {};
            obj.desc = ", (" + $expression.desc + ")" + $expression_comma_list.desc;

            $$ = obj;
            
        }
    |
        {
            console.log("11) expression_comma_list ::= ");
            console.log();

            var obj = {};
            obj.desc = "";

            $$ = obj;
            
        }
    ;

expression
    : expression '&' expression
        {
            console.log("12) expression ::= expression '&' expression");
            console.log("                    \\_____________|____ " + $expression1.desc);
            console.log("                                   \\___ " + $expression2.desc);
            console.log();

            var obj = {};
            obj.desc = "(" + $expression1.desc + ") & (" + $expression2.desc + ")";

            $$ = obj;
        }
    | expression '<' expression 
        {
            console.log("13) expression ::= expression '<' expression");
            console.log("                    \\_____________|____ " + $expression1.desc);
            console.log("                                   \\___ " + $expression2.desc);
            console.log();

            var obj = {};
            obj.desc = "(" + $expression1.desc + ") < (" + $expression2.desc + ")";

            $$ = obj;
            
        }
    | expression '+' expression 
        {
            console.log("14) expression ::= expression '+' expression");
            console.log("                    \\_____________|____ " + $expression1.desc);
            console.log("                                   \\___ " + $expression2.desc);
            console.log();

            var obj = {};
            obj.desc = "(" + $expression1.desc + ") + (" + $expression2.desc + ")";

            $$ = obj;
            
        }
    | expression '-' expression 
        {
            console.log("15) expression ::= expression '-' expression");
            console.log("                    \\_____________|____ " + $expression1.desc);
            console.log("                                   \\___ " + $expression2.desc);
            console.log();

            var obj = {};
            obj.desc = "(" + $expression1.desc + ") - (" + $expression2.desc + ")";

            $$ = obj;
            
        }
    | expression '*' expression 
        {
            console.log("16) expression ::= expression '*' expression");
            console.log("                    \\_____________|____ " + $expression1.desc);
            console.log("                                   \\___ " + $expression2.desc);
            console.log();

            var obj = {};
            obj.desc = "(" + $expression1.desc + ") * (" + $expression2.desc + ")";

            $$ = obj;
            
        }
    | expression '[' expression ']'
        {
            console.log("17) expression ::= expression '[' expression ']'");
            console.log("                    \\_____________|____ " + $expression1.desc);
            console.log("                                   \\___ " + $expression2.desc);
            console.log();

            var obj = {};
            obj.desc = "(" + $expression1.desc + ")" + " [ (" + $expression2.desc + ") ]";

            $$ = obj;
            
        }
    | expression '.' LENGTH
        {
            console.log("18) expression ::= expression '.' LENGTH");
            console.log("                    \\_______ " + $expression.desc);
            console.log();

            var obj = {};
            obj.desc = "(" + $expression.desc + ").LENGTH ";

            $$ = obj;
            
        }
    | expression '.' ID '(' expression_list ')'
        {
            console.log("19) expression ::= expression '.' ID '(' expression_list ')'");
            console.log("                    \\_____________|___ " + $expression.desc);
            console.log("                                   \\__ " + $ID);
            console.log();

            var obj = {};
            obj.desc = "(" + $expression.desc + ")." + $ID + "(" + $expression_list.desc + ")";

            $$ = obj;
        }
    | INTEGER_LETERAL
        {
            console.log("20) expression ::= INTEGER_LETERAL");
            console.log("                     \\___ " + $INTEGER_LETERAL);
            console.log();

            var obj = {};
            obj.desc = $INTEGER_LETERAL;

            $$ = obj;
            
        }
    | TRUE
        {
            console.log("21) expression ::= TRUE");
            console.log();

            var obj = {};
            obj.desc = "true";

            $$ = obj;
        }
    | FALSE
        {
            console.log("22) expression ::= FALSE");
            console.log();
            
            var obj = {};
            obj.desc = "false";

            $$ = obj;
            
        }
    | ID
        {
            console.log("23) expression ::= ID");
            console.log("                    \\__ " + $ID);
            console.log();
            

            var obj = {};
            obj.desc = $ID;

            $$ = obj;
        }
    | THIS
        {
            console.log("24) expression ::= THIS");
            console.log();

            var obj = {};
            obj.desc = "this";

            $$ = obj;
            
        }
    | NEW INT '[' expression ']'
        {
            console.log("25) expression ::= NEW INT '[' expression ']'");
            console.log("                                \\_______ " + $expression.desc);
            console.log();


            var obj = {};
            obj.desc = "new int [" + $expression.desc + "]";

            $$ = obj;
            
        }
    | NEW ID '(' ')'
        {
            console.log("26) expression ::= NEW ID '(' ')'");
            console.log("                        \\___ " + $ID);
            console.log();

            var obj = {};
            obj.desc = "new " + $ID + "()";

            $$ = obj;
        }
    | '!' expression
        {
            console.log("27) expression ::= '!' expression");
            console.log("                        \\_______ " + $expression.desc);
            console.log();

            var obj = {};
            obj.desc = "! (" + $expression.desc + ")";

            $$ = obj;
        }
    | '(' expression ')'
        {
            console.log("28) expression ::= '(' expression ')'");
            console.log("                        \\_______ " + $expression.desc);
            console.log();

            var obj = {};
            obj.desc = "( " + $expression.desc + " )";

            $$ = obj;

        }
    ;





type
    : INT '[' ']'
        {
            console.log("29) type ::= INT '[' ']'");
            console.log();

            var obj = {};
            obj.desc = "int[]"

            $$ = obj;
        }
    | BOOLEAN
        {
            console.log("30) type ::= BOOLEAN");
            console.log();

            var obj = {};
            obj.desc = "boolean"

            $$ = obj;
        }
    | INT
        {
            console.log("31) type ::= INT");
            console.log();

            var obj = {};
            obj.desc = "int";

            $$ = obj;
        }
    ;

type_id
    : ID ID 
        {
            console.log("32) type_id ::= ID ID");
            console.log("                 \\_|___ " + $ID1);
            console.log("                    \\_____ " + $ID2);
            console.log();


            var obj = {};
            obj.desc = $ID + " " + $ID;

            $$ = obj;
        }
    | type ID
        {
            console.log("33) type_id ::= type ID");
            console.log("                 \\___|__ " + $type);
            console.log("                      \\_____ " + $ID);
            console.log();


            var obj = {};
            obj.desc = $type.desc + " " + $ID;

            $$ = obj;
        }
    ;

type_id_list
    : type_id type_id_comma_list
        {
            console.log("34) type_id_list ::= type_id type_id_comma_list");
            console.log("                      \\___ " + $type_id.desc);
            console.log();

            var obj = {};
            obj.desc = $type_id.desc + " " + $type_id_comma_list.desc;

            $$ = obj;

        }
    |
        {
            console.log("35) type_id_list");
            console.log();

            var obj = {};
            obj.desc = "";

            $$ = obj;

        }
    ;

type_id_comma_list
    : ',' type_id type_id_comma_list
        {
            console.log("36) type_id_comma_list ::= ',' type_id type_id_comma_list");
            console.log("                                \\___ " + $type_id.desc);
            console.log();


            var obj = {};
            obj.desc = ", " + $type_id.desc + $type_id_comma_list.desc

            $$ = obj;

        }
    |
        {
            console.log("37) type_id_comma_list ::=");
            console.log();


            var obj = {};
            obj.desc = "";

            $$ = obj;

        }
    ;




var_decl_list
    : var_decl_list var_decl /* used left recursion to fix shift/reduce conflict! */
        {
            console.log("38) var_decl_list ::= var_decl_list var_decl");
            console.log("                                     \\___ " + $var_decl.desc);
            console.log();


            var obj = {};
            obj.desc = $var_decl_list.desc + " " + $var_decl.desc

            $$ = obj;

        }
    |
        {
            console.log("39) var_decl_list ::=");
            console.log();


            var obj = {};
            obj.desc = "";

            $$ = obj;

        }
    ;

var_decl
    : type_id ';'
        {
            console.log("40) var_decl ::= type_id ';'");
            console.log("                  \\___ " + $type_id.desc);
            console.log();


            var obj = {};
            obj.desc = $type_id.desc + ";";

            $$ = obj;

        }
    ;




main_class
    : CLASS ID '{' PUBLIC STATIC VOID MAIN '(' STRING '[' ']' ID ')' '{' statement_list '}' '}'
        {
            console.log("41) main_class ::= CLASS ID '{' PUBLIC STATIC VOID MAIN '(' STRING '[' ']' ID ')' '{' statement_list '}' '}'");
            console.log("                          \\________________________________________________|___ " + $ID1)
            console.log("                                                                            \\__ " + $ID2)
            console.log();

            var obj = {};
            obj.desc = "Main class: " + $ID;

            $$ = obj;
        }
    ;





class_decl_list
    : class_decl class_decl_list
        {
            console.log("42) class_decl_list ::= class_decl class_decl_list");
            console.log();


            var obj = {};
            obj.desc = $class_decl.desc + "        " + $class_decl_list.desc;

            $$ = obj;

        }
    |
        {
            console.log("43) class_decl_list ::= ");
            console.log();


            var obj = {};
            obj.desc = "";

            $$ = obj;

        }
    ;

class_decl
    : CLASS ID class_extension_signature '{' var_decl_list method_decl_list '}'
        {
            console.log("44) class_decl ::= CLASS ID class_extension_signature '{' var_decl_list method_decl_list '}'");
            console.log("                          \\___ " + $ID);
            console.log();


            var obj = {};
            obj.desc = "Class: " + $ID;

            $$ = obj;

        }
    ;

class_extension_signature
    : EXTENDS ID 
        {
            console.log("45) class_extension_signature ::= EXTENDS ID");
            console.log("                                           \\___ " + $ID);
            console.log();


            var obj = {};
            obj.desc = "extends " + $ID;

            $$ = obj;

        }
    |
        {
            console.log("46) class_extension_signature ::= ");
            console.log();


            var obj = {};
            obj.desc = "";

            $$ = obj;

        }
    ;




method_decl_list
    : method_decl method_decl_list
        {
            console.log("47) method_decl_list ::= method_decl method_decl_list");
            console.log();


            var obj = {};
            obj.desc = $method_decl.desc + " " + $method_decl_list.desc;

            $$ = obj;

        }
    |
        {
            console.log("48) method_decl_list ::= ");
            console.log();


            var obj = {};
            obj.desc = "";

            $$ = obj;

        }
    ;

method_decl
    : PUBLIC type_id '(' type_id_list ')' '{' var_decl_list statement_list RETURN expression ';' '}'
        {
            console.log("49) method_decl ::= PUBLIC type_id '(' type_id_list ')' '{' var_decl_list statement_list RETURN expression ';' '}'");
            console.log();


            var obj = {};
            obj.desc = "public " + $type_id.desc + "(" + $type_id_list.desc + ") { " + $var_decl_list.desc + "   " + $statement_list.desc + "   return (" + $expression.desc + ";}";

            $$ = obj;

        }
    ;









