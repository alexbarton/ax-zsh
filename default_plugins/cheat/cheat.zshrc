# AX-ZSH: Alex' Modular ZSH Configuration
# cheat: Setup http://cheat.sh

# Don't overwrite a real "cheat" command!
(( $+commands[cheat] )) && return

function cheat() {
	url="http://cheat.sh/$@?style=monokai"

	if (( $+commands[curl] )); then
		curl -s "$url" | ${PAGER:-less}
	elif (( $+commands[wget] )); then
		wget -qO - "$url" | ${PAGER:-less}
	else
		echo "Neither curl(1) nor wget(1) found!" >&2
		return 1
	fi
}
