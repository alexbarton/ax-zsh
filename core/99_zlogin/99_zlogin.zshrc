# AX-ZSH: Alex' Modular ZSH Configuration
# 99_zlogin.zshrc: Make sure zpfofile files are read

[[ "$AXZSH_ZPROFILE_READ" = "2" ]] || return

# No "zlogin" files have been read in already! So most probably this
# ZSH instance hasn't been called from an ax-zsh enabled ZSH!

[[ -f "$HOME/.axzsh.debug" ]] && echo "» 99_zlogin.zsh:"
for plugin ($plugin_list); do
	axzsh_load_plugin "$(basename "$plugin")" "zlogin"
done
AXZSH_ZLOGIN_READ=2
[[ -f "$HOME/.axzsh.debug" ]] && echo "» 99_zlogin.zsh (end)"
