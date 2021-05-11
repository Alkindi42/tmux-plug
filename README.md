# tmux-plug (tmux plugin manager)

A [tpm](https://github.com/tmux-plug/tpm)-based Tmux plugin manager.

* CLI 
* Prettier (colored)
* Display plugins loading time
* Can be used without tmux running
* Supports branch based installs
* Supports custom config file locations
* Compatible with existing plugins written for [tpm](https://github.com/tmux-plug/tpm)

## Table of Contents
- [Installation](#installation)
- [Usage](#usage)
  - [Introduction](#introduction)
  - [Install plugins](#install-plugins)
  - [Uninstall plugins](#uninstall-plugins)
  - [Update plugins](#update-plugins)
  - [CLI](#cli)
- [FAQ](#faq)

## Installation

### Requirements
* Tmux
* Git
* Bash

```bash
git clone https://github.com/Alkindi42/tmux-plug ~/.tmux/plugins/tmux-plug
```

At the bottom of your `.tmux.conf` add your plugins and load the tmux plugin manager:

```bash
# List of plugins
set -g @plugin 'Alkindi42/tmux-plug' # keep the tmux plugin manager up to date

# Other examples:
# set -g @plugin 'github_username/plugin_name'
# set -g @plugin 'github_username/plugin_name#branch'
# set -g @plugin 'git@github.com:user/plugin'
# set -g @plugin 'git@bitbucket.com:user/plugin'

# Initialize TMUX plugin manager (keep this line at the very bottom of tmux.conf)
run '~/.tmux/plugins/tmux-plug/tplug'
```

Don't forget to reload your tmux configuration:
```bash
$ tmux source ~/.tmux.conf
```

That's it!

You can find a list of awesome plugins/resources [here](https://github.com/rothgar/awesome-tmux) or [here](https://github.com/tmux-plugins/list).


## Usage

### Introduction
You can install, update and clean plugins with the CLI (tmux does not need to be running) or with key bindings. By default the key binding are the same as tpm.

### Install plugins

1. Add new plugin in your `.tmux.conf` file with `set -g @plugin ...`
2. Press `prefix` + `I` to fetch the plugin

Example:
```bash
# At the bottom of your .tmux.conf
set -g @plugin 'tmux-plug/tmux-open'
set -g @plugin 'tmux-plug/tmux-copycat'

run -b '~/.tmux/plugins/tmux-plug/tplug'
```

Instead of using the key binding you can use the CLI:
```bash
$ tplug install
```

### Uninstall plugins

1. Remove (or comment out) plugin from the list.
2. Press `prefix + alt + u` to remove the plugin.

Instead of using the key binding you can use the CLI:
```bash
$ tplug clean
```

All the plugins are installed to `~/.tmux/plugins` so alternatively you can find plugin directory there and remove it.

### Update plugins
Press `prefix + U` to update plugins or use the CLI:
```bash
$ tplug update
```

### CLI

Tmux does not need to be running.

```bash
$ tplug
Usage: tplug [COMMAND]

Commands:
update     update plugins
list       list plugins installed
outdated   list outdated plugins
times      display plugins loading times
clean      remove plugins missing from tmux configuration
install    install new plugins present in tmux configuration
```

## FAQ

### Changing plugins install directory

By default tplug installs plugins in `$XDG_CONFIG_HOME/tmux/plugins`. You can change the install path by putting this in `.tmux.conf`:

```bash
set-environment -g TMUX_PLUGIN_MANAGER_PATH '/some/other/path/'
```
