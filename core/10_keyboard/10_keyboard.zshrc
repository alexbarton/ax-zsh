# AX-ZSH: Alex' Modular ZSH Configuration
# 10_keyboard.zshrc: Initialize keyboard settings

bindkey -e

# Allow editing of the current command line in $EDITOR
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey '\C-x\C-e' edit-command-line
