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
{digit}+                return "INTEGER_LITERAL"

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
%left '!'
%left '&'
%left '<'
%left '['
%left '='
%left '.'
%left '+' '-'
%left '*' '/'






/* start at goal */
%start start

%% /* language grammar */






// CHECKED 1 2
start
    : initializer goal
        {{
            // log(JSON.stringify(rootNode.printJSON(), null, 4));
            
            //console.log("\n\nCHECKING PARENTS:");
            //var res1 = rootNode.checkChildren();
            //console.log("RESULT: " + res1 + "\n\n");

            // console.log("\n\nVALIDATING TYPES:");
            var res2 = rootNode.validate();
            // console.log("RESULT: " + res2 + "\n\n");


            console.log("---end---");
            
            return {"log":output_log, "root_node":rootNode};
        }}
    ;

// CHECKED 1 2
initializer
    : '.'
        {{
            output_log = "";
            // log = console.log;
            log = function(message) { output_log += message + "\n"; }

            console.log("--start--");
            
            INCLUDE("node");
            Node = LocalNode;
            Leaf = LocalLeaf;
            rootNode = new Node ("ROOT_NODE", 1, null);

            INCLUDE("underscore");
            
        }}
    ;

// CHECKED 1 2
goal
    : main_class class_decl_list EOF
        {{

            rootNode.print = function() {
                log("goal ::= main_class class_decl_list EOF");
                log("          \\_________|____ " + $main_class.desc);
                log("                     \\___ " + $class_decl_list.desc);
                log();
            }
            
            rootNode.desc = $main_class.desc + " " + $class_decl_list.desc;

            // scope
            rootNode.addVariableToScope = function(name, type, kind, scope) {
                this.scope[name] = {"type": type, "kind": type, "scope": scope};
            }

            // CHILDREN
            var children = new Array();
            children[0] = $main_class;
            children[0].parent = rootNode;
            rootNode.addVariableToScope("main", "class", "class");

            var classes = $class_decl_list.returnFlattenedChildren();
            _.each(classes, function(class_decl) {
                class_decl.parent = rootNode;
                children.push(class_decl);
                rootNode.addVariableToScope($class_decl.className, "class", "class", class_decl.scope);
            });

            rootNode.setChildren(children);


            $$ = rootNode;
        }}
    ;







// CHECKED 1
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

            // CHILDREN
            var children = new Array();
            children[0] = $statement;
            children[0].parent = node;
            
            children[1] = $statement_list;
            children[1].parent = node;

            node.setChildren(children);

            node.returnFlattenedChildren = function() {
                var arr = new Array();
                arr[0] = children[0];
                arr[1] = children[1].returnFlattenedChildren();
                _.each(arr[1], function(item) {
                    item.parent = node;
                });
                return _.flatten(arr);
            };


            $$ = node;
        }}
    |
        {{
            var node = new Node("statement_list", 2);
            
            node.print = function() {
                log("1)  statement_list ::= ");
                log();
            }
            
            node.returnFlattenedChildren = function() {
                return [];
            }
            

            $$ = node;
            
        }}
    ;

