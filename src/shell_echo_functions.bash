echo_ok() {
  echo "$*" 
}

echo_err() {
  echo "$*" 1>&2
}

cecho() {
  local color="$1"
  local message="$2"

  echo -e "${COLORS["$color"]}$message${COLORS[default]}"
}

cecho_plugin_name() {
  local plugin_name="$1"
  echo -e "${COLORS[blue]}$plugin_name${COLORS[default]}"
}

print_plugin() {
  local plugin="$1"

  IFS='/' read -a plug <<< "$plugin"

  echo -en "${COLORS[magenta]}${plug[0]}${COLORS[default]}/"
  echo -en "${COLORS[blue]}${plug[1]//\#*}${COLORS[default]}"
}
