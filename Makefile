###############################################################################
#
# "FastLZ" compression library
#
###############################################################################

CFILES = coffeecatch.c

all: gcc test

clean:
	rm -f *.o *.obj *.so* *.dylib *.dll *.exe *.pdb *.exp *.lib sample

tar:
	rm -f coffeecatch.tgz
	tar cvfz coffeecatch.tgz coffeecatch.txt coffeecatch.c coffeecatch.h Makefile LICENSE README.md

gcc:
	gcc -c -fPIC -O3 -g3 -pthread \
		-W -Wall -Wextra -Werror -Wno-unused-function \
		-D_REENTRANT -D_GNU_SOURCE \
		$(CFILES)
	gcc -shared -fPIC -O3  \
		-rdynamic -shared \
		coffeecatch.o -o libcoffeecatch.dylib \
		-ldl -lpthread

test:
	gcc -c -fPIC -O3 -g3 \
		-W -Wall -Wextra -Werror -Wno-unused-function \
		-D_REENTRANT \
		sample.c -o sample.o
	gcc -fPIC -O3 \
		-lcoffeecatch -L. \
		sample.o -o sample

