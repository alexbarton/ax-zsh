# AX-ZSH: Alex' Modular ZSH Configuration
# ssh_autoadd.zshrc: Make sure that SSH keys are available

# Make sure that "ssh(1)" is installed.
(( $+commands[ssh] )) || return 1

# This plugin is optional.
[[ -z "$AXZSH_PLUGIN_CHECK" ]] || return 92

# Make sure that an SSH agent is available (but ignore failure):
[[ -n "$SSH_AUTH_SOCK" ]] || return 0

# Call the ax-zsh "ssh-autoadd" function.
[[ -t 1 ]] && ssh-autoadd -v