// CHECKED 1
statement
    : '{' statement_list '}'
        {{
            var node = new Node("STATEMENT", 1);
            
            node.print = function() {
                log("2)  statement ::= '{' statement_list '}'");
                log("                       \\___ " + $statement_list.desc);
                log();
            }
            
            node.desc = "{ " + $statement_list.desc + " }";

            // CHILDREN
            var children = new Array();

            children.push(new Leaf("LITERAL", "{", node));
            var statements = $statement_list.returnFlattenedChildren();
            _.each(statements, function(item) {
                item.parent = node;
            });
            children.push(statements);
            children.push(new Leaf("LITERAL", "}", node));
            children = _.flatten(children);
            // log('CHILDREN: ' + children);

            node.setChildren(children);
            

            $$ = node;
            
        }}
    | IF '(' expression ')' statement ELSE statement
        {{
            var node = new Node("STATEMENT", 2);
            
            node.print = function() {
                log("3)  statement ::= IF '(' expression ')' statement ELSE statement");
                log("                          \\_____________|_______________|____ " + $expression.desc);
                log("                                         \\______________|____ " + $statement1.desc);
                log("                                                         \\___ " + $statement2.desc);
                log();
            }

            node.desc = "IF (" + $expression.desc + " ) " + $statement1.desc + " ELSE " + $statement2.desc;
            
            // CHILDREN
            var children = new Array();

            children.push(new Leaf("LITERAL", "IF", node));
            children.push(new Leaf("LITERAL", "(", node));
            $expression.parent = node;
            children.push($expression);
            children.push(new Leaf("LITERAL", ")", node));
            $statement1.parent = node;
            children.push($statement1);
            children.push(new Leaf("LITERAL", "ELSE", node));
            $statement2.parent = node;
            children.push($statement2);
            
            node.setChildren(children);
            

            // VALIDATION
            node.validate = function() {
                $expression.resolveType();
                if ($expression.type !== "boolean") {
                    var error = "";
                    error += "if (" + $expression + ");";
                    error += "\n";
                    error += "    ^~-- type should be 'boolean'";
                    log("\n" + error + "\n");
                    return false;
                }
                return this.validateChildren();
            };


            $$ = node;
        }}
    | WHILE '(' expression ')' statement
        {{
            var node = new Node("STATEMENT", 3);
            
            node.print = function() {
                log("4)  statement ::= WHILE '(' expression ')' statement");
                log("                             \\_____________|____ " + $expression.desc);
                log();
            }
            
            node.desc = "WHILE ( " + $expression.desc + " ) " + $statement.desc;
            
            // CHILDREN
            var children = new Array();

            children.push(new Leaf("LITERAL", "WHILE", node));
            children.push(new Leaf("LITERAL", "(", node));
            $expression.parent = node;
            children.push($expression);
            children.push(new Leaf("LITERAL", ")", node));
            $statement.parent = node;
            children.push($statement);
            
            node.setChildren(children);
            
            
            // VALIDATION
            node.validate = function() {
                $expression.resolveType();
                if ($expression.type !== "boolean") {
                    var error = "";
                    error += "while (" + $expression + ") ...";
                    error += "\n";
                    error += "        ^~-- type should be 'boolean'";
                    log("\n" + error + "\n");
                    return false;
                }
                return this.validateChildren();
            };
            

            $$ = node;
        }}
    | SYSOUT '(' expression ')' ';'
        {{
            var node = new Node("STATEMENT", 4);
            
            node.print = function() {
            log ("5)  statement ::= SYSOUT '(' expression ')' ';'");
                log("                              \\____ " + $expression.desc);
                log();
            }

            node.desc = "SYSO ( " + $expression.desc + " ) ;";

            // CHILDREN
            var children = new Array();

            children.push(new Leaf("LITERAL", "System.out.println", node));
            children.push(new Leaf("LITERAL", "(", node));
            $expression.parent = node;
            children.push($expression);
            children.push(new Leaf("LITERAL", ")", node));
            children.push(new Leaf("LITERAL", ";", node));
            
            node.setChildren(children);
            
            
            // VALIDATION
            node.validate = function() {
                $expression.resolveType();
                if ($expression.type !== "int") {
                    var error = "";
                    error += "System.out.println(" + $expression.desc + ");";
                    error += "\n";
                    error += "                   ^~-- type should be 'int'";
                    log("\n" + error + "\n");
                    return false;
                }
                return this.validateChildren();
            };



            $$ = node;
        }}
    | ID '=' expression ';'
        {{
            var node = new Node("STATEMENT", 5);
            
            node.print = function() {
                log("6)  statement ::= ID '=' expression ';'");
                log("                   \\______|___ " + $ID);
                log("                           \\__ " + $expression.desc);
                log();
            }
            
            node.desc = $ID + " = (" + $expression.desc + ")";

            // CHILDREN
            var children = new Array();

            children.push(new Leaf("ID", $ID, node));
            children.push(new Leaf("LITERAL", "=", node));
            $expression.parent = node;
            children.push($expression);
            children.push(new Leaf("LITERAL", ";", node));
            
            node.setChildren(children);


            node.type = "unknown";


            node.validate = function() {
                this.resolveType();
                return this.validateChildren();
            };

            

            node.resolveType = function() {
                var id_type = this.searchForVariableInScope($ID);
                if (id_type)
                    id_type = id_type["type"];

                $expression.resolveType();
                this.type = $expression.type;;
            };
            


            $$ = node;
            
        }}
    | ID '[' expression ']' '=' expression ';'
        {{
            var node = new Node("STATEMENT", 6);
            
            node.print = function() {
                log("7)  statement ::= ID '[' expression ']' '=' expression ';'");
                log("                  \\______|__________________|__ " + $ID);
                log("                          \\_________________|__ " + $expression1.desc)
                log("                                             \\_ " + $expression2.desc);
                log();
            }

            node.desc = $ID + "[ (" + $expression1.desc + ") ] = (" + $expression2.desc + ");";

            // CHILDREN
            var children = new Array();

            children.push(new Leaf("ID", $ID, node));
            children.push(new Leaf("LITERAL", "[", node));
            $expression1.parent = node;
            children.push($expression1);
            children.push(new Leaf("LITERAL", "]", node));
            children.push(new Leaf("LITERAL", "=", node));
            $expression2.parent = node;
            children.push($expression2);
            children.push(new Leaf("LITERAL", ";", node));
            
            node.setChildren(children);
            
            
            // VALIDATION
            node.validate = function() {
                $expression1.resolveType();
                $expression2.resolveType();
                if ($expression1.type !== "int") {
                    var error = "";
                    error += $ID + " [" + $expression1 + "] = ...";
                    error += "\n";
                    error += "              ^~-- type should be 'int'";
                    log("\n" + error + "\n");
                    return false;
                }
                return this.validateChildren();
            };



            $$ = node;
            
        }}
    ;








// CHECKED 1
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

            // CHILDREN
            var children = new Array();
            children[0] = $expression;
            children[0].parent = node;
            
            children[1] = new Leaf("LITERAL", ",", node);

            children[2] = $expression_comma_list;
            children[2].parent = node;

            node.setChildren(children);

            node.returnFlattenedChildren = function() {
                var arr = new Array();
                arr[0] = children[0];
                arr[2] = children[2].returnFlattenedChildren();
                if (arr[2].length) {
                    arr[1] = children[1];
                    _.each(arr[2], function(item) {
                        item.parent = node;
                    });
                }
                return _.flatten(arr);
            };

            $$ = node;
            
        }}
    |
        {{
            var node = new Node("expression_list", 2);
            
            node.print = function() {
                log("9)  expression_list ::= ");
                log();
            }

            node.returnFlattenedChildren = function() {
                return [];
            }

            $$ = node;
            
        }}
    ;


