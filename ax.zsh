# AX-ZSH: Alex' Modular ZSH Configuration
# Copyright (c) 2015 Alexander Barton <alex@barton.de>

script_name="$(basename -- "${(%):-%N}")"
script_type="$script_name[2,-1]"

[[ -f "$HOME/.axzsh.debug" ]] && echo "» $script_name:"

# Load plugin code of a given type.
# - $1: plugin name
# - $2: plugin type (optional; defaults to "zshrc")
function axzsh_load_plugin {
	plugin="$1"
	[[ -z "$2" ]] && type="zshrc" || type="$2"

	for dname (
		"$AXZSH_PLUGIN_D/$plugin"
		"$ZSH_CUSTOM/$plugin"
		"$AXZSH/plugins/$plugin"
		"$AXZSH/default_plugins/$plugin"
		"$AXZSH/core/$plugin"
	); do
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
	# Plugin not found!
	if [[ -f "$HOME/.axzsh.debug" ]]; then
		# Show error message for all stages in "debug mode":
		echo "AX-ZSH plugin \"$plugin\" not found (type \"$type\")!" >&2
	elif [[ "$type" == "zshrc" ]]; then
		# Show error message for the "zshrc" stage:
		echo "AX-ZSH plugin \"$plugin\" not found, skipped!" >&2
	fi
	return 1
}

# Make sure that "AXZSH" variable is set and exported
if [[ -z "$AXZSH" ]]; then
	export AXZSH="$HOME/.axzsh"
	if [[ -f "$HOME/.axzsh.debug" ]]; then
		echo "AXZSH=$AXZSH"
		echo "AXZSH_PLUGIN_D=$AXZSH_PLUGIN_D"
	fi
fi

# Setup list of default plugins if not set already. This allows users to
# overwrite this list in their "~/.zshenv" file, for example.
typeset -U axzsh_default_plugins
if ! typeset +m axzsh_default_plugins | fgrep array >/dev/null 2>&1; then
	axzsh_default_plugins=(
		$AXZSH/default_plugins/*
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
for plugin ($plugin_list); do
	axzsh_load_plugin "$(basename "$plugin")" "$script_type"
done
unset script_name script_type plugin
unset plugin_list
