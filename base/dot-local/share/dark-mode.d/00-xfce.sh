#!/bin/sh
xfconf-query -c xsettings -p /Net/ThemeName     -s Matcha-dark-sea
xfconf-query -c xsettings -p /Net/IconThemeName -s Papirus-Dark
xfconf-query -c xsettings -p /Gtk/CursorThemeName -s Fluent-dark-cursors
! test -f ~/.config/backdrops/night || ~/bin/xfce4-setbg ~/.config/backdrops/night

~/bin/xfce4-wck-refresh &!
