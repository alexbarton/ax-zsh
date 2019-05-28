# AX-ZSH: Alex' Modular ZSH Configuration
# ssh_secure.zshrc: Make SSH operations more secure

# Make sure that "ssh(1)" is installed
(( $+commands[ssh] )) || return

# This plugin is optional.
[[ -z "$AXZSH_PLUGIN_CHECK" ]] || return 92

# Enforce "strict host key checking"
alias sshnew='ssh -o "StrictHostKeyChecking no"'
alias sshtmp='ssh -o "StrictHostKeyChecking no" -o "UserKnownHostsFile /dev/null"'

compdef sshnew=ssh
compdef sshtmp=ssh
