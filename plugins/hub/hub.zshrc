# AX-ZSH: Alex' Modular ZSH Configuration
# hub.zshrc: Setup hub(1)

# Make sure that "git(1)" and "hub(1)" are installed
(( $+commands[git] )) || return
(( $+commands[hub] )) || return

alias git="hub"
