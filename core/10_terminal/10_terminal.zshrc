# AX-ZSH: Alex' Modular ZSH Configuration
# 10_terminal.zshrc: Initialize terminal settings

# Set terminal title

function axzsh_terminal_title_precmd {
	if [[ $TERM_PROGRAM == Apple_Terminal ]]; then
		local url=$(echo "file://$HOSTNAME$PWD" | sed -e 's| |%20|g')
		printf '\e]7;%s\a' "$url"
		printf '\e]0;%s\a' "$LOGNAME@$SHORT_HOST"
	else
		printf '\e]0;%s\a' "$LOGNAME@$SHORT_HOST:$PWD"
	fi
}

precmd_functions+=(axzsh_terminal_title_precmd)

# Colors

autoload -U colors
colors

# Text effects (FX)

typeset -Ag fx
fx=(
	reset		"\e[00m"
	bold		"\e[01m"
	no-bold		"\e[22m"
	italic		"\e[03m"
	no-italic	"\e[23m"
	underline	"\e[04m"
	no-underline	"\e[24m"
	blink		"\e[05m"
	no-blink	"\e[25m"
	reverse		"\e[07m"
	no-reverse	"\e[27m"
)
