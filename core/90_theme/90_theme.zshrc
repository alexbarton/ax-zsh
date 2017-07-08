# AX-ZSH: Alex' Modular ZSH Configuration
# 90_theme.zshrc: Load AX-ZSH theme

# Read in the theme configuration.
[[ -n "$AXZSH_THEME" ]] && source "$AXZSH_THEME"

# RPS1 will cause trouble on "dumb" terminals; so reset it there!
axzsh_is_dumb_terminal && unset RPS1
