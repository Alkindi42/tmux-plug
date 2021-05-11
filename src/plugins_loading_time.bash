plugins_loading_time() {
  local tmux_files
  local plugin plugin_path
  local start end total_time time_elapsed

  set_tplug_path 

  for plugin in $(get_plugins_from_conf); do
    plugin_path="$(get_path_to_plugin "$plugin")"
    tmux_files="$plugin_path/*.tmux"


    if [ -d "$plugin_path" ]; then
      for tmux_file in $tmux_files; do
        start=$(($(date +%s%N)/1000000))
        "$tmux_file" > /dev/null 2>&1
        end=$(($(date +%s%N)/1000000))

        time_elapsed=$(( $end - $start ))
        printf "%5s ms - %s\n" "$time_elapsed" "$(print_plugin "$plugin")"
      done
    fi
  done
}
