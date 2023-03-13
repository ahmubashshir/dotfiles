#!/bin/zsh
export PATH="$(
	mkpath () {
		tr -s ':' '\n' \
		| awk '!a[$0]++ {if(NR > 1) printf ":"; printf "%s", $0} END{print ""}'
	}

	cat <<EOF | mkpath
$HOME/.local/bin
$HOME/bin
$XDG_DATA_HOME/cargo/bin
$XDG_DATA_HOME/go/bin
$PATH
/usr/lib/surfraw
$XDG_CONFIG_HOME/git/helpers
$XDG_CONFIG_HOME/git/helpers/extras/bin
EOF
)"
