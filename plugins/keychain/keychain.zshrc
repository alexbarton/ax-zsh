# AX-ZSH: Alex' Modular ZSH Configuration
# keychain.zshrc: Setup keychain(1)

# Make sure that "keychain(1)" is installed
(( $+commands[keychain] )) || return

agents=""
if (( $+commands[ssh-agent] )); then
	[[ -z "$agents" ]] && agents="ssh" || agents="$agents,ssh"
fi
if (( $+commands[gpg-agent] )); then
	[[ -z "$agents" ]] && agents="gpg" || agents="$agents,gpg"
fi

eval `keychain --agents "$agents" --eval --quick --quiet`

unset agents
