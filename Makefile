GNATMAKE_ARGS=-s -gnat05 -gnatyO -gnatE -gnato -gnatv -gnati1 -gnatf -gnatn -fstack-check -gnatyO -m

all:
	gnatmake $(GNATMAKE_ARGS) test_betai
	gnatmake $(GNATMAKE_ARGS) test_coordinate_transformations

clean:
	rm -f *.o *.ali

distclean: clean
	rm -f test_betai
	rm -f test_coordinate_transformations
