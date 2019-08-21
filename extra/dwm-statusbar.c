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
	int cap;
	static int count, count2;

	readfile(s1, "/sys/class/power_supply/BAT0/status");
	readfile(s2, "/sys/class/power_supply/BAT0/capacity");
	readdate(s3);
	sprintf(s, "%s %s%% %s", s1, s2, s3);

	XStoreName(dpy, root, s);
	XFlush(dpy);

	sscanf(s2, "%d", &cap);
	readfile(s3, "/sys/class/power_supply/AC/online");

	if (count > 0)
		count--;
	if (count2 > 0)
		count2--;

	if (cap < 15 && s3[0] == '0' && count == 0) {
		sprintf(s, "notify-send -u critical 'Low Battery: %s%%'", s2);
		system(s);
		system("play /usr/share/sounds/freedesktop/stereo/dialog-warning.oga");
		count = 300;
	}

	if (cap < 5 && s3[0] == '0' && count2 == 0) {
		system("sudo systemctl hibernate");
		count2 = 60;
	}
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
