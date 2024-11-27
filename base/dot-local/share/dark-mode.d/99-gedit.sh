#!/bin/sh
if ! gsettings describe \
	'org.gnome.gedit.preferences.editor' \
	'style-scheme-for-dark-theme-variant' &> /dev/null
then
	gsettings set org.gnome.gedit.preferences.editor scheme '"dracula"'
else
	gsettings set org.gnome.gedit.preferences.editor 'style-scheme-for-dark-theme-variant' '"dracula"'
fi
