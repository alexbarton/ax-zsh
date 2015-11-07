# AX-ZSH: Alex' Modular ZSH Configuration
# 10_terminal.zshrc: Initialize terminal settings

# Set terminal title

# Set terminal "hardstatus" and "icon title"
function axzsh_terminal_set_icon_title {
	[[ "$TERM" == "screen"* ]] && printf '\ek%s\e\\' "$1"
	printf '\e]1;%s\a' "$1"
}

# Set terminal window title
function axzsh_terminal_set_window_title {
	printf '\e]2;%s\a' "$1"
}

# Test for "modern" terminal
function axzsh_is_modern_terminal {
	[[ "$TERM" = screen* ]] && return 0
	[[ "$TERM" = tmux* ]] && return 0
	[[ "$TERM" = xterm* ]] && return 0
	return 1
}

# Update terminal titles befor echoing the shell prompt
function axzsh_terminal_title_precmd {
	axzsh_is_modern_terminal || return
	axzsh_terminal_set_icon_title 'zsh'
	if [[ "$TERM_PROGRAM" == "Apple_Terminal" && "$TERM" != "screen"* ]]; then
		axzsh_terminal_set_window_title "$LOGNAME@$SHORT_HOST"
		# Update CWD in Terminal.app
		local url=$(echo "file://$HOSTNAME$PWD" | sed -e 's| |%20|g')
		printf '\e]7;%s\a' "$url"
	else
		axzsh_terminal_set_window_title "$LOGNAME@$SHORT_HOST:$PWD"
	fi
}

precmd_functions+=(axzsh_terminal_title_precmd)

# Update terminal titles befor executing a command
function axzsh_terminal_title_preexec {
	axzsh_is_modern_terminal || return

	local cmd="${1[(w)1]}"
	local remote=""

	case "$cmd" in
	  "mosh"*|"root"*|"ssh"*|"telnet"*)
		remote=1
		;;
	esac
	if [[ "$TERM_PROGRAM" == "Apple_Terminal" ]]; then
		# Apple Terminal.app ...
		if [[ -n "$remote" ]]; then
			# Reset CWD for remote commands
			printf '\e]7;%s\a' ''
		fi
	fi
	if [[ "$TERM_PROGRAM" == "iTerm.app" ]]; then
		# iTerm.app ...
		[[ -n "$cmd" ]] && TITLE_ADD=" – $cmd"
	fi

	axzsh_terminal_set_icon_title "$cmd"

	[[ -z "$remote" ]] \
		&& axzsh_terminal_set_window_title "$LOGNAME@$SHORT_HOST$TITLE_ADD" \
		|| axzsh_terminal_set_window_title "$1"
}

preexec_functions+=(axzsh_terminal_title_preexec)

# Colors

autoload -Uz colors
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
