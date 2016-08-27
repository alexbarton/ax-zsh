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
	eval `keychain --eval --inherit any-once "$@"`
}

[[ "$type" == "zshrc" ]] \
	&& axzsh_keychain_update --quiet --quick \
	|| axzsh_keychain_update --quiet

unset axzsh_keychain_was_run
