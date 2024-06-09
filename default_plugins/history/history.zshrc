# AX-ZSH: Alex' Modular ZSH Configuration
# history.zshrc: Setup ZSH history

function clear_history {
	local HISTSIZE=0
	cat /dev/null >"$HISTFILE"
	fc -R
}

[[ -n "$HISTFILE" ]] || HISTFILE="${ZDOTDIR:-$HOME}/.zsh_history"

HISTSIZE=10000
SAVEHIST=$HISTSIZE

setopt append_history
setopt extended_history
setopt hist_expire_dups_first
setopt hist_find_no_dups
setopt hist_ignore_all_dups
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_save_no_dups
setopt hist_verify
setopt inc_append_history
setopt share_history

alias history='fc -il 1'
