reload_tmux_environment() {
  tmux source-file $(get_path_to_tmux_config)
}

# Display tmux message in status bar
display_tmux_message() {
  local message="$1"

  tmux display-message "tplug: $message"
}
