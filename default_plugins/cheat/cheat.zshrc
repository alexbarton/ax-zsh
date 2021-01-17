# AX-ZSH: Alex' Modular ZSH Configuration
# cheat: Setup https://cht.sh

if (( $+commands[fzf] )); then
	# See <https://twitter.com/igor_chubin/status/1343294742315020293>
	function c() {
		url="https://cht.sh"
		term=$(curl -ks "$url/:list" | IFS=+ fzf --preview "curl -ks '$url/{}'" -q "$*") \
			&& curl -ks "$url/${term}" | ${PAGER:-less}
	}
fi

# Don't overwrite a real "cheat" command!
(( $+commands[cheat] )) && return

function cheat() {
	if (( $+commands[cht.sh] )); then
		if [[ $# -eq 0 ]]; then
			CHTSH_QUERY_OPTIONS="style=monokai" cht.sh --shell
		else
			CHTSH_QUERY_OPTIONS="style=monokai" cht.sh "$@" \
			 | ${PAGER:-less}
		fi
		return $?
	fi

	url="https://cht.sh/$@?style=monokai"

	if (( $+commands[curl] )); then
		curl -s "$url" | ${PAGER:-less}
	elif (( $+commands[wget] )); then
		wget -qO - "$url" | ${PAGER:-less}
	else
		echo "Neither cht.sh(1), curl(1) nor wget(1) found!" >&2
		return 1
	fi
}
