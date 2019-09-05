# AX-ZSH: Alex' Modular ZSH Configuration
# ssh.zshrc: Setup (Open-) SSH

# Make sure that "ssh(1)" is installed
(( $+commands[ssh] )) || return

# Load SSH keys into the SSH agent, when one is running and doesn't have
# any keys already. Not having an SSH agent running at all is ok as well and
# results in an "success" exit code (0) as well.
ssh-autoadd() {
	[[ -z "$SSH_AUTH_SOCK" ]] && return 0
	ssh-add -l >/dev/null && return 0
	[[ $? -eq 2 ]] && return 2
	[[ "$1" = "-v" ]] && echo "SSH agent is running, but has no identities."
	ssh-add
}

_ax_ssh_prompt() {
	[[ -n "$SSH_CLIENT" ]] || return 1
	return 0
}

ax_logname_prompt_functions=($ax_logname_prompt_functions _ax_ssh_prompt)
ax_hostname_prompt_functions=($ax_hostname_prompt_functions _ax_ssh_prompt)

# Validate SSH_AUTH_SOCK: Inside of screen(1) sessions for example, the socket
# file becomes invalid when the session has been disconnected.
[[ ! -r "$SSH_AUTH_SOCK" ]] && unset SSH_AUTH_SOCK

# Look for common socket locations ...
if [[ -z "$SSH_AUTH_SOCK" ]]; then
	for s (
		/mnt/c/Local/$LOGNAME/ssh-agent.sock
	); do
		if [[ -r "$s" ]]; then
			export SSH_AUTH_SOCK=$s
			break
		fi
	done
	unset s
fi

# Save SSH environment when available:
if [[ -n "$SSH_AUTH_SOCK" && -d "$XDG_RUNTIME_DIR" ]]; then
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
