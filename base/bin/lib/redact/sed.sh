#!/bin/bash

helptext-sed()
{
	cat << EOF
  -e script, --sed script, --sed=script
               add the sed script to the filters
EOF
}

SHORT['e']='sed'
ARGSPEC['sed']=':'
enable-sed()
{
	[[ $1 ]] || return 1

	RULES+=("$1")

	return 0
}
