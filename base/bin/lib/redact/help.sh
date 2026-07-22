argtype=boolean
shortopts=(h)

enable-help()
{
	set-enabled show-help || return
}

helptext-help()
{
	cat << 'EOF'
  -h, --help
               show this help text
EOF
}

printHelp()
{
	cat << 'EOF'
Usage: redact [option]... @[ENV]... [--] [file]... < [file]... > output
Scrub local environment information from input stream

Options:
EOF

	for mode in "${GENERATORS[@]}" "${CORE[@]}"; do
		declare -F "helptext-$mode" > /dev/null || continue

		"helptext-$mode"
	done <&-
	exit 0
} >&2
