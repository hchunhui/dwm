CC = cc

all: dwm-statusbar

dwm-statusbar: dwm-statusbar.c
	${CC} -o $@ $< -lX11

clean:
	rm -f dwm-statusbar

install: all
	cp -f dwm-statusbar /usr/local/bin
	chmod 755 /usr/local/bin/dwm-statusbar

uninstall:
	rm -f /usr/local/bin/dwm-statusbar

.PHONY: all clean install uninstall
