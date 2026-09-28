#!/bin/bash
if (($# == 0)); then
	cat >&2 << EOF
Usage: ${0##*/} <spec-to-execute> [args]

This script is a automated compilation wrapper that
compiles bundled sources on execution.

Think of it like JIT for compiled languages.
EOF
	exit 120
fi

readtype()
{
	local prefix next IFS="$IFS"

	while IFS="$IFS=" read -r prefix next; do
		case "$prefix" in
			TYPE)
				declare -g type="${next#*[$IFS]}"
				break
				;;
			*) continue ;;
		esac
	done < "$1"
}

args=()
CLEAN='no'
CALLER="$1"
BINDIR="${XDG_CACHE_HOME:-$HOME/.cache}/bin/$(getmachine)"

shift
for arg in "$@"; do
	case "$arg" in
		--delete-cache) CLEAN='yes' ;;
		*) args+=("$arg") ;;
	esac
done

[[ -d "$BINDIR" ]] || mkdir -p "$BINDIR" || {
	mv "$BINDIR" "$BINDIR.old"
	mkdir -p "$BINDIR"
}

src="$HOME/bin/srcs/${CALLER##*/}"
readtype "$CALLER"
if [[
	"$CALLER" -nt "$BINDIR/${CALLER##*/}" ||
	"$0" -nt "$BINDIR/${CALLER##*/}" ||
	# this follows make's target resolution...
	"$src.${type:-c}" -nt "$BINDIR/${CALLER##*/}" ||
	-f "$src.cpp" && "$src.cpp" -nt "$BINDIR/${CALLER##*/}" ]]
then
	set -e
	make -srf /dev/stdin -- "CALLER=$CALLER" "INTRPTR=$0" "BINDIR=$BINDIR" "CLEAN=$CLEAN" 3>&2 2> /dev/null >&1 << 'EOF'
SRCDIR := $(HOME)/bin/srcs
NAME   := $(basename $(notdir $(CALLER)))
<<<<   := $(shell mkdir -p $(BINDIR))
include $(CALLER)


findpkg ?= $(shell pkg-config $(1) --libs --cflags)

ifneq ($(PKGS),)
FLAGS  += $(foreach pkg,$(PKGS), $(call findpkg,$(pkg)))
endif

recompile := $(INTRPTR) $(CALLER)

all: clean-$(CLEAN) $(BINDIR)/$(NAME)

$(BINDIR)/%: $(SRCDIR)/%.$(TYPE) $(recompile)
	$(COMP) $(<) -o $(@) $(FLAGS) 2>&3

$(BINDIR)/%: $(SRCDIR)/%.c $(recompile)
	$(CC) $(<) -o $(@) $(FLAGS) 2>&3

$(BINDIR)/%: $(SRCDIR)/%.cpp $(recompile)
	$(CXX) $(<) -o $(@) $(FLAGS) 2>&3

clean-yes:
	@echo "Cleaning..." 2>&3 >&2
	@rm -f $(BINDIR)/$(NAME)

.PHONY: clean-no
EOF
	set +e
fi

exec -a "${CALLER##*/}" "$BINDIR/${CALLER##*/}" "${args[@]}"
