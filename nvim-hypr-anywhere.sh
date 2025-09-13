#!/bin/bash

FONT_SIZE="${1:-25}"

check_deps() {
	for cmd in wtype nvim alacritty; do
		if ! command -v "$cmd" &>/dev/null; then
			echo "Error: $cmd is required but not installed."
			exit 1
		fi
	done
}

check_deps

TMPFILE_DIR="/tmp/nvim-hypr-anywhere/"
TMPFILE=$TMPFILE_DIR/doc-$(date +"%y%m%d%H%M%S")

# make sure the tmp dir exists
mkdir -p $TMPFILE_DIR

# probably not needed but any way
touch "$TMPFILE"

# only yours
chmod og-rwx "$TMPFILE"

# you probably want to type stright away, so start at insert
#
# also, once you save it, it exits
alacritty -o "font.size=$FONT_SIZE" --class nvim-hypr-anywhere -e nvim +startinsert +'autocmd BufWritePost <buffer> quit' "$TMPFILE"

TEXT=$(<"$TMPFILE")

# skip if it's empty
if [ -n "$TEXT" ]; then
	echo -n "$TEXT" | wtype -
else
	exit 1
fi

# if you want to delete it once done with it
#rm -rf "$TMPFILE"
