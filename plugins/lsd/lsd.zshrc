# AX-ZSH: Alex' Modular ZSH Configuration
# lsd.zshrc: Setup LSD (LSDeluxe), the next gen ls command.

# Make sure that "lsd(1)" is installed
(( $+commands[lsd] )) || return 1

alias ls='lsd'
