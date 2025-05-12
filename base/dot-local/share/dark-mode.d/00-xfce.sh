#!/bin/sh
xfconf-query -c xsettings -p /Net/ThemeName     -s Matcha-dark-sea
xfconf-query -c xsettings -p /Net/IconThemeName -s Papirus-Dark
xfconf-query -c xsettings -p /Gtk/CursorThemeName -s Fluent-dark-cursors
! test -f ~/.config/backdrops/night || xfce4-setbg ~/.config/backdrops/night

sh -c 'sleep 1 && xfce4-panel --plugin-event wcktitle-5:refresh' &
