UNAME := $(shell uname)

INCLUDE_PATHS := -Ilibvterm-0.3.3/include
LIBRARY_PATHS := -Llibvterm-0.3.3/.libs

ifeq ($(UNAME), Darwin)
  INCLUDE_PATHS := ${INCLUDE_PATHS} -I/opt/homebrew/include
  LIBRARY_PATHS := ${LIBRARY_PATHS} -L/opt/homebrew/lib
  LIBVTERM := libvterm-0.3.3/.libs/libvterm.a
else
  LIBVTERM := -l:libvterm.a
endif

LINK := -lSDL2 -lSDL2_ttf -lSDL2_image ${LIBVTERM}
CFLAGS := -Wall -pedantic ${INCLUDE_PATHS} ${LIBRARY_PATHS} ${LINK} -O3 -flto

all:
	cc ./src/*.c -o./sdlterm ${CFLAGS}

debug:
	cc ./src/*.c -o./sdlterm ${CFLAGS} -ggdb -fsanitize=address,undefined

clean:
	rm -v sdlterm

install:
	cp -v ./sdlterm /usr/local/bin
