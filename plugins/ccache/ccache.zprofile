# AX-ZSH: Alex' Modular ZSH Configuration
# ccache.zprofile: Setup CCache environment

# Make sure that "ccache(1)" is installed
(( $+commands[ccache] )) || return

# Setup cache location
export CCACHE_DIR="$XDG_CACHE_HOME/ccache"

# Search for directory with wrapper commands and prepend it to "PATH"
for dir (
	/usr/local/opt/ccache/libexec
	/usr/local/lib/ccache
	/opt/ccache/libexec
	/usr/libexec/ccache
	/usr/lib/ccache
); do
	if [[ -d "$dir" ]]; then
		PATH="$dir:$PATH"
		break
	fi
done
unset dir
