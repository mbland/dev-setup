#! /usr/bin/env bash

. "${0%/*}/scripts/go-script-bash/go-core.bash" "scripts"
. "$_GO_USE_MODULES" 'log'
. "${0%/*}/settings.bash"

if [[ "$#" -eq 0 ]]; then
  @go.setup_project install "$APPS_ROOT"
else
  @go "$@"
fi
