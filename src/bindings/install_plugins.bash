#!/usr/bin/env bash

BINDING_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source "$BINDING_DIR/../install_plugins.bash"

source "$BINDING_DIR/../tmux_functions.bash"
source "$BINDING_DIR/../tmux_echo_functions.bash"


main() {
  reload_tmux_environment
  install_plugins
  reload_tmux_environment
}

main