// CHECKED 1
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

            // CHILDREN
            var children = new Array();
            children[0] = $expression;
            children[0].parent = node;
            
            children[1] = new Leaf("LITERAL", ",", node);

            children[2] = $expression_comma_list;
            children[2].parent = node;

            node.setChildren(children);

            node.returnFlattenedChildren = function() {
                var arr = new Array();
                arr[0] = children[0];
                arr[2] = children[2].returnFlattenedChildren();
                if (arr[2].length) {
                    arr[1] = children[1];
                    _.each(arr[2], function(item) {
                        item.parent = node;
                    });
                }
                return _.flatten(arr);
            };

            $$ = node;
            
        }}
    |
        {{
            var node = new Node("expression_comma_list", 2);
            
            node.print = function() {
                log("11) expression_comma_list ::= ");
                log();
            }

            node.returnFlattenedChildren = function() {
                return [];
            }

            $$ = node;
            
        }}
    ;


// CHECKED 1
expression
    : expression '&' expression
        {{
            var node = new Node("EXPRESSION", 1);
            
            node.print = function() {
                log("12) expression ::= expression '&' expression");
                log("                    \\_____________|____ " + $expression1.desc);
                log("                                   \\___ " + $expression2.desc);
                log();
            }

            node.desc = "(" + $expression1.desc + ") & (" + $expression2.desc + ")";

            // CHILDREN
            var children = new Array();
            $expression1.parent = node;
            children.push($expression1);
            children.push(new Leaf("LITERAL", "&", node));
            $expression2.parent = node;
            children.push($expression2);
            
            node.setChildren(children);
            
            node.type = "unknown";

            node.resolveType = function() {
                $expression1.resolveType();
                $expression2.resolveType();
                if ($expression1.type === "boolean" && $expression2.type === "boolean") {
                    node.type = "boolean";
                }
            }
            
            
            // VALIDATION
            node.validate = function() {
                if (node.type !== "boolean") {
                    var error = "";
                    error += $expression1.desc + " && " + $expression2.desc;
                    error += "\n";
                    error += "           ^~-- type should be 'boolean'";
                    log("\n" + error + "\n");
                    return false;
                }
                return this.validateChildren();
            };


            $$ = node;
        }}
    | expression '<' expression 
        {{
            var node = new Node("EXPRESSION", 2);
            
            node.print = function() {
                log("13) expression ::= expression '<' expression");
                log("                    \\_____________|____ " + $expression1.desc);
                log("                                   \\___ " + $expression2.desc);
                log();
            }

            node.desc = "(" + $expression1.desc + ") < (" + $expression2.desc + ")";

            // CHILDREN
            var children = new Array();
            $expression1.parent = node;
            children.push($expression1);
            children.push(new Leaf("LITERAL", "<", node));
            $expression2.parent = node;
            children.push($expression2);
            
            node.setChildren(children);
            

            node.type = "unknown";

            node.resolveType = function() {
                $expression1.resolveType();
                $expression2.resolveType();
                if ($expression1.type === "int" && $expression2.type === "int") {
                    node.type = "boolean";
                }
            }
            
            // VALIDATION
            node.validate = function() {
                this.resolveType();
                if (node.type !== "boolean") {
                    var error = "";
                    error += $expression1.desc + " < " + $expression2.desc;
                    error += "\n";
                    error += "        ^~-- type should be 'int'";
                    log("\n" + error + "\n");
                    return false;
                }
                return this.validateChildren();
            };


            $$ = node;
            
        }}
    | expression '+' expression 
        {{
            var node = new Node("EXPRESSION", 3);
            
            node.print = function() {
                log("14) expression ::= expression '+' expression");
                log("                    \\_____________|____ " + $expression1.desc);
                log("                                   \\___ " + $expression2.desc);
                log();
            }

            node.desc = "(" + $expression1.desc + ") + (" + $expression2.desc + ")";

            // CHILDREN
            var children = new Array();
            $expression1.parent = node;
            children.push($expression1);
            children.push(new Leaf("LITERAL", "+", node));
            $expression2.parent = node;
            children.push($expression2);
            
            node.setChildren(children);
            
            node.type = "unknown";

            node.resolveType = function() {
                $expression1.resolveType();
                $expression2.resolveType();
                if ($expression1.type === "int" && $expression2.type === "int") {
                    node.type = "int";
                }
            }

            // VALIDATION
            node.validate = function() {
                if (node.type !== "int") {
                    var error = "";
                    error += $expression1.desc + " + " + $expression2.desc;
                    error += "\n";
                    error += "              ^~-- type should be 'int'";
                    log("\n" + error + "\n");
                    return false;
                }
                return this.validateChildren();
            };


            $$ = node;
            
        }}
    | expression '-' expression 
        {{
            var node = new Node("EXPRESSION", 4);
            
            node.print = function() {
                log("15) expression ::= expression '-' expression");
                log("                    \\_____________|____ " + $expression1.desc);
                log("                                   \\___ " + $expression2.desc);
                log();
            }

            node.desc = "(" + $expression1.desc + ") - (" + $expression2.desc + ")";

            // CHILDREN
            var children = new Array();
            $expression1.parent = node;
            children.push($expression1);
            children.push(new Leaf("LITERAL", "-", node));
            $expression2.parent = node;
            children.push($expression2);
            
            node.setChildren(children);
            
            node.type = "unknown";

            node.resolveType = function() {
                $expression1.resolveType();
                $expression2.resolveType();
                if ($expression1.type === "int" && $expression2.type === "int") {
                    node.type = "int";
                }
            }
            
            // VALIDATION
            node.validate = function() {
                if (node.type !== "int") {
                    var error = "";
                    error += $expression1.desc + " - " + $expression2.desc;
                    error += "\n";
                    error += "              ^~-- type should be 'int'";
                    log("\n" + error + "\n");
                    return false;
                }
                return this.validateChildren();
            };


            $$ = node;
            
        }}
    | expression '*' expression 
        {{
            var node = new Node("EXPRESSION", 5);
            
            node.print = function() {
                log("16) expression ::= expression '*' expression");
                log("                    \\_____________|____ " + $expression1.desc);
                log("                                   \\___ " + $expression2.desc);
                log();
            }

            node.desc = "(" + $expression1.desc + ") * (" + $expression2.desc + ")";

            // CHILDREN
            var children = new Array();
            $expression1.parent = node;
            children.push($expression1);
            children.push(new Leaf("LITERAL", "*", node));
            $expression2.parent = node;
            children.push($expression2);
            
            node.setChildren(children);
            
            node.type = "unknown";

            node.resolveType = function() {
                $expression1.resolveType();
                $expression2.resolveType();
                if ($expression1.type === "int" && $expression2.type === "int") {
                    node.type = "int";
                }
            }
            
            
            // VALIDATION
            node.validate = function() {
                if (node.type !== "undefined") {
                    var error = "";
                    error += $expression1.desc + " * " + $expression2.desc;
                    error += "\n";
                    error += "              ^~-- type should be 'int'";
                    log("\n" + error + "\n");
                    return false;
                }
                return this.validateChildren();
            };


            $$ = node;
            
        }}
    | expression '[' expression ']'
        {{
            var node = new Node("EXPRESSION", 6);
            
            node.print = function() {
                log("17) expression ::= expression '[' expression ']'");
                log("                    \\_____________|____ " + $expression1.desc);
                log("                                   \\___ " + $expression2.desc);
                log();
            }

            node.desc = "(" + $expression1.desc + ")" + " [ (" + $expression2.desc + ") ]";

            // CHILDREN
            var children = new Array();
            $expression1.parent = node;
            children.push($expression1);
            children.push(new Leaf("LITERAL", "[", node));
            $expression2.parent = node;
            children.push($expression2);
            children.push(new Leaf("LITERAL", "]", node));
            
            node.setChildren(children);
            
     
            node.type = "unknown";

            node.resolveType = function() {
                $expression1.resolveType();
                $expression2.resolveType();

                if ($expression2.type === "int") {
                    this.type = "valid";
                }

            };
            
            // VALIDATION
            node.validate = function() {
                if (node.type !== "undefined") {
                    var error = "";
                    error += $expression1.desc + " [ " + $expression2.desc + " ] ...";
                    error += "\n";
                    error += "     ^~-- type should be 'int'";
                    log("\n" + error + "\n");
                    return false;
                }
                return this.validateChildren();
            };


            $$ = node;
            
        }}
    | expression '.' LENGTH
        {{
            var node = new Node("EXPRESSION", 7);
            
            node.print = function() {
                log("18) expression ::= expression '.' LENGTH");
                log("                    \\_______ " + $expression.desc);
                log();
            }

            node.desc = "(" + $expression.desc + ").LENGTH ";

            // CHILDREN
            var children = new Array();
            $expression.parent = node;
            children.push($expression);
            children.push(new Leaf("LITERAL", ".", node));
            children.push(new Leaf("LITERAL", "LENGTH", node));
            
            node.setChildren(children);
            
     
            node.type = "int";

            $$ = node;
            
        }}
    | expression '.' ID '(' expression_list ')'
        {{
            var node = new Node("EXPRESSION", 8);
            
            node.print = function() {
                log("19) expression ::= expression '.' ID '(' expression_list ')'");
                log("                    \\_____________|___ " + $expression.desc);
                log("                                   \\__ " + $ID);
                log();
            }

            node.desc = "(" + $expression.desc + ")." + $ID + "(" + $expression_list.desc + ")";


            // CHILDREN
            var children = new Array();
            $expression.parent = node;
            children.push($expression);
            children.push(new Leaf("LITERAL", ".", node));
            children.push(new Leaf("ID", $ID, node));
            children.push(new Leaf("LITERAL", "(", node));
            var expressions = $expression_list.returnFlattenedChildren();
            _.each(expressions, function(item) {
                item.parent = node;
            });
            children.push(expressions);
            children.push(new Leaf("LITERAL", ")", node));
            children = _.flatten(children);
            
            node.setChildren(children);

            node.methodName = $ID;


            node.type = "unknown";

            node.resolveType = function() {
                var entry = this.searchForVariableInScope(this.methodName);
                if (entry.kind === "method")
                    this.type = entry.type;
            };


            $$ = node;
        }}
    | INTEGER_LITERAL
        {{
            var node = new Leaf("INTEGER_LITERAL", $INTEGER_LITERAL, undefined);
            
            node.print = function() {
                log("20) expression ::= INTEGER_LITERAL");
                log("                     \\___ " + $INTEGER_LITERAL);
                log();
            }

            node.desc = $INTEGER_LITERAL;

            node.type = "int";

            $$ = node;
            
        }}
    | TRUE
        {{
            var node = new Leaf("BOOLEAN", "TRUE", undefined);
            
            node.print = function() {
                log("21) expression ::= TRUE");
                log();
            }

            node.desc = "true";

            node.type = "boolean";

            $$ = node;
        }}
    | FALSE
        {{
            var node = new Leaf("BOOLEAN", "FALSE", undefined);
            
            node.print = function() {
                log("22) expression ::= FALSE");
                log();
            }
            
            node.desc = "false";

            node.type = "boolean";

            $$ = node;
            
        }}
    | ID
        {{
            var node = new Leaf("ID", $ID, undefined);
            
            node.print = function() {
                log("23) expression ::= ID");
                log("                    \\__ " + $ID);
                log();
            }      

            node.desc = $ID;

            node.type = "unknown";

            node.resolveType = function() {
                var entry = this.searchForVariableInScope($ID);
                this.type = entry.type;
            };

            $$ = node;
        }}
    | THIS
        {{
            var node = new Leaf("LITERAL", "THIS", undefined);
            
            node.print = function() {
                log("24) expression ::= THIS");
                log();
            }

            node.desc = "this";

            node.type = "unknown";

            node.resolveType = function() {
                var entry = this.searchForVariableInScope("this");
                if (entry.kind === "class")
                    this.type = entry.type;
            };

            $$ = node;
            
        }}
    | NEW INT '[' expression ']'
        {{
            var node = new Node("EXPRESSION", 14);
            
            node.print = function() {
                log("25) expression ::= NEW INT '[' expression ']'");
                log("                                \\_______ " + $expression.desc);
                log();
            }

            node.desc = "new int [" + $expression.desc + "]";

            // CHILDREN
            var children = new Array();
            children.push(new Leaf("LITERAL", "NEW", node));
            children.push(new Leaf("LITERAL", "[", node));
            $expression.parent = node;
            children.push($expression);
            children.push(new Leaf("LITERAL", "]", node));
            
            node.setChildren(children);
            

            node.type = "int[]";
            
            // VALIDATION
            node.validate = function() {
                $expression.resolveType();
                if ($expression.type !== "int") {
                    var error = "";
                    error += "new int[" + $expression + "]";
                    error += "\n";
                    error += "            ^~-- type should be 'int'";
                    log("\n" + error + "\n");
                    return false;
                }
                return this.validateChildren();
            };




            $$ = node;
            
        }}
    | NEW ID '(' ')'
        {{
            var node = new Node("EXPRESSION", 15);
            
            node.print = function() {
                log("26) expression ::= NEW ID '(' ')'");
                log("                        \\___ " + $ID);
                log();
            }

            node.desc = "new " + $ID + "()";

            // CHILDREN
            var children = new Array();
            children.push(new Leaf("LITERAL", "NEW", node));
            children.push(new Leaf("ID", $ID, node));
            children.push(new Leaf("LITERAL", "(", node));
            children.push(new Leaf("LITERAL", ")", node));
            
            node.setChildren(children);


            node.type = "unknown";


            node.resolveType = function() {
                var type = this.searchForVariableInScope($ID);
                if (type)
                    this.type = type.type;
            };
            
            $$ = node;
        }}
    | '!' expression
        {{
            var node = new Node("EXPRESSION", 16);
            
            node.print = function() {
                log("27) expression ::= '!' expression");
                log("                        \\_______ " + $expression.desc);
                log();
            }

            node.desc = "! (" + $expression.desc + ")";

            // CHILDREN
            var children = new Array();
            children.push(new Leaf("LITERAL", "!", node));
            $expression.parent = node;
            children.push($expression);
            
            node.setChildren(children);
            
            
            node.type = "unknown";

            if ($expression.type === "boolean")
                node.type = "boolean";
            
            // VALIDATION
            node.validate = function() {
                if ($expression.type !== "boolean") {
                    var error = "";
                    error += "! " + $expression.desc;
                    error += "\n";
                    error += "  ^~-- type should be 'boolean'";
                    log("\n" + error + "\n");
                    return false;
                }
                return this.validateChildren();
            };



            $$ = node;
        }}
    | '(' expression ')'
        {{
            var node = new Node("EXPRESSION", 17);
            
            node.print = function() {
                log("28) expression ::= '(' expression ')'");
                log("                        \\_______ " + $expression.desc);
                log();
            }

            node.desc = "( " + $expression.desc + " )";

            // CHILDREN
            var children = new Array();
            children.push(new Leaf("LITERAL", "(", node));
            $expression.parent = node;
            children.push($expression);
            children.push(new Leaf("LITERAL", ")", node));
            
            node.setChildren(children);

            node.type = $expression.type;

            $$ = node;

        }}
    ;








