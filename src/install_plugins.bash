#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source "$CURRENT_DIR/constants.bash"
source "$CURRENT_DIR/tplug_functions.bash"
source "$CURRENT_DIR/plugin_function.bash"


_clone() {
	local plugin="$1"
  local branch="$2"

  if [ -z $branch ]; then
    cd "$(get_tplug_path)" &&
      GIT_TERMINAL_PROMPT=0 git clone --recursive --quiet "$plugin"
  else
    cd "$(get_tplug_path)" &&
      GIT_TERMINAL_PROMPT=0 git clone -b "$branch" --recursive --quiet "$plugin"
  fi
}

# Tries cloning:
# 1. plugin name directly - works if it's a valid git url
# 2. expands the plugin name to point to a github repo and tries cloning again
_clone_plugin() {
	local plugin="$1"
  local branch="$2"

  if is_url "$plugin"; then
    _clone "$plugin" "$branch"
  else
    _clone "https://git::@github.com/$plugin" "$branch"
  fi
}

install_plugin() {
  local plugin="$1"
  local branch="$2"
  local plugin_name="$(get_plugin_name "$plugin")"

  if plugin_already_installed "$plugin"; then
    echo_ok "$(print_plugin "$plugin") already installed"
  else
    echo -n "Downloading $(print_plugin "$plugin")..."
    _clone_plugin "$plugin" "$branch" && echo_ok "installed" || echo_err "error $?"
  fi
}

install_plugins() {
  set_tplug_path
  ensure_tplug_path_exists

  local plugin

  for plugin in $(get_plugins_from_conf); do
    IFS='#' read -ra plugin <<< "$plugin"

    install_plugin "${plugin[0]}" "${plugin[1]}"
  done
}
