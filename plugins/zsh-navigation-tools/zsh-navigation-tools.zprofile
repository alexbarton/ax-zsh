# AX-ZSH: Alex' Modular ZSH Configuration
# zsh-navigation-tools.zprofile: Initialize "ZSH Navigation Tools"

for dir (
	"/usr/share/zsh-navigation-tools"
	"/usr/local/share/zsh-navigation-tools"
); do
	if [[ -d "$dir" ]]; then
		fpath+=($dir)
		unset dir
		return 0
	fi
done
unset dir
return 1
