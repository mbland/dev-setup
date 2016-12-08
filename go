#! /usr/bin/env bash

. "${0%/*}/scripts/go-script-bash/go-core.bash" "scripts"
. "$_GO_USE_MODULES" 'log'

if [[ "$#" -eq 0 ]]; then
  @go.setup_project 'install'
else
  @go "$@"
fi
