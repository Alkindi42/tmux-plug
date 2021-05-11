TPLUG_PATH=""

# Set tmux-plug path
set_tplug_path() {
  local tplug_path=$(get_tplug_path)

  if ! [ -n "$tplug_path" ]
  then
    # Check if the tmux configuration exists in $ HOME/.config/tmux.
    # Otherwise, we use the default tpm path.
    local default_tplug_path="$DEFAULT_TPLUG_PATH"
    local xdg_tmux_path="${XDG_CONFIG_HOME:-$HOME/.config}/tmux"

    if [ -f "$xdg_tmux_path/tmux.conf" ]
    then
      tplug_path="$xdg_tmux_path/plugins"
    else
      tplug_path="$default_tplug_path"
    fi

    [ -z "$TMUX" ] && tmux set-environment -g TMUX_PLUGIN_MANAGER_PATH "$tplug_path"
  else
    if [ ! -d "$tplug_path" ]
      then
        echo_err "The path '"$tplug_path"' does not exist, check your configuration."
        exit 1
    fi
  fi

  TPLUG_PATH="$tplug_path"
}

# Return the tplug path
get_tplug_path() {
  if [ -z "$TPLUG_PATH" ]; then
    tmux start-server \; show-environment -g "TMUX_PLUGIN_MANAGER_PATH" 2> /dev/null | cut -d"=" -f2
  else
    echo "$TPLUG_PATH"
  fi
}