// CHECKED 1
type
    : INT '[' ']'
        {{
            $$ = new Leaf("TYPE", "int[]");
            $$.type = "int[]";
        }}
    | BOOLEAN
        {{
            $$ = new Leaf("TYPE", "boolean");
            $$.type = "boolean";
        }}
    | INT
        {{
            $$ = new Leaf("TYPE", "int");
            $$.type = "int";
        }}
    ;


// CHECKED 1
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
            
            children[0] = new Leaf("TYPE", $ID1, node);
            children[0].type = $ID1;

            children[1] = new Leaf("ID", $ID2, node);
            children[1].type = $ID1;

            node.setChildren(children);


            node.type = $ID1;

            
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

            node.desc = $type.value + " " + $ID;

            // CHILDREN
            var children = new Array();
            
            children[0] = $type;
            children[0].parent = node;
            children[0].type = $type.type;
            
            children[1] = new Leaf("ID", $ID, node);
            children[1].type = $type.type;

            node.setChildren(children);


            node.type = $type.type;

            
            $$ = node;
        }}
    ;


// CHECKED 1
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


            // CHILDREN
            var children = new Array();
            children[0] = $type_id;
            children[0].parent = node;
            
            children[1] = new Leaf("LITERAL", ",", node);

            children[2] = $type_id_comma_list;
            children[2].parent = node;

            node.setChildren(children);

            node.returnFlattenedChildren = function() {
                var arr = new Array();
                arr[0] = children[0].children;
                arr[2] = children[2].returnFlattenedChildren();
                if (arr[2].length) {
                    arr[1] = children[1];
                    _.each(arr[2], function(item) {
                        item.parent = node;
                    });
                }
                return _.flatten(arr);
            };

            $$ = node;

        }}
    |
        {{
            var node = new Node("type_id_list", 2);
            
            node.print = function() {
                log("35) type_id_list");
                log();
            }

            node.returnFlattenedChildren = function() {
                return [];
            }

            $$ = node;

        }}
    ;


