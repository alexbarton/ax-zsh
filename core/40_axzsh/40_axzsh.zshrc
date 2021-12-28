# AX-ZSH: Alex' Modular ZSH Configuration
# 50_axzsh.zshrc: Initialize AX-ZSH

function axzshctl() {
	zsh "$AXZSH/bin/axzshctl" "$@" || return $?

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
