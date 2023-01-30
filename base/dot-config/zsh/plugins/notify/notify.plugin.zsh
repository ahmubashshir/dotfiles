#!/bin/zsh
# commands to ignore
zmodload -F zsh/datetime p:EPOCHSECONDS
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
    vars=(
        'NOTIF[cmd]'
        'NOTIF[basename]'
        'NOTIF[start]'
    )
    ${ENV[gnome_vfs]:-false} && {
        unset $vars
        return 0
    }
    local -A msg dat
	if [[ ${cmdignore[(r)$NOTIF[basename]]} == $NOTIF[basename] ]]; then
        unset $vars
        return
    else
        if [ ! -z "$NOTIF[cmd]" ]; then
            dat[end]=$EPOCHSECONDS
            ((dat[secs]=$dat[end] - $NOTIF[start]))
        fi
        if [ $retval -gt 0 ]; then
			dat[cmd]="with return $retval"
			dat[snd]="/usr/share/sounds/gnome/default/alerts/sonar.ogg"
			msg[u]=2
		else
            dat[cmd]="successfully"
			dat[snd]="/usr/share/sounds/gnome/default/alerts/glass.ogg"
			msg[u]=1
        fi
        if [ ! -z "$NOTIF[cmd]" -a $dat[secs] -gt ${NOTIF[tmout]:-10} ]; then
			if [ $NOTIF[units] -gt 0 ] && whence -p units > /dev/null; then
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
                notifyosd_send "$msg[s]" "$msg[b]" "$msg[u]"
            )
            play -q $dat[snd] 2>/dev/null
        fi
    fi
    unset $vars
}

# Send notification
function notifyosd_send() {
    local app bus dest name
    bus="org.freedesktop.Notifications"
    dest=/org/freedesktop/Notifications
    name=Notify

    () {
        local each
        for each in "$@";do
            whence -p $each > /dev/null || continue
            app=$each
            return
        done
    } busctl gdbus notify-send
    ! {
        [[ -n $DBUS_SESSION_BUS_ADDRESS ]] \
        && dbus-send --print-reply --dest=org.freedesktop.DBus \
            /org/freedesktop/DBus org.freedesktop.DBus.ListNames \
            | grep -q 'org\.freedesktop\.Notifications'
    } && return 0
    case $app in
        (busctl)
            busctl --user \
                call "$bus" "$dest" "$bus" \
                "$name" 'susssasa{sv}i' \
                "zsh@$$" "${NOTIF[id]:-0}" utilities-terminal "$1" "$2" \
                0 1 urgency y "$3" 15000 \
             | sed -E 's/^u ([[:digit:]]+)$/\1/g'
        ;;
        (gdbus)
            gdbus call --session --dest "$bus" \
                --object-path "$dest" --method "$bus.$name" \
                "zsh@$$" "${NOTIF[id]:-0}" utilities-terminal "$1" "$2" \
                '[]' "{'urgency': <byte $3>}" 15000 \
             | sed -E 's/\(uint32 ([[:digit:]]+),.*/\1/g'
        (notify-send)
            notify-send -t 15000 -a "zsh@$$" \
                -i utilities-terminal \
                -h byte:urgency:$3 \
                "$1" "$2"
        ;;
    esac
}

# get command name and start the timer
function notifyosd_preexec() {
	${ENV[gnome_vfs]:-false} && return 0
    NOTIF[cmd]=$1
    NOTIF[basename]=${${NOTIF[cmd]:s/sudo //}[(ws: :)1]}
    NOTIF[start]=$EPOCHSECONDS
}
