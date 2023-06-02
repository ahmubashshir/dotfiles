#!/bin/zsh

setopt PROMPT_SUBST
autoload -U add-zsh-hook

typeset -gA DEVPROMPT

DEVPROMPT[prefix]='-['
DEVPROMPT[suffix]=']'
DEVPROMPT[icon]='%F{blue}'
DEVPROMPT[text]='%F{green}'
DEVPROMPT[default]='%F{red}'

add-zsh-hook precmd __devprompt_precmd

function __devprompt_env {
	[[ -z $2 ]] && return 0

	DEVPROMPT_PROMPT+="${DEVPROMPT[prefix]}"
	DEVPROMPT_PROMPT+="${DEVPROMPT[icon]}$B%{${icons[$1]}%G%} ${DEVPROMPT[text]}$2%b"
	DEVPROMPT_PROMPT+="${DEVPROMPT[default]}${DEVPROMPT[suffix]}"
}

function __devprompt_precmd {
	emulate -L zsh
	setopt hist_subst_pattern extendedglob rematchpcre
	local -A icons
	icons=(
		['ssh']=$'\xef\x92\x89'     # f489		nf-oct-terminal
		['pod']=$'\xee\xae\x9e'     # eb9e		nf-cod-run_all
		['py3']=$'\xee\x98\x86'     # e606		nf-seti-python
		['lua']=$'\xee\x98\xa0'     # e620		nf-seti-lua
		['rby']=$'\xee\x98\x85'     # e605		nf-seti-ruby
		['nix']=$'\xef\x8c\x93'     # f313		nf-linux-nixos
	)

	DEVPROMPT_PROMPT=''
	__devprompt_env ssh "${${=SSH_CONNECTION}[3]}"
	__devprompt_env pod "${CONTAINER_ID}"
	__devprompt_env py3 "${VIRTUAL_ENV+${VIRTUAL_ENV:t:gs+-+/+:h:h:gs+/+-+}}"
	__devprompt_env lua "${ROCK_ENV_NAME}"
	__devprompt_env rby "${RBENV_VERSION}"
	__devprompt_env nix "${IN_NIX_SHELL}"
}
