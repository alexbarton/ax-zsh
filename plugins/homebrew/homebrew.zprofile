# AX-ZSH: Alex' Modular ZSH Configuration
# homebrew.zprofile -- Setup Homebrew Package Manager

# Look for the "brew(1) command ...
for brew_cmd (
	/home/linuxbrew/.linuxbrew/bin/brew
	/opt/homebrew/bin/brew
	/usr/local/bin/brew
); do
	[[ -x "$brew_cmd" ]] && break
done
if [[ ! -x "$brew_cmd" ]]; then
	unset brew_cmd
	return 1
fi

eval "$("$brew_cmd" shellenv)"

for dir (
	"$HOMEBREW_PREFIX/share/zsh-completions"
	"$HOMEBREW_PREFIX/share/zsh/site-functions"
); do
	[[ -d "$dir" ]] && axzsh_fpath+=("$dir")
done
unset dir brew_cmd

# Set some defaults, if not set already.
[[ -z "$HOMEBREW_AUTO_UPDATE_SECS" ]] && export HOMEBREW_AUTO_UPDATE_SECS=600

return 0