// CHECKED 1
type_id_comma_list
    : ',' type_id type_id_comma_list
        {{
            var node = new Node("type_id_comma_list", 1);
            
            node.print = function() {
                log("36) type_id_comma_list ::= ',' type_id type_id_comma_list");
                log("                                \\___ " + $type_id.desc);
                log();
            }

            node.desc = ", " + $type_id.desc + $type_id_comma_list.desc;

            // CHILDREN
            var children = new Array();
            children[0] = $type_id;
            children[0].parent = node;
            
            children[1] = new Leaf("LITERAL", ",", node);

            children[2] = $type_id_comma_list;
            children[2].parent = node;

            node.setChildren(children);

            node.returnFlattenedChildren = function() {
                var arr = new Array();
                arr[0] = children[0].children;
                arr[2] = children[2].returnFlattenedChildren();
                if (arr[2].length) {
                    arr[1] = children[1];
                    _.each(arr[2], function(item) {
                        item.parent = node;
                    });
                }
                return _.flatten(arr);
            };


            $$ = node;

        }}
    |
        {{
            var node = new Node("type_id_comma_list", 2);
            
            node.print = function() {
                log("37) type_id_comma_list ::=");
                log();
            }

            node.returnFlattenedChildren = function() {
                return [];
            };

            $$ = node;

        }}
    ;








