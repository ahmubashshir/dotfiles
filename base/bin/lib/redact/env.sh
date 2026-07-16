#!/bin/bash
declare -g envs=()

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
	local var val lterm rterm
	while IFS='=' read -r var val; do
		lterm='^[:alnum:]'
		rterm='^[:alnum:]'
		[[ -n $val ]] || continue # skip empty value

		# terminal classes for generated sed rule
		case "${val:0:1}" in
			(/) rterm=':/';; # abspath
			([[:digit:]]) rterm='^[:digit:]'; lterm='^[:digit:]';; # numeric values
			([[:alpha:]]) rterm='^[:alpha:]'; lterm='^[:alpha:]';; # alphabetic values
		esac

		RULES+=('s/(^|['"$lterm"'])'"${
			ERE2Literal "$val" | quoteSed pattern
		}"'(['"$rterm"']|$)/\1@'"${
			quoteSed <<< "$var"
		}"'\2/g')

	done < <(
		# shellcheck disable=SC2154
		dumpEnvMap "${envs[@]}" | dSortStripPrio
	) # replace longest value first
}

redactEnv()
{
	if [[ "$1" =~ ^[a-zA-Z_][a-zA-Z0-9_]*$ ]]; then
		envs+=("$1")
		return 0
	fi

	return 1
}
