#!/bin/zsh
#export CORS_PROXY="https://calm-everglades-31879.herokuapp.com/"
export CORS_PROXY="https://cors.eu.org/"
#export PUPPETEER_PROXY='https://pumpkin-cake-35757.herokuapp.com/'
unset PUPPETEER_PROXY
export LNDIR="/mnt/Books/LightNovels"
export EDITOR=nano
export LESS='-FgiJRMSx4$z-4$~'
export GPGID=56DB0538F60D951C
export GPGFP=916961EE198832DD70B628B356DB0538F60D951C
export MEDIA_PLAYER=mpv-buffered
export GPG_TTY="${TTY:-$(tty)}"
export WINETRICKS_DOWNLOADER=curl
export DOCKER_HOST="unix://$XDG_RUNTIME_DIR/podman/podman.sock"

if command -pv systemctl && systemctl is-system-running -q && systemctl is-active -q docker.socket;then
	export DOCKER_HOST="unix:///var$(systemctl cat docker.socket|awk -F = '/^ListenStream/{print $2;exit}')"
fi 2> /dev/null >&2
