# AX-ZSH: Alex' Modular ZSH Configuration
# bat.zshrc: Setup bat(1)

# Make sure that "bat(1)" is installed or "batcat(1)" is available:
if ! (( $+commands[bat] )); then
	(( $+commands[batcat] )) || return 1
	alias bat='batcat'
fi

return 0
