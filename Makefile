all: compile run

compile: 
	coffee --bare --compile src/node.coffee
	cp src/helpers/underscore.js public/scripts/underscore.js
	cp src/node.js public/scripts/node.js
	cp src/mini-java.jison public/mini-java.jison
	
run:
	cd src && \
	coffee run-parser.coffee