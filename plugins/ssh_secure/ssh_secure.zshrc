# AX-ZSH: Alex' Modular ZSH Configuration
# ssh_secure.zshrc: Make SSH operations more secure

# Make sure that "ssh(1)" is installed
(( $+commands[ssh] )) || return

# Enforce "strict host key checking"
#alias ssh="\ssh -o 'StrictHostKeyChecking yes'"
alias sshnew="\ssh -o 'StrictHostKeyChecking no'"
alias sshtmp="\ssh -o 'StrictHostKeyChecking no' -o 'UserKnownHostsFile /dev/null'"
