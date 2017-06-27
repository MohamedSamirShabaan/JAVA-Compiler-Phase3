all:
	flex ByteCodeGenerator.l
	bison -y -d ByteCodeGenerator.y
	g++ -std=c++11 lex.yy.c y.tab.c -o ByteCodeGeneratorOut.exe

check:
	./ByteCodeGeneratorOut.exe
run:
	java -jar jasmin.jar ByteCodeGeneratorOut.j
	#javap -s -verbose -c ByteCodeGenerator.class
	java ByteCodeGenerator

