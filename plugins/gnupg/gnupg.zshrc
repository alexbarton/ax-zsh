# AX-ZSH: Alex' Modular ZSH Configuration
# gnupg.zshrc: Setup GnuPG

if (( $+commands[gpg2] )); then
	# Use the gpg completions for gpg2, too
	compdef gpg2=gpg

	if ! (( $+commands[gpg])); then
		# gpg2 is available, but no gpg: alias it!
		alias gpg="gpg2"
	fi
fi

if [[ -z "$GPG_AGENT_INFO" && -r ~/.gpg-agent-info ]]; then
	# Read environment file
	source ~/.gpg-agent-info 2>/dev/null
	[[ -n "$GPG_AGENT_INFO" ]] && export GPG_AGENT_INFO
fi
