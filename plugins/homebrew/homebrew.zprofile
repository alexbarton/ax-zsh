# AX-ZSH: Alex' Modular ZSH Configuration
# homebrew.zprofile -- Setup Homebrew Package Manager

# Make sure that "brew(1)" is installed
(( $+commands[brew] )) || return

[[ -d "/usr/local/share/zsh-completions" ]] \
	&& axzsh_fpath+=(/usr/local/share/zsh-completions)
