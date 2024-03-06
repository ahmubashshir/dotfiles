#!/bin/sh
export PATH="$(
	mkpath()
	{
		local pth= line=
		while read -r line; do
			case ":$pth:" in
				*":$line:"*) ;;
				*) ! test -d "$line" || pth="${pth:+$pth:}$line" ;;
			esac
		done
		echo "$pth"
	}

	tr : '\n' << EOF | mkpath
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
