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

# Make sure that "gpg(1)" is available.
(( $+commands[gpg] )) || return

export GPG_TTY=$(tty)

agent_info_file="$HOME/.gnupg/agent.info-${HOST}"

# Validate agent info ...
if [[ -n "$GPG_AGENT_INFO" ]]; then
	echo " *** Testing agent environment ..."
	gpg-agent >/dev/null 2>&1 || unset GPG_AGENT_INFO
fi

# Read environment file, when available and agent info not already set.
if [[ -z "$GPG_AGENT_INFO" && -r "$agent_info_file" ]]; then
	source "$agent_info_file" 2>/dev/null
	[[ -n "$GPG_AGENT_INFO" ]] && export GPG_AGENT_INFO
fi

# Setup GnuPG agent when installed.
if (( $+commands[gpg-agent] )); then
	# Start up a new GnuPP agent, when none is running/accessible:
	if ! gpg-agent >/dev/null 2>&1; then
		eval $(gpg-agent --daemon --write-env-file "$agent_info_file")
	fi
fi

unset agent_info_file
