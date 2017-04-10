# AX-ZSH: Alex' Modular ZSH Configuration
# Copyright (c) 2015-2017 Alexander Barton <alex@barton.de>

script_name="${${(%):-%N}:t}"
script_type="$script_name[2,-1]"

# Load plugin code of a given type.
# - $1: plugin name
# - $2: plugin type (optional; defaults to "zshrc")
# - $3: cache file (optional)
function axzsh_load_plugin {
	local dname="$1:A"
	local plugin="$dname:t"
	[[ -z "$2" ]] && local type="zshrc" || local type="$2"
	local fname="$dname/$plugin.$type"
	local cache_file="$3"

	# Strip repository prefix (like "alexbarton#test-plugin"):
	[[ "$plugin" =~ "#" ]] && plugin=$(echo $plugin | cut -d'#' -f2-)

	# "short plugin name": strip ".zsh" suffix:
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
			return 0
		fi
	fi

	if [[ "$type" == "zprofile" && -d "$dname/functions" ]]; then
		# Add plugin function path when folder exists
		[[ -n "$AXZSH_DEBUG" ]] \
			&& echo "   - $plugin ($type): functions ..."
		axzsh_fpath+=("$dname/functions")
	fi

	if [[ -r "$fname" ]]; then
		# Read plugin ...
		[[ -n "$AXZSH_DEBUG" ]] \
			&& echo "   - $plugin ($type) ..."
		source "$fname"

		if [[ -n "$cache_file" ]]; then
			# Add plugin data to cache
			printf "# BEGIN: %s\nax_plugin_init()\n{\n" "$fname" >>"$cache_file"
			case "$fname" in
				*"/repos/"*)
					echo "[[ -n \"\$AXZSH_DEBUG\" ]] && echo '     - $plugin ($type): \"$fname\" ...'" >>$cache_file
					echo "source '$fname'" >>$cache_file
					;;
				*)
					echo "[[ -n \"\$AXZSH_DEBUG\" ]] && echo '     - $plugin ($type, cached) ...'" >>$cache_file
					"$cat_cmd" "$fname" >>"$cache_file"
			esac
			printf "}\nax_plugin_init\n# END: %s\n\n" "$fname" >>"$cache_file"
		fi
	fi

	# It is a success, even if only the plugin directory (and no script!)
	# exists at all! Rationale: The script could be of an other type ...
	return 0
}

# Make sure that "my" (=ZSH) directory is in the search path ...
if [[ -z "$AXZSH" ]]; then
	_p="${0:h}"
	[[ "$_p" != "." ]] && PATH="$PATH:${0:h}"
	unset _p
fi

# Make sure that "SHELL" variable is set and exported
[[ -n "$SHELL" ]] || export SHELL=$(command -v zsh)

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

# Initialize cache
mkdir -p "$AXZSH/cache"
cache_file="$AXZSH/cache/$script_type.cache"

cat_cmd=${commands[cat]:-cat}

if [[ -r "$cache_file" ]]; then
	# Cache file exists, use it!
	# But when in the "zshrc" stage, make sure that the "zprofile" stage
	# has already been handled (this uses the "01_zprofile" plugin which
	# is used in the "zshrc.cache" as well, but can't be used successfully
	# there because it becomes sourced inside of a ZSH function; so we have
	# to source it here in the global context manually ...):
	[[ -z "$AXZSH_ZPROFILE_READ" && "$script_type" = "zshrc" ]] \
		&& source "$AXZSH/core/01_zprofile/01_zprofile.zshrc"
	[[ -n "$AXZSH_DEBUG" ]] \
		&& echo "   - Reading cache file \"$cache_file\" ..."
	source "$cache_file"
	unfunction ax_plugin_init
else
	# No cache file available.
	# Setup list of plugins to load:
	typeset -U plugin_list
	plugin_list=(
		"$AXZSH/core/"[0-5]*
		"$AXZSH/active_plugins/"*(N)
		"$AXZSH/core/"[6-9]*
	)

	# Create new cache file:
	if [[ -n "$cache_file" ]]; then
		[[ -n "$AXZSH_DEBUG" ]] \
			&& echo "   (Writing new cache file to \"$cache_file\" ...)"
		printf "# %s\n\n" "$(LC_ALL=C date)" >"$cache_file"
	fi

	# Read in all the plugins for the current "type":
	for plugin ($plugin_list); do
		axzsh_load_plugin "$plugin" "$script_type" "$cache_file"
	done
fi

# Clean up ...
unfunction axzsh_load_plugin
unset script_name script_type plugin
unset plugin_list
unset cache_file
unset cat_cmd
