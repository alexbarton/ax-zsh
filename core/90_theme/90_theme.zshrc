# AX-ZSH: Alex' Modular ZSH Configuration
# 90_theme.zshrc: Load AX-ZSH theme

[[ -n "$AXZSH_THEME" ]] && source "$AXZSH_THEME"

axzsh_is_dumb_terminal && unset RPS1
