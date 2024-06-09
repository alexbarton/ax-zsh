# AX-ZSH: Alex' Modular ZSH Configuration
# yazi.zshrc: Setup Yazi file manager

# Make sure that "yazi(1)" is installed
(( $+commands[yazi] )) || return

function yy() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(cat -- "$tmp")" && [[ -n "$cwd" && "$cwd" != "$PWD" ]]; then
		cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}
