# AX-ZSH: Alex' Modular ZSH Configuration
# fzf.zshrc: Setup Git

axzsh_is_modern_terminal || return 91

# Test for local fzf installation ...
if [[ -r ~/.fzf.zsh ]]; then
	source ~/.fzf.zsh
	return 0
fi

# Make sure that "fzf(1)" is installed
(( $+commands[fzf] )) || return 1

# Test for Debian-specific keybinding location ...
if [[ -r /usr/share/doc/fzf/examples/key-bindings.zsh ]]; then
	if [[ -r /usr/share/doc/fzf/examples/completion.zsh ]]; then
		source /usr/share/doc/fzf/examples/completion.zsh
	elif [[ -r /usr/share/zsh/vendor-completions/_fzf ]]; then
		source /usr/share/zsh/vendor-completions/_fzf
	fi
	source /usr/share/doc/fzf/examples/key-bindings.zsh
	return 0
fi

# Search for and read in FZF ZSH integration files
for dir (
	/usr/local/lib/fzf/shell
	/usr/local/opt/fzf/shell
	/usr/local/share/examples/fzf/shell
	/opt/fzf/shell
); do
	[[ -d "$dir" ]] || continue
	source "$dir/completion.zsh"
	source "$dir/key-bindings.zsh"
	return 0
done
return 1