// CHECKED 1
var_decl_list
    : var_decl_list var_decl /* used left recursion to fix shift/reduce conflict! */
        {{
            var node = new Node("var_decl_list", 1);
            
            node.print = function() {
                log("38) var_decl_list ::= var_decl_list var_decl");
                log("                                     \\___ " + $var_decl.desc);
                log();
            }

            node.desc = $var_decl_list.desc + " " + $var_decl.desc;

            // CHILDREN
            var children = new Array();
            children[0] = $var_decl_list;
            children[0].parent = node;
            
            children[1] = $var_decl;
            children[1].parent = node;

            node.setChildren(children);

            node.returnFlattenedChildren = function() {
                var arr = new Array();
                arr[1] = children[1];
                arr[0] = children[0].returnFlattenedChildren();
                _.each(arr[0], function(item) {
                    item.parent = node;
                });
                return _.flatten(arr);
            };

            $$ = node;

        }}
    |
        {{
            var node = new Node("var_decl_list", 2);
            
            node.print = function() {
                log("39) var_decl_list ::=");
                log();
            }

            node.returnFlattenedChildren = function() {
                return [];
            }

            $$ = node;

        }}
    ;

// CHECKED 1
var_decl
    : type_id ';'
        {{
            var node = new Node("VARIABLE_DECLARATION", 1);
            
            node.print = function() {
                log("40) var_decl ::= type_id ';'");
                log("                  \\___ " + $type_id.desc);
                log();
            }

            node.desc = $type_id.desc + ";";

            // CHILDREN
            var children = new Array();
            children[0] = $type_id.children[0];
            children[0].parent = node;
            children[1] = $type_id.children[1];
            children[1].parent = node;
            children[2] = new Leaf("LITERAL", ";", node);

            node.setChildren(children);

            node.variableType = children[0].type;
            node.variableName = children[1].value;

            $$ = node;

        }}
    ;










