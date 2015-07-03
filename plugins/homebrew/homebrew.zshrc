# AX-ZSH: Alex' Modular ZSH Configuration
# homebrew.zshrc -- Setup Homebrew Package Manager

# Make sure that "brew(1)" is installed
(( $+commands[brew] )) || return

[[ -d "/usr/local/share/zsh-completions" ]] \
	&& fpath=(/usr/local/share/zsh-completions $fpath)
