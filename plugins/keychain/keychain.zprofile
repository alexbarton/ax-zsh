# AX-ZSH: Alex' Modular ZSH Configuration
# keychain.zprofile: Setup keychain(1)

# Initialize keychain(1) as soon as possible ("profile") stage, but run it
# in all sessions, in non-login shells, too. So call the "zshrc" script here
# and set a flag that keychain(1) has been initialized already.
source "$AXZSH"/plugins/keychain/keychain.zshrc && axzsh_keychain_was_run=1
