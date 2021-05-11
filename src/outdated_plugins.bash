#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source "$CURRENT_DIR/constants.bash"
source "$CURRENT_DIR/tplug_functions.bash"
source "$CURRENT_DIR/plugin_function.bash"

show_git_log() {
  local head="$1"

  GIT_TERMINAL_PROMPT=0 git --no-pager log --color --date=short --pretty=format:'%Cgreen%cd %h %Creset%s %Cred%d%Creset' "$head" 2> /dev/null
}

fetch() {
  local log
  local plugin="$1"
	local plugin_path="$(get_path_to_plugin "$plugin")"

  cd "$plugin_path" && GIT_TERMINAL_PROMPT=0 git fetch --quiet
  
  log=$(show_git_log "..origin/master")

  if [ $? -ne 0 ]; then
    log=$(show_git_log "..origin/main")
  fi

  if [ ! -z "$log" ]; then
    echo_ok "$(print_plugin "$plugin") is outdated"
    echo_ok "${log}"
  fi
}

outdated_plugins() {
  set_tplug_path
  ensure_tplug_path_exists

  for plugin in $(get_plugins_from_conf); do
    if plugin_already_installed "$plugin"; then
      fetch "$plugin"
    fi
  done
}
