all:
	make -C dwm
	make -C dmenu
	make -C extra
	make -C st
install:
	make -C dwm install
	make -C dmenu install
	make -C extra install
	make -C st install
clean:
	make -C dwm clean
	make -C dmenu clean
	make -C extra clean
	make -C st clean
