# AX-ZSH: Alex' Modular ZSH Configuration
# zsh-navigation-tools.zshrc: Initialize "ZSH Navigation Tools"

for script (
	"/usr/share/zsh-navigation-tools/zsh-navigation-tools.plugin.zsh"
	"/usr/local/share/zsh-navigation-tools/zsh-navigation-tools.plugin.zsh"
); do
	if [[ -r "$script" ]]; then
		source "$script"
		unset script
		return
	fi
done
unset script
