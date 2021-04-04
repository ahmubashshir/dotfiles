#!/bin/sh
find "$(realpath "$0" | xargs dirname)" -mindepth 2 -maxdepth 2 -name 'update.sh' -exec '{}' \;
