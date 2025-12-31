#!/bin/zsh

setopt PROMPT_SUBST
autoload -U add-zsh-hook

typeset -gA GIOVFS
GIOVFS[prefix]='['
GIOVFS[suffix]=']'
GIOVFS[icon]='%F{yellow}'
GIOVFS[text]='%F{green}'
GIOVFS[default]='%F{red}'

add-zsh-hook chpwd __GIOVFS_PROMPT_chpwd
add-zsh-hook precmd __GIOVFS_PROMPT_precmd

function __GIOVFS_PROMPT_chpwd {
	emulate -L zsh

	local key
	local -a match
	unset GIOVFS_PROMPT
	setopt nullglob extendedglob rematchpcre nocaseglob hist_subst_pattern

	if [[ $PWD =~ ^/run/user/[[:digit:]]*/gvfs/[[:print:]] ]];then
		if [[ ${PWD}/ =~ ^${GIOVFS[base]}/ ]];then
			GIOVFS[base]=${PWD:s+'#(#b)(/run/user/<->/gvfs/[^/]##)*'+'${match[1]}'+}
			GIOVFS[url]=${GIOVFS[base]:t:s%'#(#b)(*)(:*),(s)sl=true'%'${match[1]}${match[3]}${match[2]}'}
			GIOVFS[url]=${GIOVFS[url]:s%'#(#b)(*)(:*)'%'${match[1]}://${match[2]}'}
			GIOVFS[url]=${GIOVFS[url]:s%'#(#b)(*://)(*[^,]),#user=(*)'%'${match[1]}${match[3]}@${match[2]}'}
			GIOVFS[url]=${GIOVFS[url]:s%'(#b):#host=([^,]##),#'%'${match[1]}'%}
			GIOVFS_PROMPT="${GIOVFS[prefix]}${GIOVFS[icon]:-VFS} ${GIOVFS[text]}${GIOVFS[url]}${GIOVFS[default]}${GIOVFS[suffix]}"
		fi
		GIOVFS[cwd]=${PWD#${GIOVFS[base]}}
		[[ $GIOVFS[cwd] ]] || GIOVFS[cwd]='/'
		if [[ $GIOVFS[basename] == yes && ! $GIOVFS[cwd] == / ]]; then
			GIOVFS[cwd]=${GIOVFS[cwd]:t}
		fi
	elif [[ ${GIOVFS[base]} ]]; then
		unset GIOVFS[{base,url,cwd}]
	fi
}

function __GIOVFS_PROMPT_precmd {
	__GIOVFS_PROMPT_chpwd
	add-zsh-hook -d precmd __GIOVFS_PROMPT_precmd
	unfunction __GIOVFS_PROMPT_precmd
}
