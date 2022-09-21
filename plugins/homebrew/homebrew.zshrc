# AX-ZSH: Alex' Modular ZSH Configuration
# homebrew.zshrc -- Setup Homebrew Package Manager

# Make sure that "brew(1)" is installed
(( $+commands[brew] )) || return 1

if [[ -n "$AXZSH_PLUGIN_CHECK" ]]; then
	# Make sure brew command is working
	brew --version >/dev/null 2>&1 || return 1
fi

function brew() {
	# This wrapper function for the brew(1) command does the following:
	# - Detect the location of the "real" brew(1) command.
	# - Change user and group when the Homebrew installation is owned by a
	#   different user (to preserve sane file permissions).
	# - Set a relaxed umask(1) so that other users can use software
	#   installed by Homebrew.
	# - Call the "real" brew(1) command.

	if [ -x /home/linuxbrew/.linuxbrew/bin/brew ]; then
		real_brew_cmd="/home/linuxbrew/.linuxbrew/bin/brew"
	elif [ -x /opt/homebrew/bin/brew ]; then
		real_brew_cmd="/opt/homebrew/bin/brew"
	elif [ -x /usr/local/bin/brew ]; then
		real_brew_cmd="/usr/local/bin/brew"
	else
		if [ "$1" != "shellenv" ] && [ "$1" != "--prefix" ]; then
			echo "Oops, real \"brew\" command not found!? [for \"$1\"]" >&2
		fi
		return 101
	fi

	if [[ -z "$HOMEBREW_REPOSITORY" ]]; then
		eval "$("$real_brew_cmd" shellenv)"
	fi

	if [[ $(/bin/ls -ldn "$HOMEBREW_REPOSITORY" | awk '{print $3}') -eq $UID ]]; then
		# We are the owner of the Homebrew installation.
		(
			[[ $# -eq 0 && -t 1 ]] \
				&& echo "Running \"$real_brew_cmd\" ..."
			umask 0022 || return 103
			"$real_brew_cmd" "$@"
		)
	else
		# We are a different user than the owner of the Homebew
		# installation. So we need to change the user when running the
		# real "brew" command!
		priv_exec="umask 0022 || exit 103; \"$real_brew_cmd\" $*"
		(
			cd /tmp
			user="$(/bin/ls -ld "$HOMEBREW_REPOSITORY" | awk '{print $3}')"
			group="$(/bin/ls -ld "$HOMEBREW_REPOSITORY" | awk '{print $4}')"
			[[ $# -eq 0 && -t 1 ]] \
				&& echo "Running \"$real_brew_cmd\" as user \"$user:$group\" ..."
			sudo -u "$user" -g "$group" -- sh -c "$priv_exec"
		)
	fi
	return $?
}
