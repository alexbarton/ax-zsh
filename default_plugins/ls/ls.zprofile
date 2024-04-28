# AX-ZSH: Alex' Modular ZSH Configuration
# ls.zshrc: Setup ls(1)

if [[ -r ~/.local/share/lscolors.sh ]]; then
	# Read lscolors.sh, which should set LS_COLORS;
	# see <https://github.com/trapd00r/LS_COLORS>.
	source ~/.local/share/lscolors.sh
elif (( $+commands[dircolors] )); then
	# Use dircolors(1):
	eval $(dircolors)
fi
