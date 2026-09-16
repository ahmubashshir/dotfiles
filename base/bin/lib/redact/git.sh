#!/bin/bash
argtype=optional

helptext-git()
{
	cat << EOF
  --git [config|all]
               add git user/remote mapping to filters
               from current repository, implies --mail
EOF
}

enable-git()
{
	set-enabled git || return

	case "${1:-all}" in
		all) set-enabled git:log ;;
		config) ;;
	esac

	enable-mail
}

addSedRules-git()
{
	is-enabled git || return
	git rev-parse --git-dir > /dev/null 2>&1 || return

	addSedRules-git-remote
	addSedRules-git-user
}

addSedRules-git-user()
{
	is-enabled git || return

	local mail name uhash tag value
	if is-enabled git:log; then
		message 'Reading git logs'
		while IFS=':' read -r tag uhash value; do
			case "$tag" in
				n) RULES+=('s/\b'"$value"'\b/@Git.User.'"$uhash"'/g') ;;
				m) RULES+=('s/(^|[^[:alnum:]])'"$value"'([^[:alnum:]]|$)/\1git@'"$uhash"'.user.email\2/g') ;;
			esac
		done < <(dumpGitUIDMap | dSortStripPrio)
	fi

	name=$(git config --get user.name)
	mail=$(git config --get user.email)
	if [[ -n $name && -n $mail ]]; then
		if is-enabled git:log; then
			uhash=$(sha256sum <<< "$name <$mail>" | cut -c1-8)
			name="@Git.User.$uhash"
			mail="git@$uhash.user.email"
		else
			name=$(ERE2Literal "$name" | quoteSed pattern)
			mail=$(ERE2Literal "$mail" | quoteSed pattern)
		fi

		RULES+=('s/'"$name"'/@Git.Local.User/g'
			's/\b'"$mail"'\b/git@local.user.email/g')
	fi
}

addSedRules-git-remote()
{
	is-enabled git || return
	local remote url owner repo

	while read -r remote; do
		url="$(git remote get-url --no-push "$remote")"
		[[ $url ]] || continue

		url="${url%".git"}"
		case "$url" in
			*://*) url="${url##*://}" ;;
			*@*:*) url="${url##*@}" ;;
		esac

		repo="$(ERE2Literal "${url##*/}" | quoteSed pattern)"
		owner="${url%"/${url##*/}"}"
		owner="$(ERE2Literal "${owner#*[:/]}" | quoteSed pattern)"
		remote=$(quoteSed <<< "$remote")

		[[ -z $repo ]] || RULES+=('/[\/:]'"$repo"'\b/s/([\/:])'"$repo"'\b/\1@repo/g')
		[[ -z $owner ]] || RULES+=('/[\/:]'"$owner"'\//s/([\/:])'"$owner"'\b/\1@'"$remote"'/g')
	done < <(git remote)
}

dumpGitUIDMap()
{
	git log --pretty='format:%an <%ae>' \
		| sort \
		| sed -nE 's/^(.+) <(.+)>$/\2 \1/p' \
		| uniq -c \
		| while read -r count mail name; do
			[[ $count -gt 0 && -n $mail && -n $name ]] || continue

			uhash=$(sha256sum <<< "$name <$mail>" | cut -c1-8)
			tuples=(
				"$((20000 * ${#mail} + count))" "m:$uhash" "$(ERE2Literal "$mail" | quoteSed pattern)"
				"$((10000 * ${#name} + count))" "n:$uhash" "$(ERE2Literal "$name" | quoteSed pattern)"
			)
			printf '%d:%s:%s\n' "${tuples[@]}"
		done
}
