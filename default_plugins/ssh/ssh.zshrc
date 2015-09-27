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
