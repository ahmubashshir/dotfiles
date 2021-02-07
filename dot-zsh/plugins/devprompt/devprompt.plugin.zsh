#!/bin/zsh

setopt PROMPT_SUBST
autoload -U add-zsh-hook

typeset -gA DEVPROMPT_CONFIG

DEVPROMPT_CONFIG[prefix]='['
DEVPROMPT_CONFIG[suffix]=']'
DEVPROMPT_CONFIG[seperator]='-'
DEVPROMPT_CONFIG[icon]='%F{blue}'
DEVPROMPT_CONFIG[text]='%F{green}'
DEVPROMPT_CONFIG[default]='%F{red}'

add-zsh-hook precmd __DEVPROMPT_precmd

function __DEVPROMPT_precmd {
	DEVPROMPT_PROMPT=''
	[[ -n $VIRTUAL_ENV ]] && \
		DEVPROMPT_PROMPT+="${DEVPROMPT_CONFIG[seperator]}${DEVPROMPT_CONFIG[prefix]}${DEVPROMPT_CONFIG[icon]}%B ${DEVPROMPT_CONFIG[text]}${VIRTUAL_ENV##*/}%b${DEVPROMPT_CONFIG[default]}${DEVPROMPT_CONFIG[suffix]}"
}
