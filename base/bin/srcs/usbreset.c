#include <stdio.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/ioctl.h>
#include <linux/usbdevice_fs.h>

int main(int argc, char *argv[])
{
	int fd;
	int ret;
	char s[40];
	if ( argc == 3 ) {
		snprintf(s, 40, "/dev/bus/usb/%s/%s", argv[1], argv[2]);
		fd = open(s, 1);
		if ( fd >= 0 ) {
			printf("Resetting USB Bus %s Device %s\n", argv[1], argv[2]);
			ret = ioctl(fd, USBDEVFS_RESET, 0);
			close(fd);

			if ( ret >= 0 ) puts("Reset successful");
			else perror("Error in ioctl");
			return ret;
		} else {
			perror("Error opening output file");
			return 1;
		}
	} else {
		fprintf(stderr, "Usage: usbreset <bus> <device>\n");
		return 1;
	}
}
