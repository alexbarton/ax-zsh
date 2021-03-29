# AX-ZSH: Alex' Modular ZSH Configuration
# Copyright (c) 2015-2020 Alexander Barton <alex@barton.de>

script_name="${${(%):-%N}:t}"
script_type="$script_name[2,-1]"

# Handle "initialization stage", load all plugins of that stage, either from an
# existing cache file or individually, optionally creating the cache.
# - $1: Script name
# - $2: Stage name (ax-io, zprofile, zshrc, zlogin, zlogout)
function axzsh_handle_stage {
	local name="$1"
	local type="$2"

	[[ -n "$AXZSH_DEBUG" ]] && echo "» $name ($type):"

	# Look for some 3rd-party integrations ...

	# --- Powerlevel10k ---
	# Read in Powerlevel10k configuration file, if not already read:
	[[ -z "$POWERLEVEL9K_CONFIG_FILE" && -r ~/.p10k.zsh ]] && source ~/.p10k.zsh
	# Enable instant prompt. Should stay close to the top of ~/.zshrc.
	# Initialization code that may require console input (password prompts,
	# [y/n] confirmations, etc.) must be executed before this, so all ax-zsh
	# plugings should do output in their "ax-io" stage only!
	if [[ "$type" == "zprofile" ]]; then
		p10k_instant_prompt="${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
		[[ -r "$p10k_instant_prompt" ]] && source "$p10k_instant_prompt"
	fi

	# Initialize cache
	mkdir -p "$AXZSH/cache"
	local cache_file="$AXZSH/cache/$type.cache"

	local cat_cmd=${commands[cat]:-cat}

	if [[ -r "$cache_file" ]]; then
		# Cache file exists, use it!
		# But when in the "zshrc" stage, make sure that the "zprofile" stage
		# has already been handled (this uses the "01_zprofile" plugin which
		# is used in the "zshrc.cache" as well, but can't be used successfully
		# there because it becomes sourced inside of a ZSH function; so we have
		# to source it here in the global context manually ...):
		[[ -z "$AXZSH_ZPROFILE_READ" && "$type" = "zshrc" ]] \
			&& source "$AXZSH/core/01_zprofile/01_zprofile.zshrc"
		[[ -n "$AXZSH_DEBUG" ]] \
			&& echo "   - Reading cache file \"$cache_file\" ..."
		source "$cache_file"
		unfunction ax_plugin_init
	else
		# No cache file available.
		# Setup list of plugins to load:
		local plugin_list
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
			# Read the "theme file", if any and in "zshrc" stage.
			# This must be done before 99_cleanup is run!
			if [[ "$plugin:t" == "99_cleanup" && "$type" = "zshrc" ]]; then
				if [[ -r "$AXZSH_THEME" ]]; then
					source "$AXZSH_THEME"
					if [[ -n "$cache_file" ]]; then
						# Source the theme in the new cache file:
						echo "# BEGIN Theme" >>"$cache_file"
						echo 'source "$AXZSH_THEME"' >>"$cache_file"
						echo "# END Theme" >>"$cache_file"
					fi
				fi
			fi
			axzsh_load_plugin "$plugin" "$type" "$cache_file"
		done
	fi
}

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
		zsh_themes=("$dname/"*.zsh-theme(NY1))
		if [[ -r "$dname/$plugin.ax-io" || -r "$dname/$plugin.zprofile" || -r "$dname/$plugin.zlogout" ]]; then
			# Native AX-ZSH plugin, but for different stage. Skip it!
			:
		elif [[ -r "$dname/${plugin_short}.plugin.zsh" ]]; then
			# Oh My ZSH plugin
			type="plugin.zsh"
			fname="$dname/${plugin_short}.plugin.zsh"
		elif [[ -r "$dname/${plugin_short##zsh-}.plugin.zsh" ]]; then
			# Oh My ZSH plugin with "zsh-" prefix stripped
			type="plugin.zsh"
			fname="$dname/${plugin_short##zsh-}.plugin.zsh"
		elif [[ -r "$dname/${plugin%.plugin.zsh}.plugin.zsh" ]]; then
			# Oh My ZSH plugin with ".plugin.zsh" suffix in its name
			type="plugin.zsh"
			fname="$dname/${plugin}"
		elif [[ -r "$dname/init.zsh" ]]; then
			# Prezto module
			type="init.zsh"
			fname="$dname/init.zsh"
		elif [[ ${#zsh_themes} -gt 0 ]]; then
			# ZSH "theme plugin", ignore here!
			:
		else
			echo "AX-ZSH plugin type of \"$plugin\" unknown, skipped!" >&2
			echo "Contents of \"$dname\":" >&2
			ls -lh "$dname/" >&2
			return 0
		fi
	fi

	if [[ "$type" == "zprofile" && -d "$dname/functions" ]]; then
		# Add plugin function path when folder exists
		[[ -n "$AXZSH_DEBUG" ]] \
			&& echo "   - $plugin ($type): functions ..."
		axzsh_fpath+=("$dname/functions")

		# Add function path to cache file.
		[[ -n "$cache_file" ]] \
			&& echo "axzsh_fpath+=('$dname/functions')" >>$cache_file
	fi

	if [[ -r "$fname" ]]; then
		# Read plugin ...
		[[ -n "$AXZSH_DEBUG" ]] \
			&& echo "   - $plugin ($type) ..."

		# Note for "external" ("repo/*") plugins and unusual ("not so
		# modern") terminals: These (modern?) plugins most probably
		# don't expect such a terminal configuration and don't behave
		# well (echo color sequences, for example). Therefore we DON'T
		# load any external plugins at all in that case: this results in
		# reduced/disabled functionality, but hopefully in readable
		# output ...

		case "$fname" in
			*"/repos/"*)
				axzsh_is_modern_terminal && source "$fname"
				;;
			*)
				source "$fname"
		esac

		if [[ -n "$cache_file" ]]; then
			# Add plugin data to cache
			printf "# BEGIN: %s\nax_plugin_init()\n{\n" "$fname" >>"$cache_file"
			case "$fname" in
				*"/repos/"*)
					echo "[[ -n \"\$AXZSH_DEBUG\" ]] && echo '     - $plugin ($type): \"$fname\" ...'" >>$cache_file
					echo "axzsh_is_modern_terminal && source '$fname'" >>$cache_file
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
[[ -n "$AXZSH" ]] || export AXZSH="$HOME/.axzsh"

# Check for "debug mode" ...
if [[ -f "$AXZSH/debug" || -f "$HOME/.axzsh.debug" ]]; then
	export AXZSH_DEBUG=1
	echo "AXZSH=$AXZSH"
	echo "AXZSH_DEBUG=$AXZSH_DEBUG"
	echo "AXZSH_PLUGIN_D=$AXZSH_PLUGIN_D"
	echo "AXZSH_ZLOGIN_READ=$AXZSH_ZLOGIN_READ"
	echo "AXZSH_ZPROFILE_READ=$AXZSH_ZPROFILE_READ"
fi

if [[ "$script_type" = "zprofile" ]]; then
	# Load all "output" plugins first, that is, before the "zprofile stage":
	axzsh_handle_stage "$script_name" "ax-io"
fi

axzsh_handle_stage "$script_name" "$script_type"

# Clean up ...
unfunction axzsh_handle_stage axzsh_load_plugin
unset script_name script_type

# Hints for external installers:
# - iTerm2: DON'T install "iterm2_shell_integration"!
