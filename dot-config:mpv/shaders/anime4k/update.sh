#!/bin/sh
cd "$(dirname "$0")" || exit
function update {
	[ -f files ] && xargs rm -f .files < .files
	echo "$1" | jq -r '.assets | select(length >= 1) | .[0] | .browser_download_url' | \
	xargs curl -s | bsdtar -xvf- 2>&1| awk '/^x/ {print $2}' > .files && \
	echo "$1" | jq -r '.tag_name' > .version
	echo "Anime4k: updated to $(<.version)"
}

response=$(curl -s https://api.github.com/repos/bloc97/Anime4K/releases/latest)
lv=$(cat .version 2>/dev/null || echo 0.0)
rv=$(echo "$response" | jq -r '.tag_name')

if [ -f .files ];then
	while read -r line;do
		if ! [ -f "$line" ];then
			update=true
			break
		fi
	done < .files
else
	update=true
fi

if [ "$(printf '%s\n' "$rv" "$lv" | sort -rV | head -n1)" != "$lv" ];then
	update=true
fi

[ "$update" == "true" ] && update "$response" || echo "Anime4K: up to date."
