CC=gcc
CFLAGS=-fPIC -Wall -g
RACKET=racket

lib: libomnibus

run: libomnibus omnibus-gui.rkt
	$(RACKET) omnibus-gui.rkt

libomnibus: libomnibus-0.1.so

libomnibus-0.1.so: wallpaper.o
	$(CC) -shared -o $@ $<
