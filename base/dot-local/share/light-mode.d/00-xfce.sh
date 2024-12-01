#!/bin/sh
xfconf-query -c xsettings -p /Net/ThemeName     -s Matcha-light-sea
xfconf-query -c xsettings -p /Net/IconThemeName -s Papirus
sh -c 'sleep 1 && xfce4-panel --plugin-event wcktitle-5:refresh' &
