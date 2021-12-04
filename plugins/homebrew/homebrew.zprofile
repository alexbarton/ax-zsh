# AX-ZSH: Alex' Modular ZSH Configuration
# homebrew.zprofile -- Setup Homebrew Package Manager

# Make sure that "brew(1)" is installed
(( $+commands[brew] )) || return 1

eval "$(brew shellenv)"

[[ -d "$HOMEBREW_PREIX/share/zsh-completions" ]] \
	&& axzsh_fpath+=("$HOMEBREW_PREFIX/share/zsh-completions")

return 0
