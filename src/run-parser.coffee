fs          = require 'fs'
Parser      = (require 'jison').Parser

grammar = fs.readFileSync 'mini-java.jison', 'UTF8'

parser = new Parser grammar, {type:'lalr'}

parserSource = parser.generate()

parser.parse fs.readFileSync 'test-case', 'UTF8'