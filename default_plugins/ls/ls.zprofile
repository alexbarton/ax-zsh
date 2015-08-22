# AX-ZSH: Alex' Modular ZSH Configuration
# ls.zshrc: Setup ls(1)

# Is dircolors(1) available?
if (( $+commands[dircolors] )); then
	eval $(dircolors)
fi
