# AX-ZSH: Alex' Modular ZSH Configuration
# buku.zshrc: Setup buku(1)

# Make sure that "buku(1)" is installed
(( $+commands[buku] )) || return

alias b='buku --suggest'
