# AX-ZSH: Alex' Modular ZSH Configuration
# editor_select.zshrc: Setup $EDITOR for the "best" available editor

# Don't run this plugin on "check-plugins"!
[[ -z "$AXZSH_PLUGIN_CHECK" ]] || return 92

[[ -n "$EDITOR" ]] && alias zshenv="$EDITOR ~/.zshenv"
