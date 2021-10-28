#!/bin/zsh
cd "${0:h}"
setopt nullglob extendedglob rematchpcre nocaseglob hist_subst_pattern

for each in **/*(ep|ova)-*.mp4;do
	meta=${each:s+/+-+:gs/:/∶/}
	meta=${each:s%-(#bi)(((ep(isode|)|ova)(-*|))-?ubbed)-%/${match[1]:l}/%}
	name=${meta:h1}
	meta=${meta:t2}
	echo :: $name, ${meta:h}, ${meta:h2:t:r}, ${meta:e}
	mkdir -p "$name/${meta:h}"
	mv "$each" "$name/${meta:h}/${meta:h2:t:r}.${meta:e}"
done

for each in **/*-*-*-*.mp4;do
	count=0
	meta=${each:s+/+-+:gs/:/∶/}
	meta=${each:s+(#bi)(*)-(*-*)-(*).mp4+'${match[1]}/${match[2]}/${match[3]}.mp4'+}
	echo :: ${meta:h1}, ${meta:h2:t:r}, ${meta:e}
	mkdir -p "${meta:h1}"
	mv "$each" "${meta:h1}/${meta:h2:t:r}.${meta:e}"
done

find . -type d -empty -delete 2>/dev/null
