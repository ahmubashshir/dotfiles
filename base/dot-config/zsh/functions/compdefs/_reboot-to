#compdef reboot-to
__reboot_to_list_targets() {
	[[ $(bootctl is-installed) == "yes" ]] || return
	local -A targets
	local ID bootdir espdir bctl_hash bctl_hash_cached
	ID=$(awk -v FS== '/^ID=/{print $2}' /etc/os-release)
	bootdir=$(bootctl -x)
	espdir=$(bootctl -p)
	bctl_hash=$(bootctl list|sha256sum|cut -c1-64)

	# retrive and check cache
	_retrieve_cache reboot-to
	if [[ $bctl_hash != $bctl_hash_cached ]];then
		# reset variables
		unset targets bctl_hash_cached
		local -A desc targets
		local id source fsroot file title bctl_hash_cached
		desc=(
			[windows]="Windows Boot Manager"
			[shell]="EFI Shell"
			[firmware]="EFI Settings"
		)
		bctl_hash_cached=$bctl_hash

		# rebuild data
		while read -r id;do
			case $id in
				(windows|shell|firmware) targets+=(["$id"]="$id:${desc[$id]}");;
				(*)
					source=$(
						bootctl list \
							| if [[ $id =~ ^linux-* ]]; then
								awk '/^\s+id: '"$ID-$id.conf"'/,/^$/ { if($1 == "source:") print $2}'
							else
								awk '/^\s+id: '"$id.conf"'/,/^$/ { if($1 == "source:") print $2}'
							fi
					)
					case $source in
						(${bootdir}*) fsroot="$bootdir";;
						(${espdir}*) fsroot="$espdir";;
						(/sys/*)	continue;;
						(*)	fsroot='';;
					esac
					while read -r file; do
						if [ ! -f "$fsroot$file" ]; then
							continue 2
						fi
					done < <(
						awk '/^(initrd|linux|efi)/ {print $2}' "$source"
					)
					title=$(awk '/^title/ {for (i=2; i<NF; i++) printf $i " "; print $NF}' "$source")
					targets+=(["$id"]="$id:$title")
				;;
			esac
			# store cache
			_cache_invalid reboot-to
			_store_cache reboot-to targets bctl_hash_cached
		done < <(
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
		)
	fi
	_describe "reboot targets" targets
}

_arguments -s "1:reboot target:__reboot_to_list_targets"

# vim:ts=4:ft=sh:noet:
