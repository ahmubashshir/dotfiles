#!/bin/zsh

setopt PROMPT_SUBST
autoload -U add-zsh-hook

typeset -gA DEVPROMPT

DEVPROMPT[prefix]='['
DEVPROMPT[suffix]=']'
DEVPROMPT[seperator]='-'
DEVPROMPT[icon]='%F{blue}'
DEVPROMPT[text]='%F{green}'
DEVPROMPT[default]='%F{red}'

add-zsh-hook precmd __devprompt_precmd

function __devprompt_env {
	[[ -z $2 ]] && return 0

	DEVPROMPT_PROMPT+="${DEVPROMPT[seperator]}${DEVPROMPT[prefix]}"
	DEVPROMPT_PROMPT+="${DEVPROMPT[icon]}%B$1 ${DEVPROMPT[text]}$2%b"
	DEVPROMPT_PROMPT+="${DEVPROMPT[default]}${DEVPROMPT[suffix]}"
}

function __devprompt_precmd {
	emulate -L zsh
	setopt hist_subst_pattern extendedglob
	DEVPROMPT_PROMPT=''
	__devprompt_env  ${VIRTUAL_ENV:t:s@'%-[^-]##-py[0-9.]##'@@}
	__devprompt_env  ${ROCK_ENV_NAME}
	__devprompt_env  ${RBENV_VERSION}
}
