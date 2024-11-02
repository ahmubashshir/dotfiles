#!/bin/sh

case "$XDG_SESSION_TYPE" in
	x11 | wayland) ;;
	*) return ;;
esac

export BROWSER=firefox
if [ "${DESKTOP_SESSION:-${XDG_SESSION_DESKTOP}}" != "plasma" ]; then
	export QT_QPA_PLATFORMTHEME=qt5ct:qt6ct
#	export QT_SCALE_FACTOR=1
fi

#export ENABLE_VKBASALT=1
export MANGOHUD=1
#export mesa_glthread=true
#export MESA_LOADER_DRIVER_OVERRIDE=zink

#export DXVK_LOG_LEVEL=error
export WINEDEBUG=-all
export WINEESYNC=1
export WINEFSYNC=1
if [ -z "$WINEARCH" ]; then
	export WINEARCH=win64
fi
if [ -d /mnt/Games/wine ]; then
	export WINEPREFIX=/mnt/Games/wine
fi
#export GTK_THEME=Matcha-dark-sea
export MEDIA_PLAYER=pipe-viewer
