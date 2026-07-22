exports=(args)

args=()

parseArgs()
{
	local arg mode
	while (($# > 0)); do
		arg="$1"
		shift
		case "$arg" in
			--) break ;; # stop processing args
			# handled by script
			@*) redactEnv "${arg#@}" || {
				error 'Invalid ENV name "%s"' "${arg#@}"
				exit "${RET['badarg']}"
			} ;;

			# offloaded flags
			--[^-]*=*)
				mode="${arg%%=*}"
				mode="${mode#--}"

				case "${ARGSPEC["$mode"]}" in
					@)
						error "%s doesn't accept arguments" "${arg%%=*}"
						exit "${RET['badarg']}"
						;;
					: | '?')
						if [[ -z "${arg#*=}" ]]; then
							error '%s needs an argument' "${arg%%=*}"
							exit "${RET['badarg']}"
						elif "enable-$mode" "${arg#*=}"; then
							continue
						else
							error 'invalid argument for %s: %s' "${arg%%=*}" "${arg#*=}"
							exit "${RET['badarg']}"
						fi
						;;
				esac

				error 'unknown option: %s' "${arg%%=*}"
				exit "${RET['badflag']}"
				;;

			--[^-]* | -[^-]*)
				case "$arg" in
					--*) mode="${arg#--}" ;;
					-*)
						arg="${arg#-}"
						[[ -z "${arg:1}" ]] || set -- "-${arg:1}" "$@"
						arg="${arg:0:1}"
						mode="${SHORT["$arg"]}"
						if [[ -z $mode ]]; then
							error 'unknown option: %s' "$arg"
							exit "${RET['badflag']}"
						fi
						;;
				esac

				case "${ARGSPEC["$mode"]}" in
					@)
						"enable-$mode"
						continue
						;;
					:)
						if [[ "$1" = "--" || -z "$1" ]]; then
							error '%s needs an argument' "$arg"
							exit "${RET['badarg']}"
						elif "enable-$mode" "$1"; then
							shift
						else
							error 'invalid argument for %s: %s' "$arg" "$1"
							exit "${RET['badarg']}"
						fi
						continue
						;;
					'?')
						case "$1" in
							-*) "enable-$mode" ;;
							*) ! "enable-$mode" "$1" || shift ;;
						esac
						continue
						;;
				esac

				error 'unknown option: %s' "$arg"
				exit "${RET['badflag']}"
				;;
			# rest
			*) args+=("$arg") ;;
		esac
	done > >(:) # leave only stderr open
} <&-
