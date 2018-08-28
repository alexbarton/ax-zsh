# AX-ZSH: Alex' Modular ZSH Configuration
# colormake.zshrc: Setup colormake(1)

# Make sure that "make(1)" and "colormake(1)" are installed
(( $+commands[make] )) || return
(( $+commands[colormake] )) || return

alias make="colormake"
