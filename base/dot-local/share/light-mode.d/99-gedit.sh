#!/bin/sh
if ! gsettings describe \
	'org.gnome.gedit.preferences.editor' \
	'style-scheme-for-light-theme-variant' &> /dev/null
then
	gsettings set org.gnome.gedit.preferences.editor scheme '"icecream"'
else
	gsettings set org.gnome.gedit.preferences.editor 'style-scheme-for-light-theme-variant' '"icecream"'
fi
