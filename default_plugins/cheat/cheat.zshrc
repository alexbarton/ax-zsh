# AX-ZSH: Alex' Modular ZSH Configuration
# cheat: Setup http://cheat.sh

function cheat() {
	url="http://cheat.sh/$@?style=monokai"

	if (( $+commands[curl] )); then
		curl "$url"
	elif (( $+commands[wget] )); then
		wget -qO - "$url"
	else
		echo "Neither curl(1) nor wget(1) found!" >&2
		return 1
	fi
}
