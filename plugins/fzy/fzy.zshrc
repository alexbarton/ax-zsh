# AX-ZSH: Alex' Modular ZSH Configuration
# fzy.zshrc: Setup Git

axzsh_is_modern_terminal || return 91

# Make sure that "fzy(1)" is installed
(( $+commands[fzy] )) || return 1

function history-fzy() {
	BUFFER=$(fc -lnr 0 | fzy -l $((LINES/2)) -q "$LBUFFER")
	CURSOR=$#BUFFER
	zle reset-prompt
}

zle -N history-fzy
bindkey '^r' history-fzy

return 0
