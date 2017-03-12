# AX-ZSH: Alex' Modular ZSH Configuration
# 12_locale.zprofile: Initialize locale settings

# This is only relevant for interactive shells (because the user has to
# manually enter data when the validation fails):
[[ -z "$PS1" ]] && return 0

# Validate the locale(7) settings in interactive shells and try to mimic the
# tset(1) behaviour.
while true; do
	lc_messages=$(locale 2>/dev/null | fgrep LC_MESSAGES | cut -d'=' -f2)
	lc_messages=$lc_messages:gs/\"//
	locale=$lc_messages:r
	encoding=$lc_messages:e:l:gs/-//
	[[ -n "$encoding" ]] && locale="$locale.$encoding"
	[[ -z "$LANG$LANGUAGE$LC_ALL$LC_MESSAGES" ]] && unset lc_messages

	if [[ -n "$LANG$LANGUAGE$LC_ALL$LC_MESSAGES" ]] && locale -a 2>/dev/null | grep "^$locale\$" >/dev/null; then
		# The locale setting seems to be valid: one of the LANG,
		# LANGUAGE, LC_ALL and/or LC_MESSAGES is set and the locale is
		# included in "locale -a" output. Good!
		break
	fi

	echo "ax-zsh: unknown/unsupported locale ${lc_messages:-unknown}" >&2
	unset locale
	while [[ -z "$locale" ]]; do
		if ! read "locale?Locale? "; then
			echo >&2
			break 2
		fi
	done
	if [[ -n "$locale" ]]; then
		export LANG=$locale
		unset LANGUAGE LC_ALL LC_MESSAGES
	fi
done

unset lc_messages locale encoding
