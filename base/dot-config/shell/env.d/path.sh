#!/bin/sh
export PATH="$(
	path_unique << EOF
$HOME/.local/bin
$HOME/bin
$PERLHOME/bin
$XDG_DATA_HOME/cargo/bin
$XDG_DATA_HOME/go/bin
$PYENV_ROOT/bin
$PATH
/usr/lib/surfraw
$XDG_CONFIG_HOME/git/helpers
$XDG_CONFIG_HOME/git/helpers/extras
EOF
)"
