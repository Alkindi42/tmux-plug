typeset -A COLORS=(
  default $'\e[0m'
  red     $'\e[31m'
  green   $'\e[32m'
  magenta $'\e[35m'
  blue    $'\e[38;5;110m'
)

PLUGIN_NAME="tmux-plug"

# Default path where plugins are located.
DEFAULT_TPLUG_PATH="$HOME/.tmux/plugins"

# Default key bindings
default_install_key="I"
install_key_option="@tplug-install"

default_clean_key="M-u"
clean_key_option="@tplug-clean"

default_update_key="U"
update_key_option="@tplug-update"
