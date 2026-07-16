#!/bin/bash
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
				"$((${#mail} + count))" "m:$uhash" "$(ERE2Literal "$mail" | quoteSed pattern)"
				"$((${#name} + count))" "n:$uhash" "$(ERE2Literal "$name" | quoteSed pattern)"
			)
			printf '%d:%s:%s\n' "${tuples[@]}"
		done
}

addSedRules-git-user()
{
	((REDACT['git'])) || return

	local mail name uhash tag value
	message 'Reading git logs'
	while IFS=':' read -r tag uhash value; do
		case "$tag" in
			n) RULES+=('s/\b'"$value"'\b/@Git.User.'"$uhash"'/g') ;;
			m) RULES+=('s/(^|[^[:alnum:]])'"$value"'([^[:alnum:]]|$)/\1git@'"$uhash"'.user.email\2/g') ;;
		esac
	done < <(dumpGitUIDMap | dSortStripPrio)

	name=$(git config --get user.name)
	mail=$(git config --get user.email)
	if [[ -n $name && -n $mail ]]; then
		uhash=$(sha256sum <<< "$name <$mail>" | cut -c1-8)
		RULES+=('s/@Git\.User\.'"$uhash"'/@Git.Local.User/g'
			's/\bgit@'"$uhash"'\.user\.email\b/git@local.user.email/g')
	fi
}

addSedRules-git-remote()
{
	((REDACT['git'])) || return
	local remote url owner repo

	while read -r remote; do
		url="$(git remote get-url --no-push "$remote")"
		[[ $url ]] || continue

		url="${url%".git"}"
		case "$url" in
			*://*) url="${url##*://}" ;;
			*@*:*) url="${url##*@}" ;;
		esac

		repo=${url##*/}
		owner="${url%"/$repo"}"
		owner=${owner#*[:/]}
		remote=$(quoteSed <<< "$remote")

		[[ -z $repo ]] || RULES+=('/[\/:]'"$repo"'\b/s/([\/:])'"$repo"'\b/\1@repo/g')
		[[ -z $owner ]] || RULES+=('/[\/:]'"$owner"'\//s/([\/:])'"$owner"'\b/\1@'"$remote"'/g')
	done < <(git remote)
}

addSedRules-git()
{
	((REDACT['git'])) || return
	git rev-parse --git-dir > /dev/null 2>&1 || return

	addSedRules-git-remote
	addSedRules-git-user
}

helptext-git()
{
	cat << EOF
  --git
               add git user/remote mapping to filters
               from current repository, implies --mail
EOF
}

ARGSPEC['git']='@'
enable-git()
{
	((!REDACT['git'])) || return

	REDACT['git']=1
	enable-mail
}
