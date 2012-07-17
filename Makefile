all: compile run

compile: src/mini-java.jison
	cd src && \
	jison mini-java.jison
	
run:
	cd src && \
	node mini-java.js test-case