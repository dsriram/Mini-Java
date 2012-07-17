/* Jison generated parser */
var miniJava = (function(){
var parser = {trace: function trace() { },
yy: {},
symbols_: {"error":2,"goal":3,"main_class":4,"class_decl_list":5,"EOF":6,"statement_list":7,"statement":8,"{":9,"}":10,"IF":11,"(":12,"expression":13,")":14,"ELSE":15,"WHILE":16,"SYSOUT":17,";":18,"ID":19,"=":20,"[":21,"]":22,"NOTHING":23,"expression_list":24,"expression_comma_list":25,",":26,"&":27,"<":28,"+":29,"-":30,"*":31,".":32,"LENGTH":33,"INTEGER_LETERAL":34,"TRUE":35,"FALSE":36,"THIS":37,"NEW":38,"INT":39,"!":40,"type":41,"BOOLEAN":42,"type_id":43,"type_id_list":44,"type_id_comma_list":45,"var_decl_list":46,"var_decl":47,"CLASS":48,"PUBLIC":49,"STATIC":50,"VOID":51,"MAIN":52,"STRING":53,"class_decl":54,"class_extension_signature":55,"method_decl_list":56,"EXTENDS":57,"method_decl":58,"RETURN":59,"$accept":0,"$end":1},
terminals_: {2:"error",6:"EOF",9:"{",10:"}",11:"IF",12:"(",14:")",15:"ELSE",16:"WHILE",17:"SYSOUT",18:";",19:"ID",20:"=",21:"[",22:"]",23:"NOTHING",26:",",27:"&",28:"<",29:"+",30:"-",31:"*",32:".",33:"LENGTH",34:"INTEGER_LETERAL",35:"TRUE",36:"FALSE",37:"THIS",38:"NEW",39:"INT",40:"!",42:"BOOLEAN",48:"CLASS",49:"PUBLIC",50:"STATIC",51:"VOID",52:"MAIN",53:"STRING",57:"EXTENDS",59:"RETURN"},
productions_: [0,[3,3],[7,2],[7,0],[8,3],[8,7],[8,5],[8,5],[8,4],[8,7],[8,1],[24,2],[24,0],[25,3],[25,0],[13,3],[13,3],[13,3],[13,3],[13,3],[13,4],[13,3],[13,6],[13,1],[13,1],[13,1],[13,1],[13,1],[13,5],[13,4],[13,2],[13,3],[41,3],[41,1],[41,1],[41,1],[43,2],[44,2],[44,0],[45,3],[45,0],[46,2],[46,0],[47,3],[4,17],[5,2],[5,0],[54,7],[55,2],[55,0],[56,2],[56,0],[58,13]],
performAction: function anonymous(yytext,yyleng,yylineno,yy,yystate,$$,_$) {

var $0 = $$.length - 1;
switch (yystate) {
}
},
table: [{3:1,4:2,48:[1,3]},{1:[3]},{5:4,6:[2,46],48:[1,6],54:5},{19:[1,7]},{6:[1,8]},{5:9,6:[2,46],48:[1,6],54:5},{19:[1,10]},{9:[1,11]},{1:[2,1]},{6:[2,45]},{9:[2,49],55:12,57:[1,13]},{49:[1,14]},{9:[1,15]},{19:[1,16]},{50:[1,17]},{10:[2,42],19:[1,23],39:[1,21],41:20,42:[1,22],46:18,47:19,49:[2,42]},{9:[2,48]},{51:[1,24]},{10:[2,51],49:[1,27],56:25,58:26},{9:[2,42],10:[2,42],11:[2,42],16:[2,42],17:[2,42],19:[1,23],23:[2,42],39:[1,21],41:20,42:[1,22],46:28,47:19,49:[2,42],59:[2,42]},{19:[1,29]},{19:[2,34],21:[1,30]},{19:[2,33]},{19:[2,35]},{52:[1,31]},{10:[1,32]},{10:[2,51],49:[1,27],56:33,58:26},{19:[1,23],39:[1,21],41:34,42:[1,22]},{9:[2,41],10:[2,41],11:[2,41],16:[2,41],17:[2,41],19:[2,41],23:[2,41],49:[2,41],59:[2,41]},{18:[1,35]},{22:[1,36]},{12:[1,37]},{6:[2,47],48:[2,47]},{10:[2,50]},{19:[1,38]},{9:[2,43],10:[2,43],11:[2,43],16:[2,43],17:[2,43],19:[2,43],23:[2,43],39:[2,43],42:[2,43],49:[2,43],59:[2,43]},{19:[2,32]},{53:[1,39]},{12:[1,40]},{21:[1,41]},{14:[2,38],19:[1,23],39:[1,21],41:44,42:[1,22],43:43,44:42},{22:[1,45]},{14:[1,46]},{14:[2,40],26:[1,48],45:47},{19:[1,49]},{19:[1,50]},{9:[1,51]},{14:[2,37]},{19:[1,23],39:[1,21],41:44,42:[1,22],43:52},{14:[2,36],26:[2,36]},{14:[1,53]},{9:[2,42],11:[2,42],16:[2,42],17:[2,42],19:[1,23],23:[2,42],39:[1,21],41:20,42:[1,22],46:54,47:19,59:[2,42]},{14:[2,40],26:[1,48],45:55},{9:[1,56]},{7:57,8:58,9:[1,59],11:[1,60],16:[1,61],17:[1,62],19:[1,63],23:[1,64],59:[2,3]},{14:[2,39]},{7:65,8:58,9:[1,59],10:[2,3],11:[1,60],16:[1,61],17:[1,62],19:[1,63],23:[1,64]},{59:[1,66]},{7:67,8:58,9:[1,59],10:[2,3],11:[1,60],16:[1,61],17:[1,62],19:[1,63],23:[1,64],59:[2,3]},{7:68,8:58,9:[1,59],10:[2,3],11:[1,60],16:[1,61],17:[1,62],19:[1,63],23:[1,64]},{12:[1,69]},{12:[1,70]},{12:[1,71]},{20:[1,72],21:[1,73]},{9:[2,10],10:[2,10],11:[2,10],15:[2,10],16:[2,10],17:[2,10],19:[2,10],23:[2,10],59:[2,10]},{10:[1,74]},{12:[1,83],13:75,19:[1,79],34:[1,76],35:[1,77],36:[1,78],37:[1,80],38:[1,81],40:[1,82]},{10:[2,2],59:[2,2]},{10:[1,84]},{12:[1,83],13:85,19:[1,79],34:[1,76],35:[1,77],36:[1,78],37:[1,80],38:[1,81],40:[1,82]},{12:[1,83],13:86,19:[1,79],34:[1,76],35:[1,77],36:[1,78],37:[1,80],38:[1,81],40:[1,82]},{12:[1,83],13:87,19:[1,79],34:[1,76],35:[1,77],36:[1,78],37:[1,80],38:[1,81],40:[1,82]},{12:[1,83],13:88,19:[1,79],34:[1,76],35:[1,77],36:[1,78],37:[1,80],38:[1,81],40:[1,82]},{12:[1,83],13:89,19:[1,79],34:[1,76],35:[1,77],36:[1,78],37:[1,80],38:[1,81],40:[1,82]},{10:[1,90]},{18:[1,91],21:[1,97],27:[1,92],28:[1,93],29:[1,94],30:[1,95],31:[1,96],32:[1,98]},{14:[2,23],18:[2,23],21:[2,23],22:[2,23],26:[2,23],27:[2,23],28:[2,23],29:[2,23],30:[2,23],31:[2,23],32:[2,23]},{14:[2,24],18:[2,24],21:[2,24],22:[2,24],26:[2,24],27:[2,24],28:[2,24],29:[2,24],30:[2,24],31:[2,24],32:[2,24]},{14:[2,25],18:[2,25],21:[2,25],22:[2,25],26:[2,25],27:[2,25],28:[2,25],29:[2,25],30:[2,25],31:[2,25],32:[2,25]},{14:[2,26],18:[2,26],21:[2,26],22:[2,26],26:[2,26],27:[2,26],28:[2,26],29:[2,26],30:[2,26],31:[2,26],32:[2,26]},{14:[2,27],18:[2,27],21:[2,27],22:[2,27],26:[2,27],27:[2,27],28:[2,27],29:[2,27],30:[2,27],31:[2,27],32:[2,27]},{19:[1,100],39:[1,99]},{12:[1,83],13:101,19:[1,79],34:[1,76],35:[1,77],36:[1,78],37:[1,80],38:[1,81],40:[1,82]},{12:[1,83],13:102,19:[1,79],34:[1,76],35:[1,77],36:[1,78],37:[1,80],38:[1,81],40:[1,82]},{9:[2,4],10:[2,4],11:[2,4],15:[2,4],16:[2,4],17:[2,4],19:[2,4],23:[2,4],59:[2,4]},{14:[1,103],21:[1,97],27:[1,92],28:[1,93],29:[1,94],30:[1,95],31:[1,96],32:[1,98]},{14:[1,104],21:[1,97],27:[1,92],28:[1,93],29:[1,94],30:[1,95],31:[1,96],32:[1,98]},{14:[1,105],21:[1,97],27:[1,92],28:[1,93],29:[1,94],30:[1,95],31:[1,96],32:[1,98]},{18:[1,106],21:[1,97],27:[1,92],28:[1,93],29:[1,94],30:[1,95],31:[1,96],32:[1,98]},{21:[1,97],22:[1,107],27:[1,92],28:[1,93],29:[1,94],30:[1,95],31:[1,96],32:[1,98]},{6:[2,44],48:[2,44]},{10:[1,108]},{12:[1,83],13:109,19:[1,79],34:[1,76],35:[1,77],36:[1,78],37:[1,80],38:[1,81],40:[1,82]},{12:[1,83],13:110,19:[1,79],34:[1,76],35:[1,77],36:[1,78],37:[1,80],38:[1,81],40:[1,82]},{12:[1,83],13:111,19:[1,79],34:[1,76],35:[1,77],36:[1,78],37:[1,80],38:[1,81],40:[1,82]},{12:[1,83],13:112,19:[1,79],34:[1,76],35:[1,77],36:[1,78],37:[1,80],38:[1,81],40:[1,82]},{12:[1,83],13:113,19:[1,79],34:[1,76],35:[1,77],36:[1,78],37:[1,80],38:[1,81],40:[1,82]},{12:[1,83],13:114,19:[1,79],34:[1,76],35:[1,77],36:[1,78],37:[1,80],38:[1,81],40:[1,82]},{19:[1,116],33:[1,115]},{21:[1,117]},{12:[1,118]},{14:[2,30],18:[2,30],21:[2,30],22:[2,30],26:[2,30],27:[1,92],28:[2,30],29:[2,30],30:[2,30],31:[2,30],32:[2,30]},{14:[1,119],21:[1,97],27:[1,92],28:[1,93],29:[1,94],30:[1,95],31:[1,96],32:[1,98]},{8:120,9:[1,59],11:[1,60],16:[1,61],17:[1,62],19:[1,63],23:[1,64]},{8:121,9:[1,59],11:[1,60],16:[1,61],17:[1,62],19:[1,63],23:[1,64]},{18:[1,122]},{9:[2,8],10:[2,8],11:[2,8],15:[2,8],16:[2,8],17:[2,8],19:[2,8],23:[2,8],59:[2,8]},{20:[1,123]},{10:[2,52],49:[2,52]},{14:[2,15],18:[2,15],21:[2,15],22:[2,15],26:[2,15],27:[1,92],28:[2,15],29:[2,15],30:[2,15],31:[2,15],32:[2,15]},{14:[2,16],18:[2,16],21:[1,97],22:[2,16],26:[2,16],27:[1,92],28:[2,16],29:[2,16],30:[2,16],31:[2,16],32:[1,98]},{14:[2,17],18:[2,17],21:[1,97],22:[2,17],26:[2,17],27:[1,92],28:[1,93],29:[2,17],30:[2,17],31:[1,96],32:[1,98]},{14:[2,18],18:[2,18],21:[1,97],22:[2,18],26:[2,18],27:[1,92],28:[1,93],29:[2,18],30:[2,18],31:[1,96],32:[1,98]},{14:[2,19],18:[2,19],21:[1,97],22:[2,19],26:[2,19],27:[1,92],28:[1,93],29:[2,19],30:[2,19],31:[2,19],32:[1,98]},{21:[1,97],22:[1,124],27:[1,92],28:[1,93],29:[1,94],30:[1,95],31:[1,96],32:[1,98]},{14:[2,21],18:[2,21],21:[2,21],22:[2,21],26:[2,21],27:[2,21],28:[2,21],29:[2,21],30:[2,21],31:[2,21],32:[2,21]},{12:[1,125]},{12:[1,83],13:126,19:[1,79],34:[1,76],35:[1,77],36:[1,78],37:[1,80],38:[1,81],40:[1,82]},{14:[1,127]},{14:[2,31],18:[2,31],21:[2,31],22:[2,31],26:[2,31],27:[2,31],28:[2,31],29:[2,31],30:[2,31],31:[2,31],32:[2,31]},{15:[1,128]},{9:[2,6],10:[2,6],11:[2,6],15:[2,6],16:[2,6],17:[2,6],19:[2,6],23:[2,6],59:[2,6]},{9:[2,7],10:[2,7],11:[2,7],15:[2,7],16:[2,7],17:[2,7],19:[2,7],23:[2,7],59:[2,7]},{12:[1,83],13:129,19:[1,79],34:[1,76],35:[1,77],36:[1,78],37:[1,80],38:[1,81],40:[1,82]},{14:[2,20],18:[2,20],21:[2,20],22:[2,20],26:[2,20],27:[2,20],28:[2,20],29:[2,20],30:[2,20],31:[2,20],32:[2,20]},{12:[1,83],13:131,14:[2,12],19:[1,79],24:130,34:[1,76],35:[1,77],36:[1,78],37:[1,80],38:[1,81],40:[1,82]},{21:[1,97],22:[1,132],27:[1,92],28:[1,93],29:[1,94],30:[1,95],31:[1,96],32:[1,98]},{14:[2,29],18:[2,29],21:[2,29],22:[2,29],26:[2,29],27:[2,29],28:[2,29],29:[2,29],30:[2,29],31:[2,29],32:[2,29]},{8:133,9:[1,59],11:[1,60],16:[1,61],17:[1,62],19:[1,63],23:[1,64]},{18:[1,134],21:[1,97],27:[1,92],28:[1,93],29:[1,94],30:[1,95],31:[1,96],32:[1,98]},{14:[1,135]},{14:[2,14],21:[1,97],25:136,26:[1,137],27:[1,92],28:[1,93],29:[1,94],30:[1,95],31:[1,96],32:[1,98]},{14:[2,28],18:[2,28],21:[2,28],22:[2,28],26:[2,28],27:[2,28],28:[2,28],29:[2,28],30:[2,28],31:[2,28],32:[2,28]},{9:[2,5],10:[2,5],11:[2,5],15:[2,5],16:[2,5],17:[2,5],19:[2,5],23:[2,5],59:[2,5]},{9:[2,9],10:[2,9],11:[2,9],15:[2,9],16:[2,9],17:[2,9],19:[2,9],23:[2,9],59:[2,9]},{14:[2,22],18:[2,22],21:[2,22],22:[2,22],26:[2,22],27:[2,22],28:[2,22],29:[2,22],30:[2,22],31:[2,22],32:[2,22]},{14:[2,11]},{12:[1,83],13:138,19:[1,79],34:[1,76],35:[1,77],36:[1,78],37:[1,80],38:[1,81],40:[1,82]},{14:[2,14],21:[1,97],25:139,26:[1,137],27:[1,92],28:[1,93],29:[1,94],30:[1,95],31:[1,96],32:[1,98]},{14:[2,13]}],
defaultActions: {8:[2,1],9:[2,45],16:[2,48],22:[2,33],23:[2,35],33:[2,50],36:[2,32],47:[2,37],55:[2,39],136:[2,11],139:[2,13]},
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
case 1:return 48
break;
case 2:return 57
break;
case 3:return 49
break;
case 4:return 50
break;
case 5:return 51
break;
case 6:return 52
break;
case 7:return 59
break;
case 8:return 37
break;
case 9:return 38
break;
case 10:return 33
break;
case 11:return 17
break;
case 12:return 11
break;
case 13:return 15
break;
case 14:return 16
break;
case 15:return 42
break;
case 16:return 39
break;
case 17:return 53
break;
case 18:return 35
break;
case 19:return 36
break;
case 20:return 23
break;
case 21:return 19
break;
case 22:return 34;
break;
case 23:return 9
break;
case 24:return 10
break;
case 25:return 12
break;
case 26:return 14
break;
case 27:return 21
break;
case 28:return 22
break;
case 29:return 18
break;
case 30:return 26
break;
case 31:return 32
break;
case 32:return 20
break;
case 33:return 28
break;
case 34:return 29
break;
case 35:return 30
break;
case 36:return 31
break;
case 37:return 27
break;
case 38:return 40
break;
case 39:return 6
break;
case 40:return 'INVALID'
break;
}
};
lexer.rules = [/^(?:\s+)/,/^(?:class\b)/,/^(?:extends\b)/,/^(?:public\b)/,/^(?:static\b)/,/^(?:void\b)/,/^(?:main\b)/,/^(?:return\b)/,/^(?:this\b)/,/^(?:new\b)/,/^(?:length\b)/,/^(?:System\.out\.println\b)/,/^(?:if\b)/,/^(?:else\b)/,/^(?:while\b)/,/^(?:boolean\b)/,/^(?:int\b)/,/^(?:String\b)/,/^(?:true\b)/,/^(?:false\b)/,/^(?:nothing\b)/,/^(?:([a-zA-Z][a-zA-Z0-9_]*))/,/^(?:([0-9])+)/,/^(?:\{)/,/^(?:\})/,/^(?:\()/,/^(?:\))/,/^(?:\[)/,/^(?:\])/,/^(?:;)/,/^(?:,)/,/^(?:\.)/,/^(?:=)/,/^(?:<)/,/^(?:\+)/,/^(?:-)/,/^(?:\*)/,/^(?:&&)/,/^(?:!)/,/^(?:$)/,/^(?:.)/];
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