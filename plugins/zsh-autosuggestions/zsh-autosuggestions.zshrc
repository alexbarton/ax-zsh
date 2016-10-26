# AX-ZSH: Alex' Modular ZSH Configuration
# zsh-autosuggestions.zshrc: Initialize "Fish-like autosuggestions for zsh"

axzsh_is_dumb_terminal && return 1

for script (
	"/usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
	"/usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
); do
	if [[ -r "$script" ]]; then
		source "$script"
		unset script
		return 0
	fi
done
unset script
return 1
