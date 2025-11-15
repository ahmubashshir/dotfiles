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

if [ -z "$XDG_RUNTIME_DIR" ];then
	if [ -d "/run/user/$UID" ]
	then XDG_RUNTIME_DIR="/run/user/$UID"
	elif [ -n "$TMPDIR" ]
	then XDG_RUNTIME_DIR="$TMPDIR"
	else XDG_RUNTIME_DIR="/tmp/run/$UID"
	fi
	export XDG_RUNTIME_DIR
fi

# android sdk
export ADB_KEYS_PATH="$XDG_CONFIG_HOME"/android
export ANDROID_USER_HOME="$XDG_DATA_HOME"/android
export ANDROID_EMULATOR_HOME="$ANDROID_USER_HOME"/emulator
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
# cgdb
export CGDB_DIR="$XDG_CONFIG_HOME"/cgdb
# rust:cargo
export CARGO_HOME="$XDG_DATA_HOME"/cargo
# nvidia:cuda
export CUDA_CACHE_PATH="$XDG_CACHE_HOME"/nv
# darling
export DPREFIX="$XDG_DATA_HOME"/darling/prefix
# docker
export DOCKER_CONFIG="$XDG_CONFIG_HOME"/docker
# elinks
export ELINKS_CONFDIR="$XDG_CONFIG_HOME"/elinks
# golang:go
export GOPATH="$XDG_DATA_HOME"/go
export GOBIN="${XDG_DATA_HOME%/*}/bin"
# hugo
export HUGO_CACHEDIR="$XDG_CACHE_HOME"/hugo
# java:gradle
export GRADLE_USER_HOME="$XDG_DATA_HOME"/gradle
add_java_option "java.util.prefs.userRoot='$XDG_CONFIG_HOME/java'"
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
# perl:cpan
export PERLHOME="${XDG_DATA_HOME}/perl"
export PATH="$PERLHOME/bin${PATH:+:${PATH}}"
export PERL_CPANM_HOME="${XDG_CONFIG_HOME}/cpan"
export PERL5LIB="$PERL_CPANM_HOME:$PERLHOME/lib/perl5${PERL5LIB:+:${PERL5LIB}}"
export PERL_LOCAL_LIB_ROOT="$PERLHOME${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"
export PERL_MB_OPT="--install_base \"$PERLHOME\""
export PERL_MM_OPT="INSTALL_BASE=$PERLHOME"
# python:hist
export PYTHONSTARTUP="$XDG_CONFIG_HOME"/python/pythonrc
export PYTHON_HISTORY="$XDG_STATE_HOME"/python.history
# python:venv
export WORKON_HOME="$XDG_DATA_HOME/virtualenvs"
# ruby:rbenv
export RBENV_ROOT="$XDG_DATA_HOME"/rbenv
export RBENV_HOME="$XDG_DATA_HOME"/rbenv/rbenv
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
# sqlite:history
export SQLITE_HISTORY="$XDG_STATE_HOME"/sqlite.history
# openssl:random-seed
export RANDFILE="$XDG_STATE_HOME/rnd"
# vagrant
export VAGRANT_HOME="$XDG_DATA_HOME"/vagrant
# w3m
export W3M_DIR="$XDG_DATA_HOME"/w3m
# wine
export WINEPREFIX="$XDG_DATA_HOME"/wine
# renpy
export RENPY_PATH_TO_SAVES="$XDG_DATA_HOME"/renpy
