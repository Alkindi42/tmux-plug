tmux_echo() {
  local message="$1"

  tmux run-shell "echo $1"
}

echo_ok() {
  tmux_echo "$*" 
}

echo_err() {
  tmux_echo "$*" 
}

cecho() {
  echo_ok "$*"
}

print_plugin() {
  local plugin="$1"

  echo "${plugin//\#*}"
}

cecho_plugin_name() {
  local plugin_name="$1"

  echo "$plugin_name"
}
