#!/bin/bash

filters=(
	-e 's/(\?|&(amp;)?)resize=[0-9]+%2C[0-9]+&(amp;|)\b/\1/g'
	-e 's/(width|height)="150"?//gI'
	-e 's/(loading)="lazy"/\1="eager"/gI'
	-e 's/max(-width)/min\1/gI'
	-e 's/(<img )/\1style="max-width: 70vw; max-height: 70vh;" /gI'
)

sed -E "${filters[@]}"
