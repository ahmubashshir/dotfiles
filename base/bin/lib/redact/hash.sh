#!/bin/bash
declare -ra  HASH=(sha512 sha384 sha256 sha224 sha1 md5)
declare -rai HLEN=(128 96 64 56 40 32) # order follows HASH order

addSedRules-hash()
{
	local -i idx
	for ((idx = 0; idx < ${#HASH[@]}; idx++)); do
		((REDACT["hash:${HASH[idx]}"])) || continue
		RULES+=('s/\b[[:xdigit:]]{'"${HLEN[idx]}"'}\b/@HASH:'"${HASH[idx]^^}"'/g')
	done
}

enable-hash()
{
	local algo

	for algo in "${HASH[@]}"; do
		((!REDACT["hash:$algo"])) || continue
		if [[ "$1" == "all" || "$algo" == "$1"* ]]; then
			REDACT["hash:$algo"]=1
		fi
	done
}

helptext-hash()
{
	cat << EOF
  --hash=[all|md5|sha|sha1|sha224|sha256|sha384|sha512]
               add HASH patterns to filters (default all)
               specify multiple times to use multiple algo
               or use family name (sha/sha2)
EOF
}
