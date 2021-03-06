# AX-ZSH: Alex' Modular ZSH Configuration
# 99_zlogin.zshrc: Make sure zpfofile files are read

[[ "$AXZSH_ZPROFILE_READ" = "2" ]] || return

# No "zlogin" files have been read in already! So most probably this
# ZSH instance hasn't been called from an ax-zsh enabled ZSH!

[[ -n "$AXZSH_DEBUG" ]] && echo "» 99_zlogin.zsh:"
for plugin ($plugin_list); do
	axzsh_load_plugin "$plugin" "zlogin"
done
AXZSH_ZLOGIN_READ=2
[[ -n "$AXZSH_DEBUG" ]] && echo "» 99_zlogin.zsh (end)"
