#!/bin/bash
argtype=boolean

helptext-mail()
{
	cat << EOF
  --mail
               add a filter to scrub 'User <email>' patterns
EOF
}

enable-mail()
{
	set-enabled mail || return
}

addSedRules-mail()
{
	is-enabled mail || return
	local name='[[:alnum:]][[:alnum:][:blank:]]*'
	local address='[[:alnum:]._%+-]+@[^[:space:]@.]+(\.[^[:space:]@.]+)*'

	RULES+=('s/([[:blank:]])'"$name"' <'"$address"'>/\1User <user@email.tld>/g')
}
