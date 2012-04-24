GNATMAKE_ARGS=-s -gnat05 -gnatyO -gnatE -gnato -gnatv -gnati1 -gnatf -gnatn -fstack-check -gnatyO -m

all:
	gnatmake $(GNATMAKE_ARGS) test_betai
	gnatmake $(GNATMAKE_ARGS) test_coordinate_transformations
	gnatmake $(GNATMAKE_ARGS) test_floating_point_statistics
	gnatmake $(GNATMAKE_ARGS) test_students_t_test
	gnatmake $(GNATMAKE_ARGS) test_students_t_test_on_measurements
	gnatmake $(GNATMAKE_ARGS) test_surface_interpolation

clean:
	rm -f *.o *.ali

distclean: clean
	rm -f test_betai
	rm -f test_coordinate_transformations
	rm -f test_floating_point_statistics
	rm -f test_students_t_test
	rm -f test_students_t_test_on_measurements
	rm -f test_surface_interpolation
