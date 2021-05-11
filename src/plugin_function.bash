# Get path to tmux configuration
get_path_to_tmux_config() {
  local default_location="$HOME/.tmux.conf"
  local xdg_location="${XDG_CONFIG_HOME:-$HOME/.config}/tmux/tmux.conf"

  if [ -f "$xdg_location" ]
  then
    echo "$xdg_location"
  else
    echo "$default_location"
  fi
}

# Return the content of the tmux configuration
_get_tmux_conf_contents() {
  cat $(get_path_to_tmux_config)
}

# Normalize plugins from tmux configuration
# Example:
# https://github.com/Alkindi42/tmux-bitwarden.git#branch => Alkindi42/tmux-bitwarden#branch
_normalize_plugins_from_conf() {
  local plugin
  local plugins_from_conf="$1"

  for plugin in $plugins_from_conf; do
    if is_url "$plugin"; then
      local user=$(basename "$(dirname "$plugin")")
      local plugin_basename=$(basename "$plugin")
      echo "$user/${plugin_basename//.git}"
    else
      echo "$plugin"
    fi
  done
}

# Get plugins from the tmux configuration
# Example: set -g @plugin 'tmux-plugins/tmux-open' => tmux-plugins/tmux-open
get_plugins_from_conf() {
  local content

  content=$(_get_tmux_conf_contents | awk '/^[ \t]*set(-option)? +-g +@plugin/ { gsub(/'\''/,""); gsub(/'\"'/,""); print $4 }')

  _normalize_plugins_from_conf "$content"
}

# Extract plugin name
# Example:
#   - Alkindi42/tmux-bitwarden => tmux-bitwarden
#   - Alkindi42/tmux-bitwarden#branch => tmux-bitwarden
#   - git://github.com/Alkindi42/tmux-bitwarden.git => tmux-bitwarden
get_plugin_name() {
  local plugin="$1"
  local plugin_basename=$(basename "$plugin")

  echo "${plugin_basename//\#*}"
}

# Get the path to the plugin
get_path_to_plugin() {
  local plugin="$1"
  local name="$(get_plugin_name "$plugin")"

  echo "$(get_tplug_path)/$name"
}

# Create tplug directory if does not exist
ensure_tplug_path_exists() {
  mkdir -p "$(get_tplug_path)"
}

# Check if plugin is already installed
plugin_already_installed() {
	local plugin="$1"
	local plugin_path="$(get_path_to_plugin "$plugin")"

	[ -d "$plugin_path" ] && cd "$plugin_path" && git remote >/dev/null 2>&1
}

is_url() {
  local plugin_name="$1"

  echo "$plugin_name" | grep -q "://"
}
