# AX-ZSH: Alex' Modular ZSH Configuration
# trash.zshrc: Setup trash(1)

# Make sure that "trash(1)" is installed
(( $+commands[trash] )) || return

# Note: Starting with macOS 15, a trash(1) command is part of the system.
# But prefer Homebrew-installed "macos-trash" and "trash" over it!
if [[ -x /opt/homebrew/opt/macos-trash/bin/trash ]]; then
	alias trash='/opt/homebrew/opt/macos-trash/bin/trash'
	alias rm='/opt/homebrew/opt/macos-trash/bin/trash -i'
elif [[ -x /opt/homebrew/opt/trash/bin/trash ]]; then
	alias trash='/opt/homebrew/opt/trash/bin/trash'
	alias rm='/opt/homebrew/opt/trash/bin/trash -F'
else
	alias rm='trash'
fi
