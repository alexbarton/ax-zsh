# AX-ZSH: Alex' Modular ZSH Configuration
# ssh.zshrc: Setup (Open-) SSH

# Make sure that "ssh(1)" is installed
(( $+commands[ssh] )) || return

ssh_logname_prompt() {
	[[ -n "$SSH_CLIENT" ]] || return 1
	echo "$LOGNAME"
	return 0
}

ax_logname_prompt_functions=($ax_logname_prompt_functions ssh_logname_prompt)

ssh_hostname_prompt() {
	[[ -n "$SSH_CLIENT" ]] || return 1
	echo "$SHORT_HOST"
	return 0
}

ax_hostname_prompt_functions=($ax_hostname_prompt_functions ssh_hostname_prompt)