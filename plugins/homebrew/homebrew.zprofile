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

# Update the environment for Homebrew by evaluating "brew shellenv".
# NOTE: As of 2024-11-26, the brew command (e.g. /opt/homebrew/bin/brew) calls
# "sudo --reset-timestamp" which is, in theory, a very good idea but results in
# long delays if your machine is, for example, linked to Active Directory and
# your domain controller is not available or slow (not sure why sudo(1) actually
# checks any user credentials for _forgetting_ the usage time, but that's how it
# seems to be). Anyway. This can lead to annoying delays spawning new sessions,
# so use a "cache file" to speed this up.
_shellenv_cache="$XDG_CACHE_HOME/axzsh_homebrew_shellenv"
find "$_shellenv_cache" -mmin +1440 -delete 2>/dev/null
if [[ ! -r "$_shellenv_cache" ]]; then
	# Create new cache file:
	"$brew_cmd" shellenv >"$_shellenv_cache"
fi
. "$_shellenv_cache"
unset _shellenv_cache

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
