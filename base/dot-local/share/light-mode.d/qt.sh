#!/bin/sh
set --
kvantummanager --set Matchama
for v in 5 6; do
	test -f "${XDG_CONFIG_HOME:-$HOME/.config}/qt${v}ct/qt${v}ct.conf" || continue
	set -- "$@" "${XDG_CONFIG_HOME:-$HOME/.config}/qt${v}ct/qt${v}ct.conf"
done
sed -Ei '/^style=kvantum-dark$/s/-dark$//;/^icon_theme=Papirus-Dark$/s/-Dark$//' "$@"
