# AX-ZSH: Alex' Modular ZSH Configuration
# ssh.zprofile: Setup (Open-) SSH

# Make sure that "ssh(1)" is installed
(( $+commands[ssh] )) || return

unset ssh_cmd
(( $+commands[ssh-q] )) && ssh_cmd="ssh-q"
(( $+commands[ssh-wrapper] )) && ssh_cmd="ssh-wrapper"
if [[ -n "$ssh_cmd" ]]; then
	export GIT_SSH="$ssh_cmd"
fi
unset ssh_cmd
