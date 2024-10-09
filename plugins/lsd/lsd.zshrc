# AX-ZSH: Alex' Modular ZSH Configuration
# lsd.zshrc: Setup LSD (LSDeluxe), the next gen ls command.

axzsh_is_modern_terminal || return 91

# Make sure that "lsd(1)" is installed
(( $+commands[lsd] )) || return 1

alias ls='lsd'
