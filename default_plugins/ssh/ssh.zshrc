# AX-ZSH: Alex' Modular ZSH Configuration
# ssh.zshrc: Setup (Open-) SSH

# Make sure that "ssh(1)" is installed
(( $+commands[ssh] )) || return

_ax_ssh_prompt() {
	[[ -n "$SSH_CLIENT" ]] || return 1
	return 0
}

ax_logname_prompt_functions=($ax_logname_prompt_functions _ax_ssh_prompt)
ax_hostname_prompt_functions=($ax_hostname_prompt_functions _ax_ssh_prompt)

# Validate SSH_AUTH_SOCK: Inside of screen(1) sessions for example, the socket
# file becomes invalid when the session has been disconnected.
[[ ! -r "$SSH_AUTH_SOCK" ]] && unset SSH_AUTH_SOCK

# Save SSH environment when available:
if [[ -n "$SSH_AUTH_SOCK" ]]; then
	# Save current environment when no state exists or is invalid.
	if [[ -r "$XDG_RUNTIME_DIR/ssh-env.sh" ]]; then
		(
			source "$XDG_RUNTIME_DIR/ssh-env.sh"
			if [[ -z "$SSH_AUTH_SOCK" || ! -r "$SSH_AUTH_SOCK" ]]; then
				# Content is invalid, remove state file!
				rm -f "$XDG_RUNTIME_DIR/ssh-env.sh"
			fi
		)
	fi
	if [[ ! -r "$XDG_RUNTIME_DIR/ssh-env.sh" ]]; then
		# No state file exists, create a new one:
		echo "SSH_AUTH_SOCK=\"$SSH_AUTH_SOCK\"" >"$XDG_RUNTIME_DIR/ssh-env.sh"
		echo "export SSH_AUTH_SOCK" >>"$XDG_RUNTIME_DIR/ssh-env.sh"
	fi
fi

# Restore SSH environment when not set but available:
if [[ -z "$SSH_AUTH_SOCK" && -r "$XDG_RUNTIME_DIR/ssh-env.sh" ]]; then
	# Try to recover known good environment ...
	source "$XDG_RUNTIME_DIR/ssh-env.sh"
	if [[ ! -r "$SSH_AUTH_SOCK" ]]; then
		# Clean up!
		unset SSH_AUTH_SOCK
		rm -f "$XDG_RUNTIME_DIR/ssh-env.sh"
	fi
fi
