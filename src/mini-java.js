/* Jison generated parser */
var miniJava = (function(){
var parser = {trace: function trace() { },
yy: {},
symbols_: {"error":2,"goal":3,"main_class":4,"multiple_class_declarations":5,"EOF":6,"CLASS":7,"ID":8,"{":9,"PUBLIC":10,"STATIC":11,"VOID":12,"MAIN":13,"(":14,"STRING":15,"[":16,"]":17,")":18,"statement_list":19,"}":20,"statement":21,"IF":22,"expression":23,"ELSE":24,"WHILE":25,"SYSOUT":26,";":27,"=":28,"NOTHING":29,"bool_math":30,"&":31,"<":32,"+":33,"-":34,"*":35,"INTEGER_LETERAL":36,"TRUE":37,"FALSE":38,"THIS":39,"NEW":40,"INT":41,"!":42,"$accept":0,"$end":1},
terminals_: {2:"error",6:"EOF",7:"CLASS",8:"ID",9:"{",10:"PUBLIC",11:"STATIC",12:"VOID",13:"MAIN",14:"(",15:"STRING",16:"[",17:"]",18:")",20:"}",22:"IF",24:"ELSE",25:"WHILE",26:"SYSOUT",27:";",28:"=",29:"NOTHING",31:"&",32:"<",33:"+",34:"-",35:"*",36:"INTEGER_LETERAL",37:"TRUE",38:"FALSE",39:"THIS",40:"NEW",41:"INT",42:"!"},
productions_: [0,[3,3],[4,17],[19,2],[19,0],[21,3],[21,7],[21,5],[21,5],[21,4],[21,7],[21,1],[30,1],[30,1],[30,1],[30,1],[30,1],[23,0],[23,1],[23,1],[23,1],[23,1],[23,1],[23,5],[23,4],[23,2],[23,3],[5,0]],
performAction: function anonymous(yytext,yyleng,yylineno,yy,yystate,$$,_$) {

var $0 = $$.length - 1;
switch (yystate) {
}
},
table: [{3:1,4:2,7:[1,3]},{1:[3]},{5:4,6:[2,27]},{8:[1,5]},{6:[1,6]},{9:[1,7]},{1:[2,1]},{10:[1,8]},{11:[1,9]},{12:[1,10]},{13:[1,11]},{14:[1,12]},{15:[1,13]},{16:[1,14]},{17:[1,15]},{8:[1,16]},{18:[1,17]},{9:[1,18]},{8:[1,25],9:[1,21],19:19,20:[2,4],21:20,22:[1,22],25:[1,23],26:[1,24],29:[1,26]},{20:[1,27]},{8:[1,25],9:[1,21],19:28,20:[2,4],21:20,22:[1,22],25:[1,23],26:[1,24],29:[1,26]},{8:[1,25],9:[1,21],19:29,20:[2,4],21:20,22:[1,22],25:[1,23],26:[1,24],29:[1,26]},{14:[1,30]},{14:[1,31]},{14:[1,32]},{16:[1,34],28:[1,33]},{8:[2,11],9:[2,11],20:[2,11],22:[2,11],24:[2,11],25:[2,11],26:[2,11],29:[2,11]},{20:[1,35]},{20:[2,3]},{20:[1,36]},{8:[1,41],14:[1,45],18:[2,17],23:37,36:[1,38],37:[1,39],38:[1,40],39:[1,42],40:[1,43],42:[1,44]},{8:[1,41],14:[1,45],18:[2,17],23:46,36:[1,38],37:[1,39],38:[1,40],39:[1,42],40:[1,43],42:[1,44]},{8:[1,41],14:[1,45],18:[2,17],23:47,36:[1,38],37:[1,39],38:[1,40],39:[1,42],40:[1,43],42:[1,44]},{8:[1,41],14:[1,45],23:48,27:[2,17],36:[1,38],37:[1,39],38:[1,40],39:[1,42],40:[1,43],42:[1,44]},{8:[1,41],14:[1,45],17:[2,17],23:49,36:[1,38],37:[1,39],38:[1,40],39:[1,42],40:[1,43],42:[1,44]},{6:[2,2]},{8:[2,5],9:[2,5],20:[2,5],22:[2,5],24:[2,5],25:[2,5],26:[2,5],29:[2,5]},{18:[1,50]},{17:[2,18],18:[2,18],27:[2,18]},{17:[2,19],18:[2,19],27:[2,19]},{17:[2,20],18:[2,20],27:[2,20]},{17:[2,21],18:[2,21],27:[2,21]},{17:[2,22],18:[2,22],27:[2,22]},{8:[1,52],41:[1,51]},{8:[1,41],14:[1,45],17:[2,17],18:[2,17],23:53,27:[2,17],36:[1,38],37:[1,39],38:[1,40],39:[1,42],40:[1,43],42:[1,44]},{8:[1,41],14:[1,45],18:[2,17],23:54,36:[1,38],37:[1,39],38:[1,40],39:[1,42],40:[1,43],42:[1,44]},{18:[1,55]},{18:[1,56]},{27:[1,57]},{17:[1,58]},{8:[1,25],9:[1,21],21:59,22:[1,22],25:[1,23],26:[1,24],29:[1,26]},{16:[1,60]},{14:[1,61]},{17:[2,25],18:[2,25],27:[2,25]},{18:[1,62]},{8:[1,25],9:[1,21],21:63,22:[1,22],25:[1,23],26:[1,24],29:[1,26]},{27:[1,64]},{8:[2,9],9:[2,9],20:[2,9],22:[2,9],24:[2,9],25:[2,9],26:[2,9],29:[2,9]},{28:[1,65]},{24:[1,66]},{8:[1,41],14:[1,45],17:[2,17],23:67,36:[1,38],37:[1,39],38:[1,40],39:[1,42],40:[1,43],42:[1,44]},{18:[1,68]},{17:[2,26],18:[2,26],27:[2,26]},{8:[2,7],9:[2,7],20:[2,7],22:[2,7],24:[2,7],25:[2,7],26:[2,7],29:[2,7]},{8:[2,8],9:[2,8],20:[2,8],22:[2,8],24:[2,8],25:[2,8],26:[2,8],29:[2,8]},{8:[1,41],14:[1,45],23:69,27:[2,17],36:[1,38],37:[1,39],38:[1,40],39:[1,42],40:[1,43],42:[1,44]},{8:[1,25],9:[1,21],21:70,22:[1,22],25:[1,23],26:[1,24],29:[1,26]},{17:[1,71]},{17:[2,24],18:[2,24],27:[2,24]},{27:[1,72]},{8:[2,6],9:[2,6],20:[2,6],22:[2,6],24:[2,6],25:[2,6],26:[2,6],29:[2,6]},{17:[2,23],18:[2,23],27:[2,23]},{8:[2,10],9:[2,10],20:[2,10],22:[2,10],24:[2,10],25:[2,10],26:[2,10],29:[2,10]}],
defaultActions: {6:[2,1],28:[2,3],35:[2,2]},
parseError: function parseError(str, hash) {
    throw new Error(str);
},
parse: function parse(input) {
    var self = this, stack = [0], vstack = [null], lstack = [], table = this.table, yytext = "", yylineno = 0, yyleng = 0, recovering = 0, TERROR = 2, EOF = 1;
    this.lexer.setInput(input);
    this.lexer.yy = this.yy;
    this.yy.lexer = this.lexer;
    this.yy.parser = this;
    if (typeof this.lexer.yylloc == "undefined")
        this.lexer.yylloc = {};
    var yyloc = this.lexer.yylloc;
    lstack.push(yyloc);
    var ranges = this.lexer.options && this.lexer.options.ranges;
    if (typeof this.yy.parseError === "function")
        this.parseError = this.yy.parseError;
    function popStack(n) {
        stack.length = stack.length - 2 * n;
        vstack.length = vstack.length - n;
        lstack.length = lstack.length - n;
    }
    function lex() {
        var token;
        token = self.lexer.lex() || 1;
        if (typeof token !== "number") {
            token = self.symbols_[token] || token;
        }
        return token;
    }
    var symbol, preErrorSymbol, state, action, a, r, yyval = {}, p, len, newState, expected;
    while (true) {
        state = stack[stack.length - 1];
        if (this.defaultActions[state]) {
            action = this.defaultActions[state];
        } else {
            if (symbol === null || typeof symbol == "undefined") {
                symbol = lex();
            }
            action = table[state] && table[state][symbol];
        }
        if (typeof action === "undefined" || !action.length || !action[0]) {
            var errStr = "";
            if (!recovering) {
                expected = [];
                for (p in table[state])
                    if (this.terminals_[p] && p > 2) {
                        expected.push("'" + this.terminals_[p] + "'");
                    }
                if (this.lexer.showPosition) {
                    errStr = "Parse error on line " + (yylineno + 1) + ":\n" + this.lexer.showPosition() + "\nExpecting " + expected.join(", ") + ", got '" + (this.terminals_[symbol] || symbol) + "'";
                } else {
                    errStr = "Parse error on line " + (yylineno + 1) + ": Unexpected " + (symbol == 1?"end of input":"'" + (this.terminals_[symbol] || symbol) + "'");
                }
                this.parseError(errStr, {text: this.lexer.match, token: this.terminals_[symbol] || symbol, line: this.lexer.yylineno, loc: yyloc, expected: expected});
            }
        }
        if (action[0] instanceof Array && action.length > 1) {
            throw new Error("Parse Error: multiple actions possible at state: " + state + ", token: " + symbol);
        }
        switch (action[0]) {
        case 1:
            stack.push(symbol);
            vstack.push(this.lexer.yytext);
            lstack.push(this.lexer.yylloc);
            stack.push(action[1]);
            symbol = null;
            if (!preErrorSymbol) {
                yyleng = this.lexer.yyleng;
                yytext = this.lexer.yytext;
                yylineno = this.lexer.yylineno;
                yyloc = this.lexer.yylloc;
                if (recovering > 0)
                    recovering--;
            } else {
                symbol = preErrorSymbol;
                preErrorSymbol = null;
            }
            break;
        case 2:
            len = this.productions_[action[1]][1];
            yyval.$ = vstack[vstack.length - len];
            yyval._$ = {first_line: lstack[lstack.length - (len || 1)].first_line, last_line: lstack[lstack.length - 1].last_line, first_column: lstack[lstack.length - (len || 1)].first_column, last_column: lstack[lstack.length - 1].last_column};
            if (ranges) {
                yyval._$.range = [lstack[lstack.length - (len || 1)].range[0], lstack[lstack.length - 1].range[1]];
            }
            r = this.performAction.call(yyval, yytext, yyleng, yylineno, this.yy, action[1], vstack, lstack);
            if (typeof r !== "undefined") {
                return r;
            }
            if (len) {
                stack = stack.slice(0, -1 * len * 2);
                vstack = vstack.slice(0, -1 * len);
                lstack = lstack.slice(0, -1 * len);
            }
            stack.push(this.productions_[action[1]][0]);
            vstack.push(yyval.$);
            lstack.push(yyval._$);
            newState = table[stack[stack.length - 2]][stack[stack.length - 1]];
            stack.push(newState);
            break;
        case 3:
            return true;
        }
    }
    return true;
}
};
/* Jison generated lexer */
var lexer = (function(){
var lexer = ({EOF:1,
parseError:function parseError(str, hash) {
        if (this.yy.parser) {
            this.yy.parser.parseError(str, hash);
        } else {
            throw new Error(str);
        }
    },
setInput:function (input) {
        this._input = input;
        this._more = this._less = this.done = false;
        this.yylineno = this.yyleng = 0;
        this.yytext = this.matched = this.match = '';
        this.conditionStack = ['INITIAL'];
        this.yylloc = {first_line:1,first_column:0,last_line:1,last_column:0};
        if (this.options.ranges) this.yylloc.range = [0,0];
        this.offset = 0;
        return this;
    },
input:function () {
        var ch = this._input[0];
        this.yytext += ch;
        this.yyleng++;
        this.offset++;
        this.match += ch;
        this.matched += ch;
        var lines = ch.match(/(?:\r\n?|\n).*/g);
        if (lines) {
            this.yylineno++;
            this.yylloc.last_line++;
        } else {
            this.yylloc.last_column++;
        }
        if (this.options.ranges) this.yylloc.range[1]++;

        this._input = this._input.slice(1);
        return ch;
    },
unput:function (ch) {
        var len = ch.length;
        var lines = ch.split(/(?:\r\n?|\n)/g);

        this._input = ch + this._input;
        this.yytext = this.yytext.substr(0, this.yytext.length-len-1);
        //this.yyleng -= len;
        this.offset -= len;
        var oldLines = this.match.split(/(?:\r\n?|\n)/g);
        this.match = this.match.substr(0, this.match.length-1);
        this.matched = this.matched.substr(0, this.matched.length-1);

        if (lines.length-1) this.yylineno -= lines.length-1;
        var r = this.yylloc.range;

        this.yylloc = {first_line: this.yylloc.first_line,
          last_line: this.yylineno+1,
          first_column: this.yylloc.first_column,
          last_column: lines ?
              (lines.length === oldLines.length ? this.yylloc.first_column : 0) + oldLines[oldLines.length - lines.length].length - lines[0].length:
              this.yylloc.first_column - len
          };

        if (this.options.ranges) {
            this.yylloc.range = [r[0], r[0] + this.yyleng - len];
        }
        return this;
    },
more:function () {
        this._more = true;
        return this;
    },
less:function (n) {
        this.unput(this.match.slice(n));
    },
pastInput:function () {
        var past = this.matched.substr(0, this.matched.length - this.match.length);
        return (past.length > 20 ? '...':'') + past.substr(-20).replace(/\n/g, "");
    },
upcomingInput:function () {
        var next = this.match;
        if (next.length < 20) {
            next += this._input.substr(0, 20-next.length);
        }
        return (next.substr(0,20)+(next.length > 20 ? '...':'')).replace(/\n/g, "");
    },
showPosition:function () {
        var pre = this.pastInput();
        var c = new Array(pre.length + 1).join("-");
        return pre + this.upcomingInput() + "\n" + c+"^";
    },
next:function () {
        if (this.done) {
            return this.EOF;
        }
        if (!this._input) this.done = true;

        var token,
            match,
            tempMatch,
            index,
            col,
            lines;
        if (!this._more) {
            this.yytext = '';
            this.match = '';
        }
        var rules = this._currentRules();
        for (var i=0;i < rules.length; i++) {
            tempMatch = this._input.match(this.rules[rules[i]]);
            if (tempMatch && (!match || tempMatch[0].length > match[0].length)) {
                match = tempMatch;
                index = i;
                if (!this.options.flex) break;
            }
        }
        if (match) {
            lines = match[0].match(/(?:\r\n?|\n).*/g);
            if (lines) this.yylineno += lines.length;
            this.yylloc = {first_line: this.yylloc.last_line,
                           last_line: this.yylineno+1,
                           first_column: this.yylloc.last_column,
                           last_column: lines ? lines[lines.length-1].length-lines[lines.length-1].match(/\r?\n?/)[0].length : this.yylloc.last_column + match[0].length};
            this.yytext += match[0];
            this.match += match[0];
            this.matches = match;
            this.yyleng = this.yytext.length;
            if (this.options.ranges) {
                this.yylloc.range = [this.offset, this.offset += this.yyleng];
            }
            this._more = false;
            this._input = this._input.slice(match[0].length);
            this.matched += match[0];
            token = this.performAction.call(this, this.yy, this, rules[index],this.conditionStack[this.conditionStack.length-1]);
            if (this.done && this._input) this.done = false;
            if (token) return token;
            else return;
        }
        if (this._input === "") {
            return this.EOF;
        } else {
            return this.parseError('Lexical error on line '+(this.yylineno+1)+'. Unrecognized text.\n'+this.showPosition(),
                    {text: "", token: null, line: this.yylineno});
        }
    },
lex:function lex() {
        var r = this.next();
        if (typeof r !== 'undefined') {
            return r;
        } else {
            return this.lex();
        }
    },
begin:function begin(condition) {
        this.conditionStack.push(condition);
    },
popState:function popState() {
        return this.conditionStack.pop();
    },
_currentRules:function _currentRules() {
        return this.conditions[this.conditionStack[this.conditionStack.length-1]].rules;
    },
topState:function () {
        return this.conditionStack[this.conditionStack.length-2];
    },
pushState:function begin(condition) {
        this.begin(condition);
    }});
lexer.options = {};
lexer.performAction = function anonymous(yy,yy_,$avoiding_name_collisions,YY_START) {

var YYSTATE=YY_START
switch($avoiding_name_collisions) {
case 0:/* skip whitespaces */
break;
case 1:return 7
break;
case 2:return 'EXTENDS'
break;
case 3:return 10
break;
case 4:return 11
break;
case 5:return 12
break;
case 6:return 13
break;
case 7:return 'RETURN'
break;
case 8:return 39
break;
case 9:return 40
break;
case 10:return 'LENGTH'
break;
case 11:return 26
break;
case 12:return 22
break;
case 13:return 24
break;
case 14:return 25
break;
case 15:return 'BOOLEAN'
break;
case 16:return 41
break;
case 17:return 15
break;
case 18:return 37
break;
case 19:return 38
break;
case 20:return 29
break;
case 21:return 8
break;
case 22:return 36;
break;
case 23:return 9
break;
case 24:return 20
break;
case 25:return 14
break;
case 26:return 18
break;
case 27:return 16
break;
case 28:return 17
break;
case 29:return 27
break;
case 30:return ','
break;
case 31:return '.'
break;
case 32:return 28
break;
case 33:return 32
break;
case 34:return 33
break;
case 35:return 34
break;
case 36:return 35
break;
case 37:return 31
break;
case 38:return 42
break;
case 39:return 6
break;
case 40:return 'INVALID'
break;
}
};
lexer.rules = [/^(?:\s+)/,/^(?:class\b)/,/^(?:extends\b)/,/^(?:public\b)/,/^(?:static\b)/,/^(?:void\b)/,/^(?:main\b)/,/^(?:return\b)/,/^(?:this\b)/,/^(?:new\b)/,/^(?:length\b)/,/^(?:System\.out\.println\b)/,/^(?:if\b)/,/^(?:else\b)/,/^(?:while\b)/,/^(?:boolean\b)/,/^(?:int\b)/,/^(?:String\b)/,/^(?:true\b)/,/^(?:false\b)/,/^(?:nothing\b)/,/^(?:([a-zA-Z][a-zA-Z0-9]*))/,/^(?:([0-9])+)/,/^(?:\{)/,/^(?:\})/,/^(?:\()/,/^(?:\))/,/^(?:\[)/,/^(?:\])/,/^(?:;)/,/^(?:,)/,/^(?:\.)/,/^(?:=)/,/^(?:<)/,/^(?:\+)/,/^(?:-)/,/^(?:\*)/,/^(?:&&)/,/^(?:!)/,/^(?:$)/,/^(?:.)/];
lexer.conditions = {"INITIAL":{"rules":[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40],"inclusive":true}};
return lexer;})()
parser.lexer = lexer;function Parser () { this.yy = {}; }Parser.prototype = parser;parser.Parser = Parser;
return new Parser;
})();
if (typeof require !== 'undefined' && typeof exports !== 'undefined') {
exports.parser = miniJava;
exports.Parser = miniJava.Parser;
exports.parse = function () { return miniJava.parse.apply(miniJava, arguments); }
exports.main = function commonjsMain(args) {
    if (!args[1])
        throw new Error('Usage: '+args[0]+' FILE');
    var source, cwd;
    if (typeof process !== 'undefined') {
        source = require('fs').readFileSync(require('path').resolve(args[1]), "utf8");
    } else {
        source = require("file").path(require("file").cwd()).join(args[1]).read({charset: "utf-8"});
    }
    return exports.parser.parse(source);
}
if (typeof module !== 'undefined' && require.main === module) {
  exports.main(typeof process !== 'undefined' ? process.argv.slice(1) : require("system").args);
}
}