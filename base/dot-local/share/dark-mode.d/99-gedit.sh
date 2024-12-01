#!/bin/sh
if ! gsettings describe 'org.gnome.gedit.preferences.ui' 'theme-variant' > /dev/null 2>&1; then
	set -- org.gnome.gedit.preferences.editor scheme dracula
else
	set -- org.gnome.gedit.preferences.ui theme-variant dark
fi

exec gsettings set "$@"
