# AX-ZSH: Alex' Modular ZSH Configuration
# homebrew.zprofile -- Setup Homebrew Package Manager

# Make sure that "brew(1)" is installed
(( $+commands[brew] )) || return

[[ -d "/usr/local/share/zsh-completions" ]] \
	&& axzsh_fpath=(/usr/local/share/zsh-completions $axzsh_fpath)

completion_file="$(brew --prefix)/Library/Contributions/brew_zsh_completion.zsh"
target_file="$(dirname "$0")/functions/_brew"

[[ -r "$completion_file" && ! -r "$target_file" ]] \
	&& ln -fs "$completion_file" "$target_file"

unset completion_file target_file
