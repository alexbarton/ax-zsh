# AX-ZSH: Alex' Modular ZSH Configuration
# gnupg.zshrc: Setup GnuPG

if (( $+commands[gpg2] )); then
	# Use the gpg completions for gpg2, too
	compdef gpg2=gpg

	if ! (( $+commands[gpg])); then
		# gpg2 is available, but no gpg: alias it!
		alias gpg="gpg2"
	fi
else
	# Make sure that "gpg(1)" is available.
	(( $+commands[gpg] )) || return 1
fi

export GPG_TTY=$TTY

if [[ -z "$GNUPGHOME" && -S "$XDG_RUNTIME_DIR/gnupg/S.gpg-agent" ]]; then
	# The agent socket in the default location already exists, either
	# because the agent is running or because of systemd(1) socket
	# activation. So there is no need to start the agent here.
	:
elif (( $+commands[gpg-connect-agent] )); then
	# Try to start/connect the agent ...
	( gpg-connect-agent /bye >/dev/null 2>&1 )
fi
