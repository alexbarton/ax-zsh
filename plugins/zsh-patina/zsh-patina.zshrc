# AX-ZSH: Alex' Modular ZSH Configuration
# zsh-patina.zshrc: Setup zsh-patina, a blazingly fast Zsh syntax highlighter.

axzsh_is_modern_terminal || return 91

# Make sure that "zsh-patina" is installed
(( $+commands[zsh-patina] )) || return 1

eval "$(zsh-patina activate)"
