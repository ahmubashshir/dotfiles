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
	__devprompt_env $'\ue606' ${VIRTUAL_ENV:t:s@'%-[^-]##-py[0-9.]##'@@} # nf-seti-python:
	__devprompt_env $'\ue620' "${ROCK_ENV_NAME}" # nf-seti-lua:
	__devprompt_env $'\ue605' "${RBENV_VERSION}" # nf-seti-ruby:
	__devprompt_env $'\uf313' "${IN_NIX_SHELL}" # nf-linux-nixos:
}
