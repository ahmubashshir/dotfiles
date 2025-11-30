#!/bin/zsh
export BROWSER=links
if [ -x /usr/bin/lesspipe.sh ] && [ -x /usr/bin/source-highlight ];then
	export LESSOPEN='|file=%s; /usr/bin/source-highlight -q --infer-lang -f esc --style-file=esc.style -i "$file" 2>/dev/null | /usr/bin/ifne -n /usr/bin/lesspipe.sh "$file" '
fi
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'
add_java_option awt.useSystemAAFontSettings=on
add_java_option swing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel
add_java_option swing.crossplatformlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel
if [ "${ZSH_ARGZERO##*[/-]}" = "zsh" ];then
	export LS_COLORS=${${(@f)$(dircolors -c ~/.config/shell/dircolors 2>/dev/null || dircolors -c 2>/dev/null)[3]%*\'}#\'*} #}
else
	eval "$(dircolors -b ~/.config/shell/dircolors 2>/dev/null || dircolors -b 2>/dev/null)"
fi

## distrobox fucks up prompt otherwise
if [ "$CONTAINER_ID" ] && [ "$container" ];then
	export LANG=C.UTF-8
fi
