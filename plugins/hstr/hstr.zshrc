# AX-ZSH: Alex' Modular ZSH Configuration
# hstr.zshrc: Setup hstr

axzsh_is_modern_terminal || return 91

# Make sure that "hstr(1)" is installed
(( $+commands[hstr] )) || return 1

eval "$(hstr --show-configuration)"
