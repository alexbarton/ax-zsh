# AX-ZSH: Alex' Modular ZSH Configuration
# ssh_macos.zshrc: Additional configuration for SSH on Apple macOS X

# Make sure that "ssh(1)" is installed.
(( $+commands[ssh] )) || return 1

# Test for macOS Sierra (10.12) or newer:
[[ $(uname -s) = "Darwin" ]] || return 1
[[ $(uname -r | cut -d'.' -f1) -ge 16 ]] || return 1

# Load SSH keys from Keychain into SSH agent when the agent has no keys.
ssh-add -l >/dev/null || ssh-add -A >/dev/null 2>&1
