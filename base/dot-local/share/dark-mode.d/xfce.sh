#!/bin/sh
xfconf-query -c xsettings -p /Net/ThemeName     -s Matcha-dark-sea
xfconf-query -c xsettings -p /Net/IconThemeName -s Papirus-Dark
(sleep 1 && xfce4-panel --plugin-event wcktitle-5:refresh) &
