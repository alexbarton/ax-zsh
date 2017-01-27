# AX-ZSH: Alex' Modular ZSH Configuration
# fzf.zshrc: Setup Git

# Test for local fzf installation ...
if [[ -r ~/.fzf.zsh ]]; then
	source ~/.fzf.zsh
	return 0
fi

# Make sure that "fzf(1)" is installed
(( $+commands[fzf] )) || return 1

# Search for and read in FZF ZSH integration files
for dir (
	/usr/local/lib/fzf/shell
	/usr/local/opt/fzf/shell
); do
	[[ -d "$dir" ]] || continue
	source "$dir/completion.zsh"
	source "$dir/key-bindings.zsh"
	return 0
done
return 1
