#!/bin/bash
declare -gra  HASH=(sha512 sha384 sha256 sha224 sha1 md5)
declare -grai HLEN=(128 96 64 56 40 32) # order follows HASH order

addSedRules-hash()
{
	local -i idx
	for ((idx = 0; idx < ${#HASH[@]}; idx++)); do
		is-enabled "hash:${HASH[idx]}" || continue
		RULES+=('s/\b[[:xdigit:]]{'"${HLEN[idx]}"'}\b/@HASH:'"${HASH[idx]^^}"'/g')
	done
}

helptext-hash()
{
	cat << EOF
  --hash [all|md5|sha|sha1|sha224|sha256|sha384|sha512]
               add HASH patterns to filters (default all)
               specify multiple times to use multiple algo
               or use family name (sha/sha2)
EOF
}

ARGSPEC['hash']='?'
enable-hash()
{
	local algo
	local -i match=0

	for algo in "${HASH[@]}"; do
		! is-enabled "hash:$algo" || continue
		if [[ "${1:-all}" == "all" || "$algo" == "$1"* ]]; then
			set-enabled "hash:$algo"
			((match++))
		fi
	done

	if [[ -n "$1" && "$match" -gt 0 ]] || [[ -z "$1" ]]; then
		return 0
	else
		return 1
	fi
}
