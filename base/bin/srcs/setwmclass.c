#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <X11/Xlib.h>
#include <X11/Xutil.h>

/**
 * Set the WM_CLASS property of a window specified by it's ID
 * Usage: set_wm_class <window id> <window class> <application name>
 * Compile with: gcc set_wm_class.c -lX11 -o set_wm_class
 * If you want to get the ID of the current window in 10 seconds, use \$(sleep 10; xdotool getactivewindow) as window id.
 * See https://tronche.com/gui/x/xlib/ICC/client-to-window-manager/wm-class.html for more information about what the WM_CLASS is good for.
 * Return codes: 1 - wrong argument count, 2 - could not parse window id, 4 - Could not allocate memory for the XCLassHint using XAllocClassHint()
 */

int main(int argc, char *argv[])
{
	unsigned long value;
	char *terminatedAt;
	XClassHint* class;
	Status status;
	Display *display;
	Window window;

	if ( argc != 4 ) {
		printf( "Usage: %s <window id> <window class> <application name>\n", argv[0] );
		return 1;
	}
	window = strtoul( argv[1], &terminatedAt, 0 );
	if ( *terminatedAt != '\0' ) {
		printf( "Could not parse window id: %s\n", argv[1] );
		return 2;
	}

	display = XOpenDisplay( NULL );

	class = XAllocClassHint();
	if (class == NULL) {
		printf("Probably out of memory\n");
		return 4;
	}
	class->res_class = strdup( argv[2] );
	class->res_name = strdup( argv[3] );
	XSetClassHint( display, window, class );

	XCloseDisplay( display );
	XFree( class->res_name );
	XFree( class->res_class );
	return 0;
}