// CHECKED 1 2
main_class
    : CLASS ID '{' PUBLIC STATIC VOID MAIN '(' STRING '[' ']' ID ')' '{' statement_list '}' '}'
        {{
            var node = new Node("MAIN_CLASS", 1);
            
            node.print = function() {
                log("41) main_class ::= CLASS ID '{' PUBLIC STATIC VOID MAIN '(' STRING '[' ']' ID ')' '{' statement_list '}' '}'");
                log("                          \\________________________________________________|___ " + $ID1)
                log("                                                                            \\__ " + $ID2)
                log();
            }

            node.desc = "Main class: " + $ID1;

            node.className = $ID1;


            // CHILDREN
            var children = new Array();
            children.push(new Leaf("LITERAL", "CLASS", node));
            children.push(new Leaf("ID", $ID1, node));
            children.push(new Leaf("LITERAL", "{", node));
            children.push(new Leaf("LITERAL", "PUBLIC", node));
            children.push(new Leaf("LITERAL", "STATIC", node));
            children.push(new Leaf("LITERAL", "VOID", node));
            children.push(new Leaf("LITERAL", "MAIN", node));
            children.push(new Leaf("LITERAL", "(", node));
            children.push(new Leaf("LITERAL", "STRING[]", node));
            children.push(new Leaf("ID", $ID2, node));
            children.push(new Leaf("LITERAL", ")", node));
            children.push(new Leaf("LITERAL", "{", node));
            if ($statement_list.rule_number == 1) {
                var statement = new Node("STATEMENT", 1, node);
                var statements = $statement_list.returnFlattenedChildren();
                _.each(statements, function(item) {
                    item.parent = statement;
                });
                statement.setChildren(statements);
                //log($statement_list.returnFlattenedChildren());
                children.push(statement);
            }
            children.push(new Leaf("LITERAL", "}", node));
            children.push(new Leaf("LITERAL", "}", node));

            node.setChildren(children);
            //log('---------statement');log(node);log('---------');log();

            

            // scope
            node.addVariableToScope = function(name, type, kind) {
                this.scope[name] = {"type": type, "kind": kind};
            }

            node.addVariableToScope($ID2, "String[]", "argument");
            node.addVariableToScope("this", "class", "class");

            $$ = node;
        }}
    ;









// CHECKED 1
class_decl_list
    : class_decl class_decl_list
        {{
            var node = new Node("class_decl_list", 1);
            
            node.print = function() {
                log("42) class_decl_list ::= class_decl class_decl_list");
                log();
            }

            node.desc = $class_decl.desc + " " + $class_decl_list.desc;

            // CHILDREN
            var children = new Array();
            children[0] = $class_decl;
            children[0].parent = node;
            
            children[1] = $class_decl_list;
            children[1].parent = node;

            node.setChildren(children);

            node.returnFlattenedChildren = function() {
                var arr = new Array();
                arr[0] = children[0];
                arr[1] = children[1].returnFlattenedChildren();
                _.each(arr[1], function(item) {
                    item.parent = node;
                });
                return _.flatten(arr);
            };

            $$ = node;

        }}
    |
        {{
            var node = new Node("class_decl_list", 2);
            
            node.print = function() {
                log("43) class_decl_list ::= ");
                log();
            }


            node.returnFlattenedChildren = function() {
                return [];
            };

            $$ = node;

        }}
    ;

// CHECKED 1
class_decl
    : CLASS ID class_extension_signature '{' var_decl_list method_decl_list '}'
        {{
            var node = new Node("CLASS_DECLARATION", 1);
            
            node.print = function() {
                log("44) class_decl ::= CLASS ID class_extension_signature '{' var_decl_list method_decl_list '}'");
                log("                          \\___ " + $ID);
                log();
            }

            node.desc = "Class: " + $ID;
            
            node.className = $ID;


            // CHILDREN
            var children = new Array();
            children.push(new Leaf("LITERAL", "CLASS", node));
            children.push(new Leaf("ID", $ID, node));
            if ($class_extension_signature.rule_number == 1) {
                children.push(new Leaf("LITERAL", "EXTENDS", node));
                children.push(new Leaf("ID", $class_extension_signature.extendedClassName, node));
            }
            children.push(new Leaf("LITERAL", "{", node));

            // scope
            node.addVariableToScope = function(name, type, kind) {
                var existing = this.searchForVariableInScope(name);
                if (existing.type) {
                    log("Sorry, " + $ID + "! A " + existing.kind + " with the same name (" + name + ") already exists!");
                } else {
                    this.scope[name] = {"type": type, "kind": kind};
                }
            }


            var declarations = $var_decl_list.returnFlattenedChildren();
            if (declarations && declarations.length) {
                _.each(declarations, function(item) {
                    item.parent = node;
                    children.push(item);
                    
                    // scope
                    node.addVariableToScope(item.variableName, item.variableType, "variable");
                });
            }
            
            var methods = $method_decl_list.returnFlattenedChildren();
            if (methods && methods.length) {
                _.each(methods, function(item) {
                    item.parent = node;
                    children.push(item);
                    
                    // scope
                    node.addVariableToScope(item.methodName, item.methodType, "method");
                });
            }
            
            children.push(new Leaf("LITERAL", "}", node));

            node.setChildren(children);
            //log('---------class_decl');log(node);log('---------');log();
            

            node.addVariableToScope("this", "class", "class");



            node.validate = function() {
                if ($class_extension_signature.rule_number == 1) { // it's been extended
                    var methods = $method_decl_list.returnFlattenedChildren();
                    if (methods && methods.length) {
                        _.each(methods, function(item) {
                            var father_class_name = $class_extension_signature.extendedClassName;
                            var father_class = rootNode.scope[father_class_name];
                            if (father_class) {
                                var overloaded_function = father_class.scope[item.methodName];
                                if (overloaded_function && overloaded_function.kind === "method") {
                                    log("Sorry, " + node.className + "! Your parent class (" + father_class_name + ") already has a method named " + item.methodName + "!");
                                }
                            }
                        });
                    }
                }
                return this.validateChildren();
            }

            $$ = node;

        }}
    ;


