# AX-ZSH: Alex' Modular ZSH Configuration
# thefuck.zshrc: Programatically correct mistyped console commands

# Make sure that "thefuck(1)" is installed
(( $+commands[thefuck] )) || return

eval "$(thefuck --alias)"
