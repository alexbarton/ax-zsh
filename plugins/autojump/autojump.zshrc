# AX-ZSH: Alex' Modular ZSH Configuration
# autojump.zshrc: Initialize "autojump"

for script (
	"/usr/local/etc/profile.d/autojump.sh"
	"/usr/share/autojump/autojump.zsh"
); do
	if [[ -r "$script" ]]; then
		source "$script"
		unset script
		return 0
	fi
done
unset script
return 1
