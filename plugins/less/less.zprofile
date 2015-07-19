# AX-ZSH: Alex' Modular ZSH Configuration
# less.zprofile: Setup less

# Make sure that "less(1)" is installed
(( $+commands[less] )) || return

export LESS="-FmRX"

(( $+commands[lesspipe] )) && eval $(lesspipe)
