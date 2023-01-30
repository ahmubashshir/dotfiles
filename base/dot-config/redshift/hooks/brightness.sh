#!/bin/bash
day=100
transition=50
night=0

exec >> ~/logs/redshift-hooks.log 2>&1
export PATH="$PATH:$HOME/.local/bin:$HOME/bin"

if [ "$1" = period-changed ]; then
	case $3 in
		night)
			setbl "$night" "$3"
			;;
		transition)
			setbl "$transition" "$3"
			;;
		daytime)
			setbl "$day" "$3"
			;;
		none)
			setbl "$transition" "$3"
			;;
	esac
fi
