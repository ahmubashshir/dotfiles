#!/bin/bash
addSedRules-git-user()
{
	((REDACT['git'])) || return

	local mail name uhash
	while IFS=' ' read -r _ mail name; do
		[[ -n $mail && -n $name ]] || continue
		uhash=$(sha256sum <<< "$name <$mail>" | cut -c1-8)
		RULES+=('s/\b'"$(ERE2Literal "$name" | quoteSed)"'\b/@Git.User.'"$uhash"'/g'
		's/(^|[^[:alnum:]])'"$(ERE2Literal "$mail" | quoteSed)"'([^[:alnum:]]|$)/\1git@'"$uhash"'.user.email\2/g')
	done < <(
		git log --pretty='format:%an <%ae>' \
			| sort \
			| sed -nE 's/^(.+) <(.+)>$/\2 \1/p' \
			| uniq -c \
			| sort -rn
	)
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
		url=$(git config --get "remote.$remote.url")
		[[ $url ]] || continue
		repo=$(sed -E -e 's#^.+[:/]([^/]+)$#\1#' -e 's/\.git\/?$//' <<< "$url" | ERE2Literal | quoteSed)
		owner=$(sed -E 's#^([^@:]+(@[^:]+:/?|://[^/]+/))(.+)/'"$repo"'$#\1#' <<< "$url" | ERE2Literal | quoteSed)
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
