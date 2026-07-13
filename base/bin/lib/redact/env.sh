#!/bin/bash

printLenEnv()
{
	[[ "$1" =~ ^[a-zA-Z_][a-zA-Z0-9_]*$ ]] || return # skip invalid variable names

	local -n var="$1"
	[[ -v "$1" && -n $var ]] || return # skip unset and empty values
	case "$2" in
		lower)
			printf '%d:%s=%s\n' "${#var}" "${!var,,}" "$var"
			;;
		upper)
			printf '%d:%s=%s\n' "${#var}" "${!var^^}" "$var"
			;;
		*)
			printf '%d:%s=%s\n' "${#var}" "${!var}" "$var"
			;;
	esac
}

dumpEnvMap()
{
	local var _
	while IFS='=' read -r var; do
		[[ "$var" == HOME || $var =~ ^XDG_.+_(HOME|DIR)$ ]] || continue
		printLenEnv "$var"
	done < <(compgen -e)

	for var in "$@" UID; do
		printLenEnv "$var"
	done

	for var in HOSTNAME USER; do
		printLenEnv "$var" lower
	done
}

addSedRules-env()
{
	local var val
	while IFS='=' read -r var val; do
		[[ -n $val ]] || continue # skip empty value
		RULES+=('s/(^|[^[:alnum:]])'"$(
			ERE2Literal "$val" | quoteSed
		)"'([^[:alnum:]]|$)/\1@'"$(
			quoteSed <<< "$var"
		)"'\2/g')
	done < <(
		# shellcheck disable=SC2154
		dumpEnvMap "${envs[@]}" | sort -t: -nr | while IFS=: read -r _ line; do
			printf '%s\n' "$line"
		done
	) # replace longest value first
}
