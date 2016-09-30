#! /usr/bin/env bash

. "${0%/*}/scripts/go-script-bash/go-core.bash" "scripts"

declare -x _DOTFILES=()

if shopt -s globstar 2>/dev/null; then
  GLOBIGNORE=".git*:.*.swp:.DS_Store:*/**/.*.swp:*/**/.DS_Store"
  shopt -u globstar
else
  GLOBIGNORE=".git*:*.*.swp:*.DS_Store"
fi

find_dotfiles() {
  local _dotfile
  for _dotfile in "$@"; do
    if [[ ! -d "$_dotfile" ]]; then
      _DOTFILES+=("$_dotfile")
    else
      find_dotfiles $_dotfile/*
    fi
  done
}

find_dotfiles .*

@go "$@"
