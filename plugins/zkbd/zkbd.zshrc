# AX-ZSH: Alex' Modular ZSH Configuration
# zkbd.zshrc: Initialize ZKBD Keybindings

[[ -z "$AXZSH_PLUGIN_CHECK" ]] || return 92

autoload -Uz zkbd

[[ ! -f ${ZDOTDIR:-$HOME}/.zkbd/$TERM-$VENDOR-$OSTYPE ]] && zkbd
source ${ZDOTDIR:-$HOME}/.zkbd/$TERM-$VENDOR-$OSTYPE

[[ -n "${key[Backspace]}" ]] && bindkey "${key[Backspace]}" backward-delete-char
[[ -n "${key[Delete]}" ]] && bindkey "${key[Delete]}" delete-char
[[ -n "${key[Insert]}" ]] && bindkey "${key[Insert]}" overwrite-mode

[[ -n "${key[Home]}" ]] && bindkey "${key[Home]}" beginning-of-line
[[ -n "${key[End]}" ]] && bindkey "${key[End]}" end-of-line

[[ -n "${key[PageUp]}" ]] && bindkey "${key[PageUp]}" up-line-or-history
[[ -n "${key[PageDown]}" ]] && bindkey "${key[PageDown]}" down-line-or-history

[[ -n "${key[Up]}" ]] && bindkey "${key[Up]}" up-line-or-search
[[ -n "${key[Down]}" ]] && bindkey "${key[Down]}" down-line-or-search
[[ -n "${key[Left]}" ]] && bindkey "${key[Left]}" backward-char
[[ -n "${key[Right]}" ]] && bindkey "${key[Right]}" forward-char

[[ -n "${key[C-Up]}" ]] && bindkey "${key[C-Up]}" history-beginning-search-backward
[[ -n "${key[C-Down]}" ]] && bindkey "${key[C-Down]}" history-beginning-search-forward
[[ -n "${key[C-Left]}" ]] && bindkey "${key[C-Left]}" backward-word
[[ -n "${key[C-Right]}" ]] && bindkey "${key[C-Right]}" forward-word
