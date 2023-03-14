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
	DEVPROMPT_PROMPT+="${DEVPROMPT[icon]}$1%B ${DEVPROMPT[text]}$2%b"
	DEVPROMPT_PROMPT+="${DEVPROMPT[default]}${DEVPROMPT[suffix]}"
}

function __devprompt_precmd {
	emulate -L zsh
	setopt hist_subst_pattern extendedglob
	DEVPROMPT_PROMPT=''
	__devprompt_env $'\xee\x98\x86' ${VIRTUAL_ENV:t:s@'%-[^-]##-py[0-9.]##'@@} # nf-seti-python::e606
	__devprompt_env $'\xee\x98\xa0' "${ROCK_ENV_NAME}" # nf-seti-lua::e620
	__devprompt_env $'\xee\x98\x85' "${RBENV_VERSION}" # nf-seti-ruby::e605
	__devprompt_env $'\xef\x8c\x93' "${IN_NIX_SHELL}"  # nf-linux-nixos::f313
}
