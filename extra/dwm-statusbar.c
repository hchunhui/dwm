#include <X11/Xlib.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <unistd.h>
#include <sys/types.h>
#include <fcntl.h>

static Display *dpy;
static Window root;

void readdate(char *s)
{
	time_t t = time(NULL);

	strftime(s, 200,
		 "%a %m-%d %H:%M:%S %Z",
		 localtime(&t));
}

void readfile(char *s, char *fname)
{
	int fd;
	int l;

	s[0] = 0;

	fd = open(fname, O_RDONLY);
	if (fd < 0)
		return;

	l = read(fd, s, 200);
	if (l < 0)
		l = 0;

	s[l] = 0;

	for (; l >= 0; l--)
		if (s[l] == '\n') {
			s[l] = 0;
			break;
		}

	close(fd);
}

void setroot()
{
	char s1[200], s2[200], s3[200], s[200];

	readfile(s1, "/sys/class/power_supply/BAT0/status");
	readfile(s2, "/sys/class/power_supply/BAT0/capacity");
	readdate(s3);
	sprintf(s, "%s %s%% %s", s1, s2, s3);

	XStoreName(dpy, root, s);
	XFlush(dpy);
}

int main(int argc, char *argv[])
{
	dpy = XOpenDisplay(NULL);
	if (!dpy)
		exit(2);

	root = DefaultRootWindow(dpy);

	for (;;) {
		setroot();
		sleep(1);
	}

	XCloseDisplay(dpy);
	exit (0);
}
