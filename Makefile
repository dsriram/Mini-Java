all: run

compile: src/mini-java.jison
	cd src && \
	jison mini-java.jison
	
run:
	cd src && \
	coffee run-parser.coffee