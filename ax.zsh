# AX-ZSH: Alex' Modular ZSH Configuration
# Copyright (c) 2015 Alexander Barton <alex@barton.de>

# Load plugin code of a given type.
# - $1: plugin name
# - $2: plugin type (optional; defaults to "zshrc")
function axzsh_load_plugin {
	plugin="$1"
	[[ -z "$2" ]] && type="zshrc" || type="$2"

	for dname in \
		"$AXZSH_PLUGIN_D/$plugin" \
		"$AXZSH/plugins/$plugin" \
		"$AXZSH/core/$plugin" \
	; do
		[[ ! -d "$dname" ]] && continue

		fname="$dname/$plugin.$type"
		if [[ ! -r "$fname" && "$type" == "zshrc" ]]; then
			if [[ -r "$dname/$plugin.plugin.zsh" ]]; then
				# Oh My ZSH plugin
				type="plugin.zsh"
				fname="$dname/$plugin.plugin.zsh"
			elif [[ -r "$dname/init.zsh" ]]; then
				# Prezto module
				type="init.zsh"
				fname="$dname/init.zsh"
			fi
		fi

		if [[ -r "$fname" ]]; then
			[[ -f "$HOME/.axzsh.debug" ]] \
				&& echo "   - $plugin ($type) ..."
			source "$fname"
			return 0
		fi
		return 0
	done
	[[ -f "$HOME/.axzsh.debug" ]] \
		&& echo "Plugin \"$plugin\" not found (type \"$type\")!" >/dev/stderr
	return 1
}

# Make sure that "AXZSH" variable is set and exported
if [[ -z "$AXZSH" ]]; then
	export AXZSH="$HOME/.axzsh"
	[[ -f "$HOME/.axzsh.debug" ]] && echo "AXZSH=$AXZSH"
fi

# Setup list of default plugins if not set already. This allows users to
# overwrite this list in their "~/.zshenv" file, for example.
typeset -U axzsh_default_plugins
if ! typeset +m axzsh_default_plugins | fgrep array >/dev/null 2>&1; then
	axzsh_default_plugins=(
		byebye
		completion
		correction
		history
		ls
		prompt
		ssh
		std_aliases
		std_env
	)
fi

# Setup list of plugins to load:
typeset -U plugin_list
plugin_list=(
	$AXZSH/core/[0-5]*
	$axzsh_default_plugins
	$axzsh_plugins
	$plugins
	$AXZSH/core/[6-9]*
)

# Read in all the plugins for the current "type":
script_name="$(basename -- "${(%):-%N}")"
script_type="$script_name[2,-1]"
[[ -f "$HOME/.axzsh.debug" ]] && echo "» $script_name:"
for plugin ($plugin_list); do
	axzsh_load_plugin "$(basename "$plugin")" "$script_type"
done
unset script_name script_type plugin
unset plugin_list
