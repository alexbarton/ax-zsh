# AX-ZSH: Alex' Modular ZSH Configuration
# fzf.zshrc: Setup Git

# Make sure that "fzf(1)" is installed
(( $+commands[fzf] )) || return

# Search for and read in FZF ZSH integration files
for dir (
	/usr/local/opt/fzf/shell
); do
	[[ -d "$dir" ]] || continue
	source "$dir/completion.zsh"
	source "$dir/key-bindings.zsh"
	break
done
