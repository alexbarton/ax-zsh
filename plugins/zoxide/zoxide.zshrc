# AX-ZSH: Alex' Modular ZSH Configuration
# zoxide.zshrc: Initialize "zoxide"

# Make sure that "zoxide" is installed
(( $+commands[zoxide] )) || return 1

# Do not run in check mode, return success immediately.
[[ -z "$AXZSH_PLUGIN_CHECK" ]] || return 0

eval "$(zoxide init zsh)"
