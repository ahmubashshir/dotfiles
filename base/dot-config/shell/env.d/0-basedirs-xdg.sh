#!/bin/zsh
if [ -z "$HOME" ]; then
	export HOME=~
fi
if [ -z "$XDG_CONFIG_HOME" ]; then
	export XDG_CONFIG_HOME="$HOME/.config"
fi
if [ -z "$XDG_DATA_HOME" ]; then
	export XDG_DATA_HOME="$HOME/.local/share"
fi
if [ -z "$XDG_CACHE_HOME" ];then
	export XDG_CACHE_HOME="$HOME/.cache"
fi
if [ -z "$XDG_STATE_HOME" ];then
	export XDG_STATE_HOME="$HOME/.local/state"
fi

# android sdk
export ANDROID_PREFS_ROOT="$XDG_CONFIG_HOME"/android
export ADB_KEYS_PATH="$ANDROID_PREFS_ROOT"
export ANDROID_EMULATOR_HOME="$XDG_DATA_HOME"/android/emulator
# ack
export ACKRC="$XDG_CONFIG_HOME/ack/ackrc"
# atom editor
export ATOM_HOME="$XDG_DATA_HOME"/atom
# ruby:bundler
export BUNDLE_USER_CONFIG="$XDG_CONFIG_HOME"/bundle
export BUNDLE_USER_CACHE="$XDG_CACHE_HOME"/bundle
export BUNDLE_USER_PLUGIN="$XDG_DATA_HOME"/bundle
# haskell:cabal
export CABAL_CONFIG="$XDG_CONFIG_HOME"/cabal/config
export CABAL_DIR="$XDG_CACHE_HOME"/cabal
# rust:cargo
export CARGO_HOME="$XDG_DATA_HOME"/cargo
# nvidia:cuda
export CUDA_CACHE_PATH="$XDG_CACHE_HOME"/nv
# docker
export DOCKER_CONFIG="$XDG_CONFIG_HOME"/docker
# elinks
export ELINKS_CONFDIR="$XDG_CONFIG_HOME"/elinks
# golang:go
export GOPATH="$XDG_DATA_HOME"/go
# hugo
export HUGO_CACHEDIR="$XDG_CACHE_HOME"/hugo
# java:gradle
export GRADLE_USER_HOME="$XDG_DATA_HOME"/gradle
export _JAVA_OPTIONS=-Djava.util.prefs.userRoot="$XDG_CONFIG_HOME"/java
# GTK 1,2
export GTK_RC_FILES="$XDG_CONFIG_HOME"/gtk-1.0/gtkrc
export GTK2_RC_FILES="$XDG_CONFIG_HOME"/gtk-2.0/gtkrc
# ruby:irb
export IRBRC="$XDG_CONFIG_HOME"/irb/irbrc
# mednafen
export MEDNAFEN_HOME="$XDG_CONFIG_HOME"/mednafen
# terminfo
export TERMINFO="$XDG_DATA_HOME"/terminfo
export TERMINFO_DIRS="$XDG_DATA_HOME"/terminfo:/usr/share/terminfo
# notmuch
export NOTMUCH_CONFIG="$XDG_CONFIG_HOME"/notmuch/notmuchrc
export NMBGIT="$XDG_DATA_HOME"/notmuch/nmbug
# node:npm
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME"/npm/npmrc
export NODE_REPL_HISTORY="$XDG_STATE_HOME"/node/history
export TS_NODE_HISTORY="$XDG_STATE_HOME"/node/ts.history

# opam
export OPAMROOT="$XDG_DATA_HOME/opam"
# parallel
export PARALLEL_HOME="$XDG_CONFIG_HOME"/parallel
# pass
export PASSWORD_STORE_DIR="$XDG_DATA_HOME"/pass
# ruby:rbenv
export RBENV_ROOT="$XDG_DATA_HOME"/rbenv
# rust:rustup
export RUSTUP_HOME="$XDG_DATA_HOME"/rustup
# gnu:screen
export SCREENRC="$XDG_CONFIG_HOME"/screen/screenrc
# haskell:stack
export STACK_ROOT="$XDG_DATA_HOME"/stack
# wakatime
export WAKATIME_HOME="$XDG_CONFIG_HOME/wakatime"
# Zoom
export SSB_HOME="$XDG_DATA_HOME"/zoom
# wget
export WGETRC="$XDG_CONFIG_HOME/wgetrc"
# less
export LESSHISTFILE="$XDG_STATE_HOME"/less/history
# libdvdcss
export DVDCSS_CACHE="$XDG_DATA_HOME"/dvdcss
# ICEauthority
export ICEAUTHORITY="$XDG_CACHE_HOME"/ICEauthority
# openssl:random-seed
export RANDFILE="$XDG_STATE_HOME/rnd"
# w3m
export W3M_DIR="$XDG_DATA_HOME"/w3m
# wine
export WINEPREFIX="$XDG_DATA_HOME"/wine
