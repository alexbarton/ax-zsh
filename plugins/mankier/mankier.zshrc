# AX-ZSH: Alex' Modular ZSH Configuration
# mankier.zshrc: Setup ManKier online manual page service.

[[ -z "$AXZSH_PLUGIN_CHECK" ]] || return 92

# curl(1) is required to access the online API
(( $+commands[curl] )) || return

explain () {
	# Explain a shell command. See:
	# <https://www.mankier.com/blog/explaining-shell-commands-in-the-shell.html>

	local api_url="https://www.mankier.com/api/v2"

	if [[ "$#" -eq 0 ]]; then
		while read 'cmd?Explain: '; do
			[[ -n "$cmd" ]] || break
			curl -Gs "$api_url/explain/?cols=$(tput cols)" --data-urlencode q="$cmd" | less
		done
		echo "Bye!"
	else
		curl -Gs "$api_url/explain/?cols=$(tput cols)" --data-urlencode q="$*" | less
	fi
}
