GNATMAKE_ARGS=-s -gnat05 -gnatyO -gnatE -gnato -gnatv -gnati1 -gnatf -gnatn -fstack-check -gnatyO -m

all:
	gnatmake $(GNATMAKE_ARGS) test_betai

clean:
	rm -f *.o *.ali

distclean: clean
	rm -f test_betai
