#! /usr/bin/env bash

declare GO_SCRIPTS_DIR="${GO_SCRIPTS_DIR:-scripts}"
declare GO_SCRIPT_BASH_VERSION="${GO_SCRIPT_BASH_VERSION:-v1.5.0}"
declare GO_SCRIPT_BASH_CORE_DIR="${GO_SCRIPT_BASH_CORE_DIR:-${0%/*}/$GO_SCRIPTS_DIR/go-script-bash}"
declare GO_SCRIPT_BASH_REPO_URL="${GO_SCRIPT_BASH_REPO_URL:-https://github.com/mbland/go-script-bash.git}"

if [[ ! -e "$GO_SCRIPT_BASH_CORE_DIR/go-core.bash" ]]; then
  printf "Cloning framework from '%s'...\n" "$GO_SCRIPT_BASH_REPO_URL"
  if ! git clone --depth 1 -c advice.detachedHead=false \
      -b "$GO_SCRIPT_BASH_VERSION" "$GO_SCRIPT_BASH_REPO_URL" \
      "$GO_SCRIPT_BASH_CORE_DIR"; then
    printf "Failed to clone '%s'; aborting.\n" "$GO_SCRIPT_BASH_REPO_URL" >&2
    exit 1
  fi
  printf "Clone of '%s' successful.\n\n" "$GO_SCRIPT_BASH_REPO_URL"
fi

. "$GO_SCRIPT_BASH_CORE_DIR/go-core.bash" "$GO_SCRIPTS_DIR"
. "$_GO_USE_MODULES" 'log'
. "${0%/*}/settings.bash"


if [[ "$#" -eq 0 ]]; then
  @go.setup_project 'install'
else
  @go "$@"
fi
