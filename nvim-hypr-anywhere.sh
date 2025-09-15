#!/usr/bin/env bash

set -euo pipefail

ASK_EXT=false
REMOVE_TMP=false
WTYPE_MODE=false

FONT_SIZE=25
TERM_CLASS="nvim-hypr-anywhere"
TERM="alacritty"
TERM_OPTS="-o font.size=$FONT_SIZE --class $TERM_CLASS -e"
TMPFILE_DIR="/tmp/nvim-hypr-anywhere"

check_deps() {
  local deps=("nvim" "alacritty" "wofi")

  # Add wtype only if WTYPE_MODE is enabled
  if $WTYPE_MODE; then
    deps+=("wtype")
  fi

  for cmd in "${deps[@]}"; do
    if ! command -v "$cmd" &>/dev/null; then
      echo "Error: '$cmd' is required but not installed."
      exit 1
    fi
  done
}

kill_existing_instance() {
  local FOUND=false
  while read -r pid cmd; do
    if [[ "$cmd" == "$TERM"* ]]; then
      kill -9 "$pid"
      FOUND=true
    fi
  done < <(pgrep -af "$TERM_CLASS")

  if $FOUND; then
    echo "An existing instance was found and terminated."
    exit 1
  fi
}

create_tmpfile() {
  mkdir -p "$TMPFILE_DIR"
  local filename="doc-$(date +"%y%m%d%H%M%S")"
  if $ASK_EXT && [[ -n "${EXT:-}" ]]; then
    filename="$filename.$EXT"
  fi
  TMPFILE="$TMPFILE_DIR/$filename"
  touch "$TMPFILE"
  chmod og-rwx "$TMPFILE"
}

parse_args() {
  while [[ $# -gt 0 ]]; do
    case "$1" in
    --ask-ext)
      ASK_EXT=true
      shift
      ;;

    --rm-tmp)
      REMOVE_TMP=true
      shift
      ;;

    --wtype-mode)
      WTYPE_MODE=true
      shift
      ;;

    --font-size)
      if [[ $# -ge 2 && $2 != --* ]]; then
        FONT_SIZE="$2"
        shift 2
      else
        echo "Error: --font-size requires a value."
        exit 1
      fi
      ;;
    --term)
      if [[ $# -ge 2 && $2 != --* ]]; then
        TERM="$2"
        shift 2
      else
        echo "Error: --term requires a value."
        exit 1
      fi
      ;;
    --term-opts)
      TERM_OPTS=""
      shift
      while [[ $# -gt 0 && $1 != --* ]]; do
        TERM_OPTS="$TERM_OPTS $1"
        shift
      done
      ;;
    *)
      echo "Unknown argument: $1"
      exit 1
      ;;
    esac
  done
}

check_deps
kill_existing_instance
parse_args "$@"

# Ask for file extension if requested
if $ASK_EXT; then
  EXT=$(wofi --dmenu --lines 1 --prompt "File extension:")
fi

create_tmpfile

if ! $WTYPE_MODE; then

  # get the currently selected and edit it if it's different from the last copy
  #
  # so it won't paste the last one if the selected is empty
  LAST_CLIPBOARD=$(wl-paste)

  hyprctl dispatch sendshortcut "CTRL,C,"

  AFTER_COPY_CLIPBOARD=$(wl-paste)

  if [[ "$LAST_CLIPBOARD" != "$AFTER_COPY_CLIPBOARD" ]]; then
    wl-paste >"$TMPFILE"

    # put the last one back
    echo "$LAST_CLIPBOARD" | wl-copy
  fi

fi

# Launch Neovim in insert mode, auto-quit on write
$TERM $TERM_OPTS nvim +startinsert +'autocmd BufWritePost <buffer> quit' "$TMPFILE"

TEXT=$(<"$TMPFILE")

# Paste the text if not empty
if [ -n "$TEXT" ]; then

  if $WTYPE_MODE; then
    # FIXME: Do shift + return if a new line is detected. Was not able to do so
    printf '%s' "$TEXT" | wtype -

  else
    cat "$TMPFILE" | wl-copy

    hyprctl dispatch sendshortcut "CTRL,V,"
  fi

else
  exit 1
fi

if $REMOVE_TMP; then
  rm -rf "$TMPFILE"
fi
