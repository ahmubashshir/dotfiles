#!/bin/bash
if [[ -f ~/.shell/path ]]
then
	while read line;do
		line="${line/#\~/$HOME}"
		PATH=$(/bin/sed "s@${line%%|*}@@g;s@::@@g" <<< "$PATH")
		if [[ -d ${line%%|*} ]];then
			if [ "${line##*|}" = "prepend" ];then
				PATH="${line%%|*}${PATH:+:$PATH}"
			else
				PATH="${PATH:+$PATH:}${line%%|*}"
			fi
		fi
	done < ~/.shell/path
	for n in $(echo $PATH|tr ':' '\n');do
		case ":$P:" in
			*:"$n":*) continue;;
			*)
				if [ -d "$n" ];then
					P="${P:+$P:}$n"
				fi
			;;
		esac
	done
	echo $P
fi
