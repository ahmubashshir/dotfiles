#!/bin/sh
if test $# -lt 2; then
	printf '%s\n' \
		"is.gd usage:" \
		"  is.gd <copy|cat> <link>"
	exit
fi
url=$(curl --disable -s "https://is.gd/create.php?format=simple&url=$2")
if echo "$url" | grep -q '://is\.gd/'; then
	echo -n "$url" | case $1 in
		copy)
			xclip -selection clipboard
			notify-send -a is.gd -i link "LinkShrink" "Shortened to: $url"
			;;
		*)
			cat
			echo
			;;
	esac
fi
# vim: ts=4:ft=sh:et
