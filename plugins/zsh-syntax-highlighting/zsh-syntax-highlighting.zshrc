# AX-ZSH: Alex' Modular ZSH Configuration
# zsh-syntax-highlighting.zshrc: Initialize "ZSH Syntax Highlighting"

for script (
	"/usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
	"/usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
); do
	if [[ -r "$script" ]]; then
		[[ -n "$ZSH_HIGHLIGHT_HIGHLIGHTERS" ]] \
			&& ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)
		source "$script"
		unset script
		return 0
	fi
done
unset script
return 1
