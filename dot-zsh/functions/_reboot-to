#compdef reboot-to
__list_reboot_targets() {
	[[ $(bootctl is-installed) == "yes" ]] || return
	local -a targets ids
	local each bootdir file source ID ids2
	ID=$(awk -v FS== '/^ID=/{print $2}' /etc/os-release)
	bootdir=$(bootctl -x)
	_retrieve_cache reboot_to_cache
	ids2="${ids[*]}"

	ids=(${(f)"$(
		bootctl list \
		| sed -nE '/^[[:blank:]]*id: /{
			s/^.*id: (.*)/\1/
			s/\.conf$//g
			s/^('"$ID"'|auto)-//g
			s/efi-(shell)/\1/
			s/reboot-to-(firmware)-setup/\1/
			p
			}' \
		| sort \
		| awk '
			!/^(shell|firmware)$/;
			/^(shell|firmware)$/ {
				d[i++]=$1
			};
			END{
				for(i in d)print d[i]
			}'
	)"})

	if [ "${ids[*]}" != "$ids2" ];then
		_cache_invalid reboot_to_cache
		for each in ${ids[@]}; do
			case $each in
				windows | efi-shell) targets+=("$each:Windows Boot Manager");;
				shell | efi-shell) targets+=("$each:EFI Shell") ;;
				firmware | efi | setup) targets+=("$each:EFI Settings");;
				*)
					source=$(
						bootctl list \
							| if [[ $each =~ linux-* ]]; then
								awk '/^\s+id: '"$ID-$each.conf"'/,/^$/ { if($1 == "source:") print $2}'
							else
								awk '/^\s+id: '"$each.conf"'/,/^$/ { if($1 == "source:") print $2}'
							fi
					)
					while read -r file; do
						if [ ! -f "$bootdir$file" ]; then
							continue 2
						fi
					done < <(
						awk '/^(initrd|linux|efi)/ {print $2}' "$source"
					)
					title=$(awk '/^title/ {for (i=2; i<NF; i++) printf $i " "; print $NF}' "$source")
					targets+=("$each:$title")
					;;
			esac
		done
		_store_cache reboot_to_cache targets ids
	fi
	_describe "reboot targets" targets
}

local args state
args=(
	"1:reboot target:__list_reboot_targets"
)
_arguments -s "${args[@]}"

# vim:ts=4:ft=sh:noet:

