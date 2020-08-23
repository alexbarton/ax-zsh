# AX-ZSH: Alex' Modular ZSH Configuration
# history.zshrc: Setup ZSH history

HISTSIZE=10000
SAVEHIST=10000

setopt append_history
setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_verify
setopt histignorealldups
setopt histignorespace
setopt inc_append_history
setopt share_history

alias history='fc -il 1'
