# AX-ZSH: Alex' Modular ZSH Configuration
# cygwin.zprofile: Setup CCache environment

[[ -d /cygdrive ]] || return

# Search for directories and apprepend it to "PATH"
for dir (
	/cygdrive/c/Windows
	/cygdrive/c/Windows/System32
	/cygdrive/c/Windows/System32/WindowsPowerShell/v1.0
); do
	[[ -d "$dir" ]] && PATH="$PATH:$dir"
done
unset dir
