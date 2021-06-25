#!/bin/zsh
# commands to ignore
typeset -gA NOTIF
NOTIF[tmout]=${NOTIF[tmout]:-10}
NOTIF[units]=${NOTIF[units]:-0}
cmdignore+=(htop tmux top vim)
# set gt 0 to enable GNU units for time results
autoload -U add-zsh-hook
add-zsh-hook preexec notifyosd_preexec
add-zsh-hook precmd notifyosd_precmd

# end and compare timer, notify-send if needed
function notifyosd_precmd() {
    retval=$?
    unset_vars()
    {
        unset NOTIF[cmd] NOTIF[basename] NOTIF[start]
        unfunction unset_vars
    }
    ${ENV[gnome_vfs]:-false} && {
        unset_vars
        return 0
    }
    local -A msg dat
	if [[ ${cmdignore[(r)$NOTIF[basename]]} == $NOTIF[basename] ]]; then
        unset_vars
        return
    else
        if [ ! -z "$NOTIF[cmd]" ]; then
            dat[end]=`date +%s`
            ((dat[secs]=$dat[end] - $NOTIF[start]))
        fi
        if [ $retval -gt 0 ]; then
			dat[cmd]="with warning"
			dat[snd]="/usr/share/sounds/gnome/default/alerts/sonar.ogg"
			msg[u]=2
		else
            dat[cmd]="successfully"
			dat[snd]="/usr/share/sounds/gnome/default/alerts/glass.ogg"
			msg[u]=1
        fi
        if [ ! -z "$NOTIF[cmd]" -a $dat[secs] -gt ${NOTIF[tmout]:-10} ]; then
			if [ $NOTIF[units] -gt 0 ] && [ -x /usr/bin/units ]; then
				dat[time]=$(units "$dat[secs] seconds" "centuries;years;months;weeks;days;hours;minutes;seconds" | \
						sed -e 's/\ +/\,/g' -e s'/\t//')
			else
				dat[time]="$dat[secs] seconds"
			fi
            if [ ! -z $SSH_TTY ] ; then
                msg[s]="$NOTIF[basename] on `hostname` completed $dat[cmd]"
                msg[b]="\"$NOTIF[cmd]\" took $dat[time]"
            else
				msg[s]="$NOTIF[basename] completed $dat[cmd]"
				msg[b]="\"$NOTIF[cmd]\" took $dat[time]"

            fi
            NOTIF[id]=$(
                gdbus call --session \
                --dest org.freedesktop.Notifications \
                --object-path /org/freedesktop/Notifications \
                --method org.freedesktop.Notifications.Notify \
                "zsh@$$" \
                "${NOTIF[id]:-0}" \
                utilities-terminal \
                "$msg[s]" \
                "$msg[b]" \
                '[]' \
                "{'urgency': <byte $msg[u]>}" \
                15000 \
                | sed -E 's/\(uint32 ([[:digit:]]+),.*/\1/g'
            )
            play -q $dat[snd] 2>/dev/null
        fi
    fi
    unset_vars
}


# get command name and start the timer
function notifyosd_preexec() {
	${ENV[gnome_vfs]:-false} && return 0
    NOTIF[cmd]=$1
    NOTIF[basename]=${${NOTIF[cmd]:s/sudo //}[(ws: :)1]}
    NOTIF[start]=`date +%s`
}
