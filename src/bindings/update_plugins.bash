#!/usr/bin/env bash

BINDING_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source "$BINDING_DIR/../update_plugins.bash"

source "$BINDING_DIR/../tmux_functions.bash"
source "$BINDING_DIR/../tmux_echo_functions.bash"


main() {
  reload_tmux_environment
  display_tmux_message "Updating plugins..."
  update_plugins
  reload_tmux_environment
}

main
