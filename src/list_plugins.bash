#/usr/bin//env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source "$CURRENT_DIR/constants.bash"
source "$CURRENT_DIR/tplug_functions.bash"
source "$CURRENT_DIR/plugin_function.bash"

list_plugins() {
  set_tplug_path 
  ensure_tplug_path_exists

  for plugin_directory in "$(get_tplug_path)"/*; do
    [ -d "$plugin_directory" ] || continue

    echo "$(get_plugin_name "$plugin_directory")"
  done
}
