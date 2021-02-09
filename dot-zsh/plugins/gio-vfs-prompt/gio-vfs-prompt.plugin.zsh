#!/bin/zsh

setopt PROMPT_SUBST
autoload -U add-zsh-hook

typeset -gA GIOVFS __GIOVFS_PROMPT_DATA
GIOVFS[prefix]='['
GIOVFS[suffix]=']'
GIOVFS[seperator]='-'
GIOVFS[icon]='%F{yellow}'
GIOVFS[text]='%F{green}'
GIOVFS[default]='%F{red}'

add-zsh-hook chpwd __GIOVFS_PROMPT_chpwd
add-zsh-hook precmd __GIOVFS_PROMPT_precmd

function __GIOVFS_PROMPT_chpwd {
	local key
	unset GIOVFS_PROMPT
	[[ $PWD =~ ^/run/user/[[:digit:]]*/gvfs/[[:print:]] ]] && __GIOVFS_PROMPT_DATA[vfs]=true
	if ${__GIOVFS_PROMPT_DATA[vfs]:-false};then
		if [[ ${PWD}/ =~ ^${__GIOVFS_PROMPT_DATA[root]}/ ]];then
			__GIOVFS_PROMPT_DATA[root]=$(sed -En 's@(/run/user/[[:digit:]]+/gvfs/[[:alnum:]:=,.-]*)($|/.*)@\1/@;p' <<<$PWD)
			__GIOVFS_PROMPT_DATA[url]=$(echo -e $(sed -nE 's@/run/user/[[:digit:]]+/gvfs/([[:alnum:]:=%,.-]*)($|/.*)@\1@;s@([[:alnum:]]*)(:[[:alnum:]:=%,.-]*),(s)sl=true(.*)@\1\3\2\4@;s@([[:alnum:]]*):@\1://@;s/host=(.*)/\1/;/user=/{s://([[:alnum:]].*),user=(.*)://\2@\1:};/(,|)prefix=/{s@(,|)prefix=(.*)@\2@;s/%(..)/\\x\1/g;};p' <<<$PWD))
			GIOVFS_PROMPT="${GIOVFS[seperator]}${GIOVFS[prefix]}${GIOVFS[icon]}VFS ${GIOVFS[text]}${__GIOVFS_PROMPT_DATA[url]}${GIOVFS[default]}${GIOVFS[suffix]}"
		fi
		[[ ${PWD} = ^${__GIOVFS_PROMPT_DATA[root]} ]] && __GIOVFS_PROMPT_DATA[pwd]=/
	else
		for key in ${(@k)__GIOVFS_PROMPT_DATA[@]};do
			unset __GIOVFS_PROMPT_DATA[$key]
		done
	fi
}

function __GIOVFS_PROMPT_precmd {
	__GIOVFS_PROMPT_chpwd
	add-zsh-hook -d precmd __GIOVFS_PROMPT_precmd
	unfunction __GIOVFS_PROMPT_precmd
}
