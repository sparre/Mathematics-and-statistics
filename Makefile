APPLICATIONS=mean_and_variance
TEST_EXECUTABLES=test_betai test_coordinate_transformations test_floating_point_statistics test_students_t_test test_students_t_test_on_measurements test_surface_interpolation
EXECUTABLES=$(APPLICATIONS) $(TEST_EXECUTABLES)

all: whitespace-check
	gnatmake -P build.gpr

install: all
	install --target=$(DESTDIR)/usr/local/bin $(APPLICATIONS)

test:

clean:
	rm -f *.o *.ali

distclean: clean
	rm -f $(EXECUTABLES)

whitespace-check:
	@if find -name '*.ad?' | xargs egrep -l '	| $$' | egrep -v '(^|/)b([~]|__)'; then echo "Please remove tabs and end-of-line spaces from the source files listed above."; echo "You can do it by running:"; echo "   make -C '`pwd`' fix-whitespace"; false; fi

fix-whitespace:
	@   find -name '*.ad?' | xargs egrep -l '	| $$' | egrep -v '(^|/)b([~]|__)' | xargs --no-run-if-empty perl -i -lpe 's|	|        |g; s| +$$||g'

