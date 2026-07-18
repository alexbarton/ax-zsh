# AX-ZSH: Alex' Modular ZSH Configuration
# rustup.zprofile: Setup a "rustup" environment.

# Make sure that "rustup" is installed
(( $+commands[rustup] )) || return

# Return success when in "check mode" and "rustup" was found.
[[ -n "$AXZSH_PLUGIN_CHECK" ]] && return 0

# Do not tweak settings when either "cargo" or "rustc" is already available
# in the current PATH:
(( $+commands[cargo] )) && return
(( $+commands[rustc] )) && return

# Search for the rustup "bin" directory ...
for dir (
	"$HOMEBREW_PREFIX/opt/rustup"
	/opt/rustup
	/usr/lib/rustup
); do
	[[ -x "$dir/bin/rustc" ]] || continue
	path+=("$dir/bin")
	return 0
:
done
return 1
