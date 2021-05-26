# Load only installed plugins
# No errors raised if directory does not exist (the plugin is not installed)
_load_plugin_silently() {
  local plugin_path="$1"
  local tmux_files="$plugin_path/*.tmux"

  if [ -d "$plugin_path" ]
  then
    for tmux_file in $tmux_files
    do
      "$tmux_file" > /dev/null 2>&1
    done
  fi
}

load_plugins() {
  local plugin

  for plugin in $(get_plugins_from_conf); do
    _load_plugin_silently "$(get_path_to_plugin "$plugin")"
  done
}
