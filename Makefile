GNATMAKE_ARGS=-s -gnat05 -gnatyO -gnatE -gnato -gnatv -gnati1 -gnatf -gnatn -fstack-check -gnatyO -m

APPLICATIONS=mean_and_variance
TEST_EXECUTABLES=test_betai test_coordinate_transformations test_floating_point_statistics test_students_t_test test_students_t_test_on_measurements test_surface_interpolation
EXECUTABLES=$(APPLICATIONS) $(TEST_EXECUTABLES)

all:
	gnatmake $(GNATMAKE_ARGS) -P build.gpr

install: all
	install --target=$(DESTDIR)/usr/local/bin $(APPLICATIONS)

clean:
	rm -f *.o *.ali

distclean: clean
	rm -f $(EXECUTABLES)

