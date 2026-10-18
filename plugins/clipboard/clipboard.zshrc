# AX-ZSH: Alex' Modular ZSH Configuration
# clipboard.zshrc: Clipboard integration

# This plugin is optional.
[[ -z "$AXZSH_PLUGIN_CHECK" ]] || return 92

# clip: Copy stdin into the system clipboard.
if ! (( $+commands[clip] )); then
	clip() {
		if [[ $# -gt 0 ]]; then
			# Arguments given. Assume that this is a command to run
			"$@" | clip
		else
			# Copy stdin to the clipboard
			printf '\e]52;c;%s\a' "$(base64 | tr -d '\n')" >/dev/tty
		fi
	}
	alias -g C='| clip'
fi
