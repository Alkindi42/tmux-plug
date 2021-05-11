#/usr/bin//env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source "$CURRENT_DIR/constants.bash"
source "$CURRENT_DIR/tplug_functions.bash"
source "$CURRENT_DIR/plugin_function.bash"

clean_plugins() {
  set_tplug_path 
  ensure_tplug_path_exists

  local plugin_name
  local has_deleted=false
  local plugin_directory
  local plugins="$(get_plugins_from_conf)"

  for plugin_directory in "$(get_tplug_path)"/*; do
    [ -d "$plugin_directory" ] || continue

    plugin_name="$(get_plugin_name "$plugin_directory")"

		case "${plugins}" in
			*"${plugin_name}"*) :;;
			*)

      [ "${plugin_name}" = "$PLUGIN_NAME" ] && continue

      has_deleted=true

      # Remove plugin directory
      rm -rf "${plugin_directory}" >/dev/null 2>&1

      [ ! -d "${plugin_directory}" ] &&
        echo "$(cecho_plugin_name $plugin_name) deleted" || 
        echo "$(cecho_plugin_name $plugin_name) error"
			;;
		esac
  done

  if [ "$has_deleted" = false ]; then
    echo_ok "Nothing to clean"
  fi
}
