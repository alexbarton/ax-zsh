# AX-ZSH: Alex' Modular ZSH Configuration
# 50_axzsh.zshrc: Initialize AX-ZSH

function axzshctl() {
	AXZSH_THEME="$AXZSH_THEME" zsh "$AXZSH/bin/axzshctl" "$@" || return $?

	if [[ "$1" = "disable" ]]; then
		unset AXZSH AXZSH_FPATH AXZSH_ZLOGIN_READ AXZSH_ZPROFILE_READ
	fi

	case "$1" in
		"disable"*|"enable"*|"reset"*|"set"*|"up"*)
			# Command which potentially "changed state".
			if [[ -o login ]]; then
				echo "Restarting login shell ..."
				exec -l "$SHELL"
			else
				echo "Restarting shell ..."
				exec "$SHELL"
			fi
			;;
	esac
	return 0
}
