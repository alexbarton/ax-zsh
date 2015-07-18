# AX-ZSH: Alex' Modular ZSH Configuration
# 50_completion.zshrc: Setup completion

autoload -U compinit

setopt completealiases

zstyle ':completion:*' list-colors ''
zstyle ':completion:*' menu select
zstyle ':completion:*' special-dirs true

# Use caching so that commands like apt and dpkg completions are useable
zstyle ':completion::complete:*' use-cache 1
zstyle ':completion::complete:*' cache-path "$ZSH_CACHE_DIR"

# Save the location of the current completion dump file.
if [[ -z "$ZSH_COMPDUMP" ]]; then
	ZSH_COMPDUMP="${ZDOTDIR:-$HOME}/.zcompdump-${SHORT_HOST}-${ZSH_VERSION}"
fi

# Initialize ZSH completion system
compinit -d "$ZSH_COMPDUMP"
