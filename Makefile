all: compile run

compile: 
	coffee --bare --compile src/node.coffee
	
run:
	cd src && \
	coffee run-parser.coffee