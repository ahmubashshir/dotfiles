#!/bin/sh
xfconf-query -c xsettings -p /Net/ThemeName     -s Matcha-light-sea
xfconf-query -c xsettings -p /Net/IconThemeName -s Papirus
xfconf-query -c xsettings -p /Gtk/CursorThemeName -s Fluent-cursors
! test -f ~/.config/backdrops/day || ~/bin/xfce4-setbg ~/.config/backdrops/day

~/bin/xfce4-wck-refresh &
