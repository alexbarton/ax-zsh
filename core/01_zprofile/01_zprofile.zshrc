# AX-ZSH: Alex' Modular ZSH Configuration
# 01_zprofile.zshrc: Make sure zpfofile files are read

[[ -z "$AXZSH_ZPROFILE_READ" ]] || return

# No "zprofile" files have been read in already! So most probably this
# ZSH instance hasn't been called from an ax-zsh enabled ZSH!

# Reset some environment variables, that could contain "garbage" ...
unset PS1

[[ -n "$AXZSH_DEBUG" ]] && echo "» 01_zprofile.zsh:"

if [[ -r "$AXZSH/cache/zprofile.cache" ]]; then
	# Cache file exists, use it!
	[[ -n "$AXZSH_DEBUG" ]] \
		&& echo "   - Reading cache file \"$AXZSH/cache/zprofile.cache\" ..."
	source "$AXZSH/cache/zprofile.cache"
else
	# No cache file, so read plugins manually. The "plugin_list" can be
	# empty, when the "zshrc" stage has been read in using the cache file,
	# but there is no cache file for the "zprofile" stage. In that case
	# the "plugin_list" must be assembled right now (see "ax.zsh" file!):
	if [[ -z "$plugin_list" ]]; then
		typeset -U plugin_list
		plugin_list=(
			"$AXZSH/core/"[0-5]*
			"$AXZSH/active_plugins/"*(N)
			"$AXZSH/core/"[6-9]*
		)
	fi
	for plugin ($plugin_list); do
		axzsh_load_plugin "$plugin" "zprofile"
	done
fi
AXZSH_ZPROFILE_READ=2

[[ -n "$AXZSH_DEBUG" ]] && echo "» 01_zprofile.zsh (end)"
