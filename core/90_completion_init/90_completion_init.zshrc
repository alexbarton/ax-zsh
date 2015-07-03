# AX-ZSH: Alex' Modular ZSH Configuration
# completion.zshrc: Setup completion

# Make sure that "compinit" is available
type compinit >/dev/null || return

# Save the location of the current completion dump file.
if [[ -z "$ZSH_COMPDUMP" ]]; then
	ZSH_COMPDUMP="${ZDOTDIR:-$HOME}/.zcompdump-${SHORT_HOST}-${ZSH_VERSION}"
fi

# Initialize ZSH completion system
compinit -d "$ZSH_COMPDUMP"
