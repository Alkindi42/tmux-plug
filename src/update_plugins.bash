#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source "$CURRENT_DIR/constants.bash"
source "$CURRENT_DIR/tplug_functions.bash"
source "$CURRENT_DIR/plugin_function.bash"

show_git_log() {
  local head="$1"

  if [ -n "$TMUX" ]; then
    GIT_TERMINAL_PROMPT=0 git --no-pager log --color --date=short --pretty=format:'%cd %h %s %d' "$head" 2> /dev/null
  else
    GIT_TERMINAL_PROMPT=0 git --no-pager log --color --date=short --pretty=format:'%Cgreen%cd %h %Creset%s %Cred%d%Creset' "$head" 2> /dev/null
  fi
}

update() {
  local log
  local plugin="$1"
  local branch="$2"
	local plugin_path="$(get_path_to_plugin "$plugin")"

  echo "Updating $(print_plugin "$plugin")"
  cd "$plugin_path" && GIT_TERMINAL_PROMPT=0 git fetch --quiet

  if [ -z $branch ]; then
    (git checkout -q master || git checkout -q main) > /dev/null 2>&1
    log=$(show_git_log "..origin/master")
    if [ $? -ne 0 ]; then
      log=$(show_git_log "..origin/main")
    fi
  else
    git checkout -q "$branch" > /dev/null
    log=$(show_git_log "..origin/$branch")
  fi

  if [ ! -z "$log" ]; then
    echo "${log}"
  fi

  GIT_TERMINAL_PROMPT=0 git pull --no-stat > /dev/null 2>&1 &&
    GIT_TERMINAL_PROMPT=0 git submodule update --init --recursive
}

update_plugins() {
  set_tplug_path
  ensure_tplug_path_exists

  local plugin_name

  for plugin in $(get_plugins_from_conf); do
    if plugin_already_installed "$plugin"; then
      IFS='#' read -ra plugin <<< "$plugin"
      update "${plugin[0]}" "${plugin[1]}"
    fi
  done
}
