#!/bin/sh
sed -E 's|(<description>)|\1<![CDATA[|;s|(</description>)|]]>\1|'
