#!/bin/bash

addSedRules-uuid()
{
	is-enabled uuid || return
	RULES+=(
		# RFC 4122 UUIDs
		's/\b[[:xdigit:]]{8}-[[:xdigit:]]{4}-[1-5][[:xdigit:]]{3}-[89abAB][[:xdigit:]]{3}-[[:xdigit:]]{12}\b/@RFC4122UUID/g'
		# Standard UUID
		's/\b[[:xdigit:]]{8}-[[:xdigit:]]{4}-[[:xdigit:]]{4}-[[:xdigit:]]{4}-[[:xdigit:]]{12}\b/@UUID/g'
	)
}

helptext-uuid()
{
	cat << EOF
  --uuid
               add UUID patterns to filters
EOF
}

ARGSPEC['uuid']='@'
enable-uuid()
{
	set-enabled uuid || return
}
