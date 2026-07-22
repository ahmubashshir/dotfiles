argtype=boolean
shortopts=(d)

enable-dump()
{
	set-enabled dump-rules || return
}

helptext-dump()
{
	cat << EOF
  -d, --dump
               dump generated replacement rules
EOF
}

printRules() {
	printf '%%RULES {\n'
	printf '\t%s\n' "${RULES[@]}"
	printf '}\n\nsed -uEf %%RULES --'
	((${#args[@]} == 0)) || printf ' %Q' "${args[@]}"
	printf '\n'
} >&2
