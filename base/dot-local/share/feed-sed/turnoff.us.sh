#!/bin/sh
sed -E 's|(<description>)|\1<![CDATA[\n\t\t|;s|(</description>)|\n]]>\1|'
