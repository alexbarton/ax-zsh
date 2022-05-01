# AX-ZSH: Alex' Modular ZSH Configuration
# trash.zshrc: Setup trash(1)

# Make sure that "bat(1)" is installed
(( $+commands[bat] )) && return 0

if (( $+commands[batcat] )); then
	alias bat='batcat'
	return 0
fi

return 1
