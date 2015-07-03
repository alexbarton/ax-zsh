# AX-ZSH: Alex' Modular ZSH Configuration
# completion.zshrc: Setup completion

autoload -U compinit

setopt completealiases

zstyle ':completion:*' list-colors ''
zstyle ':completion:*' menu select
zstyle ':completion:*' special-dirs true

# Use caching so that commands like apt and dpkg completions are useable
zstyle ':completion::complete:*' use-cache 1
zstyle ':completion::complete:*' cache-path "$ZSH_CACHE_DIR"
