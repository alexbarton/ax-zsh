# AX-ZSH: Alex' Modular ZSH Configuration
# google.zshrc: Setup functions for using Google in the command line

# This is an optional plugin.
[[ -z "$AXZSH_PLUGIN_CHECK" ]] || return 92

function duckduckgo {
	url="https://duckduckgo.com/?q=$@"
	open_command "$url" || echo "DuckDuckGo: <$url>"
}
alias ddg='duckduckgo'

function ecosia {
	url="https://www.ecosia.org/search?q=$@"
	open_command "$url" || echo "Ecosia: <$url>"
}
alias eco='ecosia'

function google {
	url="https://www.google.de/search?q=$@"
	open_command "$url" || echo "Google: <$url>"
}
alias g0='google'
