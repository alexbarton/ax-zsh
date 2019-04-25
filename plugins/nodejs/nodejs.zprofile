# AX-ZSH: Alex' Modular ZSH Configuration
# nodejs.zprofile: Setup Nodejs (and NPM) environment.

# Make sure that NodeJS is installed
(( $+commands[node] )) || return

npm_packages="${HOME}/.npm-packages"

if [[ -z "$AXZSH_PLUGIN_CHECK" && ! -d "$npm_packages" ]]; then
	# Create the user-local NPM package directory (when not running then
	# "plugin check" right now) and the directory doesn't exist yet:
	mkdir -p "$npm_packages"
fi

# Append nodejs paths to binary and manual search paths.
export PATH="$PATH:$npm_packages/bin"
export MANPATH="$MANPATH:$npm_packages/share/man"

unset npm_packages
