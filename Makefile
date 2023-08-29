JDK := $(HOME)/opt/jdk-20

DEB := helloworld_1.0_amd64.deb
JAR := hello.jar

all : $(DEB)

clean :
	rm -f $(JAR)
	rm -f $(DEB)

$(JAR) : src/hello/Main.java
	@rm -f $@
	$(JDK)/bin/javac -d bin $<
	$(JDK)/bin/jar -cf $@ -C bin hello

$(DEB) : $(JAR)
	@rm -f $@
	$(JDK)/bin/jpackage \
		--name HelloWorld \
		--input . \
		--main-class hello.Main \
		--main-jar $(JAR)
