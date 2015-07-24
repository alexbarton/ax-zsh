# AX-ZSH: Alex' Modular ZSH Configuration
# 10_keyboard.zshrc: Initialize keyboard settings

bindkey -e

bindkey "^[[3~" delete-char
bindkey "^[3;5~" delete-char
bindkey "\e[3~" delete-char

# Allow editing of the current command line in $EDITOR
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey '\C-x\C-e' edit-command-line
