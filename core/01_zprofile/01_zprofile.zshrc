# AX-ZSH: Alex' Modular ZSH Configuration
# 01_zprofile.zshrc: Make sure zpfofile files are read

[[ -z "$AXZSH_ZPROFILE_READ" ]] || return

# No "zprofile" files have been read in already! So most probably this
# ZSH instance hasn't been called from an ax-zsh enabled ZSH!

# Reset some environment variables, that could contain "garbage" ...
unset PS1

[[ -f "$HOME/.axzsh.debug" ]] && echo "» 01_zprofile.zsh:"
for plugin ($plugin_list); do
	axzsh_load_plugin "$(basename "$plugin")" "zprofile"
done
AXZSH_ZPROFILE_READ=2
[[ -f "$HOME/.axzsh.debug" ]] && echo "» 01_zprofile.zsh (end)"
