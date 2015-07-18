# AX-ZSH: Alex' Modular ZSH Configuration
# mosh.zshrc: Setup mosh(1)

# Make sure that "mosh(1)" is installed
(( $+commands[mosh] )) || return

# Use the SSH completions for mosh, too
compdef mosh=ssh
