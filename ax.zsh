# AX-ZSH: Alex' Modular ZSH Configuration
# Copyright (c) 2015-2016 Alexander Barton <alex@barton.de>

script_name="${${(%):-%N}:t}"
script_type="$script_name[2,-1]"

# Load plugin code of a given type.
# - $1: plugin name
# - $2: plugin type (optional; defaults to "zshrc")
function axzsh_load_plugin {
	dname="$1:A"
	plugin="$dname:t"
	[[ -z "$2" ]] && type="zshrc" || type="$2"
	fname="$dname/$plugin.$type"

	[[ "$plugin" =~ "#" ]] && plugin=$(echo $plugin | cut -d'#' -f2-)

	plugin_short=${plugin%.zsh}

	if [[ ! -d "$dname" ]]; then
		# Plugin not found!
		if [[ -n "$AXZSH_DEBUG" ]]; then
			# Show error message for all stages in "debug mode":
			echo "AX-ZSH plugin \"$plugin\" not found (type \"$type\")!" >&2
		elif [[ "$type" == "zshrc" ]]; then
			# Show error message for the "zshrc" stage:
			echo "AX-ZSH plugin \"$plugin\" not found, skipped!" >&2
		fi
		return 1
	fi

	if [[ ! -r "$fname" && "$type" == "zshrc" ]]; then
		if [[ -r "$dname/$plugin.zprofile" || -r "$dname/$plugin.zlogout" ]]; then
			# Native AX-ZSH plugin, but for different stage. Skip it!
			:
		elif [[ -r "$dname/${plugin_short}.plugin.zsh" ]]; then
			# Oh My ZSH plugin
			type="plugin.zsh"
			fname="$dname/${plugin_short}.plugin.zsh"
		elif [[ -r "$dname/init.zsh" ]]; then
			# Prezto module
			type="init.zsh"
			fname="$dname/init.zsh"
		else
			echo "AX-ZSH plugin type of \"$plugin\" unknown, skipped!" >&2
		fi
	fi

	if [[ "$type" == "zprofile" && -d "$dname/functions" ]]; then
		# Add plugin function path when folder exists
		axzsh_fpath+=("$dname/functions")
	fi

	if [[ -r "$fname" ]]; then
		[[ -n "$AXZSH_DEBUG" ]] \
			&& echo "   - $plugin ($type) ..."
		source "$fname"
	fi

	# It is a success, even if only the plugin directory (and no script!)
	# exists at all! Rationale: The script could be of an other type ...
	return 0
}

# Make sure that "AXZSH" variable is set and exported
if [[ -z "$AXZSH" ]]; then
	export AXZSH="$HOME/.axzsh"
	if [[ -f "$HOME/.axzsh.debug" ]]; then
		export AXZSH_DEBUG=1
		echo "AXZSH=$AXZSH"
		echo "AXZSH_DEBUG=$AXZSH_DEBUG"
		echo "AXZSH_PLUGIN_D=$AXZSH_PLUGIN_D"
	fi
fi

[[ -n "$AXZSH_DEBUG" ]] && echo "» $script_name:"

# Setup list of plugins to load:
typeset -U plugin_list
plugin_list=(
	"$AXZSH/core/"[0-5]*
	"$AXZSH/active_plugins/"*(N)
	"$AXZSH/core/"[6-9]*
)

# Read in all the plugins for the current "type":
for plugin ($plugin_list); do
	axzsh_load_plugin "$plugin" "$script_type"
done
unfunction axzsh_load_plugin
unset script_name script_type plugin
unset plugin_list
