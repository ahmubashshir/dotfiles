#!/bin/zsh
cd "${0:P:h}"
setopt nullglob extendedglob rematchpcre

for each in *ep-*/*.webp;do
	echo :: ${each:s+/+-+:s%-ep%/ep%:h}, ${each:s+/+-+:s%-ep%/ep%:t}
	mkdir -p ${each:s+/+-+:s%-ep%/ep%:h}
	mv "$each" "${each:s+/+-+:s:-ep:/ep:}"
done

for each in *ep-*(/);rmdir "${each:h}" 2>/dev/null

