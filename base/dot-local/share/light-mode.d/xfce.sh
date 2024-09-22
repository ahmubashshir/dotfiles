#!/bin/sh
xfconf-query -c xsettings -p /Net/ThemeName     -s Matcha-sea
xfconf-query -c xsettings -p /Net/IconThemeName -s Papirus
(sleep 1 && xfce4-panel --plugin-event wcktitle-5:refresh) &
