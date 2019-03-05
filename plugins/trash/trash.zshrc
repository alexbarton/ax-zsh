# AX-ZSH: Alex' Modular ZSH Configuration
# trash.zshrc: Setup trash(1)

# Make sure that "trash(1)" is installed
(( $+commands[trash] )) || return

alias rm='trash -F'
