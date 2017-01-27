# AX-ZSH: Alex' Modular ZSH Configuration
# pdfman.zshrc: Setup PDFman

# Make sure that "pdfman" script is installed
(( $+commands[pdfman] )) || return

alias man='nocorrect pdfman'
