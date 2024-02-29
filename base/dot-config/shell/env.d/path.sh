#!/bin/sh
export PATH="$(
	mkpath()
	{
		tr -s ':' '\n' |
			awk '! a[$0]++ {
			line = line ((NR > 1)?":":"") $0
		} END {
			print line
		}'
	}

	cat << EOF | mkpath
$HOME/.local/bin
$HOME/bin
$XDG_DATA_HOME/cargo/bin
$XDG_DATA_HOME/go/bin
$PYENV_ROOT/bin
$PATH
/usr/lib/surfraw
$XDG_CONFIG_HOME/git/helpers
$XDG_CONFIG_HOME/git/helpers/extras
EOF
)"
