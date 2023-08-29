JAR := hello.jar

ifneq (,$(findstring Windows,$(OS)))
  IMG  := HelloWorld-1.0.msi
  JDK  := C:/jdk/ibm-semeru-open-jdk-20.0.2+9-openj9-0.40.0
  TYPE := msi
else
  IMG  := helloworld_1.0_amd64.deb
  JDK  := $(HOME)/opt/jdk-20
  TYPE := deb
endif

all : $(IMG)

clean :
	rm -f $(JAR)
	rm -f $(IMG)

$(JAR) : src/hello/Main.java
	@rm -f $@
	$(JDK)/bin/javac -d bin $<
	$(JDK)/bin/jar -cf $@ -C bin hello

$(IMG) : $(JAR)
	@rm -f $@
	$(JDK)/bin/jpackage \
		--name HelloWorld \
		--type $(TYPE) \
		--input . \
		--main-class hello.Main \
		--main-jar $(JAR)