// CHECKED 1
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

            node.extendedClassName = $ID;

            $$ = node;

        }}
    |
        {{
            var node = new Node("class_extension_signature", 2);
            
            node.print = function() {
                log("46) class_extension_signature ::= ");
                log();
            }

            $$ = node;

        }}
    ;







// CHECKED 1
method_decl_list
    : method_decl method_decl_list
        {{
            var node = new Node("method_decl_list", 1);
            
            node.print = function() {
                log("47) method_decl_list ::= method_decl method_decl_list");
                log();
            }

            node.desc = $method_decl.desc + " " + $method_decl_list.desc;

            // CHILDREN
            var children = new Array();
            children[0] = $method_decl;
            children[0].parent = node;
            
            children[1] = $method_decl_list;
            children[1].parent = node;

            node.setChildren(children);

            node.returnFlattenedChildren = function() {
                var arr = new Array();
                arr[1] = children[0];
                arr[0] = children[1].returnFlattenedChildren();
                _.each(arr[0], function(item) {
                    item.parent = node;
                });
                return _.flatten(arr);
            };

            $$ = node;

        }}
    |
        {{
            var node = new Node("method_decl_list", 2);
            
            node.print = function() {
                log("48) method_decl_list ::= ");
                log();
            }

            node.returnFlattenedChildren = function() {
                return [];
            }

            $$ = node;

        }}
    ;


// CHECKED 1
method_decl
    : PUBLIC type_id '(' type_id_list ')' '{' var_decl_list statement_list RETURN expression ';' '}'
        {{
            var node = new Node("METHOD_DECLARATION", 1);
            
            node.print = function() {
                log("49) method_decl ::= PUBLIC type_id '(' type_id_list ')' '{' var_decl_list statement_list RETURN expression ';' '}'");
                log();
            }


            //scope
            node.addVariableToScope = function(name, type, kind) {
                this.scope[name] = {"type": type, "kind": kind};
            };

            node.desc = "public " + $type_id.desc + "(" + $type_id_list.desc + ") { " + $var_decl_list.desc + "   " + $statement_list.desc + "   return (" + $expression.desc + "; }";



            // CHILDREN
            var children = new Array();
            children.push(new Leaf("LITERAL", "PUBLIC", node));
            
            var type = $type_id.children[0];
            type.parent = node;
            children.push(type);

            var id = $type_id.children[1];
            id.parent = node;
            children.push(id);
            
            children.push(new Leaf("LITERAL", "(", node));
            
            var types = $type_id_list.returnFlattenedChildren();
            // log("\n\n\n");
            // log(types);
            // log("\n\n\n");

            var args_list = new Array();
            _.each(types, function(item) {
                item.parent = node;
                children.push(item);
                if (item.value !== ",")
                    args_list.push(item.value);
            });

            var i = 0;
            var args = [];
            _.each(args_list, function(item) {
                if (i%2 == 0) {
                    if (!args[i])
                        args[i] = {}
                    args[i].type = item;
                    i++;
                } else {
                    args[i-1].name = item;
                    i++;
                }
            });

            node.args = _.flatten(args);

            _.each(args, function(item) {
                node.addVariableToScope(item.name, item.type, "argument");
            });

            
            children.push(new Leaf("LITERAL", ")", node));
            
            children.push(new Leaf("LITERAL", "{", node));
            
            var variables = $var_decl_list.returnFlattenedChildren();
            _.each(variables, function(item) {
                item.parent = node;
                children.push(item);
                node.addVariableToScope(item.variableName, item.variableType, "variable");
            });
            
            var statements = $statement_list.returnFlattenedChildren();
            _.each(statements, function(item) {
                item.parent = node;
                children.push(item);
            });
            
            children.push(new Leaf("LITERAL", "RETURN", node));
            
            $expression.parent = node;
            children.push($expression);
            
            children.push(new Leaf("LITERAL", ";", node));
            
            children.push(new Leaf("LITERAL", "}", node));
            
            node.setChildren(children);


            // log("VAR_DECL: ");
            // log($var_decl_list.returnFlattenedChildren());
            // log("</EOF>\n\n");

            // log("---- type-id-list -----");
            // log($type_id_list.returnFlattenedChildren());
            // log("---- list-end -----\n\n");

            // log("-------------")
            // log($statement_list.returnFlattenedChildren());
            // log("-------------\n\n")
            
            // log("-------------")
            // log(node);
            // log("-------------\n\n")

            node.methodType = type.value;
            node.methodName = id.value;


            $$ = node;

        }}
    ;









