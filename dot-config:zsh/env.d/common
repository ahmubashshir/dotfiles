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
if systemctl is-active -q docker.socket && false;then
	export DOCKER_HOST="unix:///var$(systemctl cat docker.socket|awk -F = '/^ListenStream/{print $2;exit}')"
fi
