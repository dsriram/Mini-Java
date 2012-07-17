fs          = require 'fs'
Parser      = (require 'jison').Parser

grammar = fs.readFileSync 'mini-java.jison', 'UTF8'

types = 
  'LL(1)'   : 'll'
  'LR(0)'   : 'lr0'
  'LR(1)'   : 'lr'
  'SLR(1)'  : 'slr'
  'LALR(1)' : 'lalr'


parser = new Parser grammar, {type:types['LALR(1)']}

parserSource = parser.generate()

parser.parse fs.readFileSync 'test-case.java', 'UTF8'