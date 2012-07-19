fs          = require 'fs'
Parser      = (require 'jison').Parser

grammar = fs.readFileSync 'mini-java.jison', 'UTF8'
grammar = grammar.replace 'INCLUDE("node");', (fs.readFileSync 'node.js', 'UTF8')
grammar = grammar.replace 'INCLUDE("underscore");', (fs.readFileSync 'helpers/underscore.js', 'UTF8')

types = 
  'LL(1)'   : 'll'
  'LR(0)'   : 'lr0'
  'LR(1)'   : 'lr'
  'SLR(1)'  : 'slr'
  'LALR(1)' : 'lalr'


parser = new Parser grammar, {type:types['LALR(1)']}

parserSource = parser.generate()

asd = parser.parse '.' + (fs.readFileSync '../test/test1.java', 'UTF8')

console.log asd