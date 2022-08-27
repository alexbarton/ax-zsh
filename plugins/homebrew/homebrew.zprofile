# AX-ZSH: Alex' Modular ZSH Configuration
# homebrew.zprofile -- Setup Homebrew Package Manager

# Make sure that "brew(1)" is installed
(( $+commands[brew] )) || return 1

eval "$(brew shellenv)"

for dir (
	"$HOMEBREW_PREFIX/share/zsh-completions"
	"$HOMEBREW_PREFIX/share/zsh/site-functions"
); do
	[[ -d "$dir" ]] && axzsh_fpath+=("$dir")

done
unset dir

return 0
