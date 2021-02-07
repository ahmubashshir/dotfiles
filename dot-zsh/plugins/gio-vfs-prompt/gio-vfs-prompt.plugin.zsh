#!/bin/zsh

setopt PROMPT_SUBST
autoload -U add-zsh-hook

typeset -gA GIO_VFS_PROMPT_CONFIG __GIO_VFS_PROMPT_DATA
GIO_VFS_PROMPT_CONFIG[prefix]='['
GIO_VFS_PROMPT_CONFIG[suffix]=']'
GIO_VFS_PROMPT_CONFIG[seperator]='-'
GIO_VFS_PROMPT_CONFIG[icon]='%F{yellow}'
GIO_VFS_PROMPT_CONFIG[text]='%F{green}'
GIO_VFS_PROMPT_CONFIG[default]='%F{red}'

add-zsh-hook chpwd __GIO_VFS_PROMPT_chpwd
add-zsh-hook precmd __GIO_VFS_PROMPT_precmd

function __GIO_VFS_PROMPT_chpwd {
	local key
	unset GIO_VFS_PROMPT
	[[ $PWD =~ ^/run/user/[[:digit:]]*/gvfs/[[:print:]] ]] && __GIO_VFS_PROMPT_DATA[vfs]=true
	if ${__GIO_VFS_PROMPT_DATA[vfs]:-false};then
		if [[ ${PWD}/ =~ ^${__GIO_VFS_PROMPT_DATA[root]}/ ]];then
			__GIO_VFS_PROMPT_DATA[root]=$(sed -En 's@(/run/user/[[:digit:]]+/gvfs/[[:alnum:]:=,.-]*)($|/.*)@\1/@;p' <<<$PWD)
			__GIO_VFS_PROMPT_DATA[url]=$(echo -e $(sed -nE 's@/run/user/[[:digit:]]+/gvfs/([[:alnum:]:=%,.-]*)($|/.*)@\1@;s@([[:alnum:]]*)(:[[:alnum:]:=%,.-]*),(s)sl=true(.*)@\1\3\2\4@;s@([[:alnum:]]*):@\1://@;s/host=(.*)/\1/;/user=/{s://([[:alnum:]].*),user=(.*)://\2@\1:};/(,|)prefix=/{s@(,|)prefix=(.*)@\2@;s/%(..)/\\x\1/g;};p' <<<$PWD))
			GIO_VFS_PROMPT="${GIO_VFS_PROMPT_CONFIG[seperator]}${GIO_VFS_PROMPT_CONFIG[prefix]}${GIO_VFS_PROMPT_CONFIG[icon]}VFS ${GIO_VFS_PROMPT_CONFIG[text]}${__GIO_VFS_PROMPT_DATA[url]}${GIO_VFS_PROMPT_CONFIG[default]}${GIO_VFS_PROMPT_CONFIG[suffix]}"
		fi
		[[ ${PWD} = ^${__GIO_VFS_PROMPT_DATA[root]} ]] && __GIO_VFS_PROMPT_DATA[pwd]=/
	else
		for key in ${(@k)__GIO_VFS_PROMPT_DATA[@]};do
			unset __GIO_VFS_PROMPT_DATA[$key]
		done
	fi
}

function __GIO_VFS_PROMPT_precmd {
	__GIO_VFS_PROMPT_chpwd
	add-zsh-hook -d precmd __GIO_VFS_PROMPT_precmd
	unfunction __GIO_VFS_PROMPT_precmd
}
