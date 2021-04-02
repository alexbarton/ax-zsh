# AX-ZSH: Alex' Modular ZSH Configuration
# googler.zshrc: Setup googler(1)

# Make sure that "googler(1)" are installed
(( $+commands[googler] )) || return

alias g0="googler --show-browser-logs -n $((LINES/6))"
