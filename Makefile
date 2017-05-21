all:
	make -C dwm
	make -C dmenu
	make -C extra
install:
	make -C dwm install
	make -C dmenu install
	make -C extra install
clean:
	make -C dwm clean
	make -C dmenu clean
	make -C extra clean
