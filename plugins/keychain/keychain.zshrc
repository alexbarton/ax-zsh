# AX-ZSH: Alex' Modular ZSH Configuration
# keychain.zshrc: Setup keychain(1)

# Test if keychain(1) has already been initialized, for example in the
# "profile" stage.
if [[ -n "$axzsh_keychain_was_run" ]]; then
	unset axzsh_keychain_was_run
	return
fi

# Make sure that "keychain(1)" is installed
(( $+commands[keychain] )) || return

function axzsh_keychain_update() {
	if ! eval `keychain --eval --ssh-allow-forwarded --ssh-allow-gpg --systemd "$@"` 2>/dev/null; then
		# Invocation failed! Probably we are using a keychain(1)
		# version <2.9, let's try to use the old calling convention:
		eval `keychain --eval --inherit any-once --systemd "$@"`
	fi
}

[[ "$type" == "zshrc" ]] \
	&& axzsh_keychain_update --quiet --quick \
	|| axzsh_keychain_update --quiet

unset axzsh_keychain_was_run
