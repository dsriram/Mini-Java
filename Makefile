all: compile run

compile: 
	coffee --bare --compile src/initialize.coffee
	
run:
	cd src && \
	coffee run-parser.coffee