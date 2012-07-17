
/* description: Parses end executes mathematical expressions. */

/* lexical grammar */
%lex

digit                 [0-9]
id                    [a-zA-Z][a-zA-Z0-9]*

%%


\s+                   /*return 'SEP'*/
"class"               return 'CLASS'
"var"                 return 'VAR'
{id}                  return 'ID'
"{"                   return '{'
"}"                   return '}'
";"                   return ';'
<<EOF>>               return 'EOF'
.                     return 'INVALID'

/lex

/* operator associations and precedence */

%start goal

%% /* language grammar */

goal
    : class EOF
        {console.log(":)");}
    ;

class
    : CLASS ID '{' var_list '}'
        {
            console.log($var_list)
        }
    ;

var_list
    : var_decl var_list 
        {
            $$ = new Array();
            $$[0] = $var_decl;
            if ($var_list)
                for (var i=0; i<$var_list.length; i++)
                    $$[i+1] = $var_list[i]
        }
    |
        {
            $$ = null;
        }
    ;


var_decl
    : VAR ID ';'
        {
            $$ = $ID;
            console.log("=====>"+$ID)
        }
    ;


















