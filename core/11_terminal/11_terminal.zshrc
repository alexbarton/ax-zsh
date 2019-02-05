# AX-ZSH: Alex' Modular ZSH Configuration
# 10_terminal.zshrc: Initialize terminal settings

# Fix up TERM. Do this here (and not in zprofile), because terminal emulators
# often don't start a new login shell but "only" a new interactive shell.

# VTE based terminals (like GNOME Terminal) support 256 colors, but old(er)
# versions of GNOME Terminal (at least) set TERM=xterm ...
[[ "$TERM" = "xterm" && "$VTE_VERSION" != "" ]] && TERM="xterm-256color"

# Common helper functions

# Check if terminal supports Unicode.
# <https://wiki.grml.org/doku.php?id=utf8>
function axzsh_is_utf_terminal {
	case "$LANG $CHARSET $LANGUAGE" in
		(*utf*) return 0 ;;
		(*UTF*) return 0 ;;
		(*) return 1 ;;
	esac
}
alias isutfenv=axzsh_is_utf_terminal

# Check if terminal supports "wide" characters.
# <https://unix.stackexchange.com/questions/184345/detect-how-much-of-unicode-my-terminal-supports-even-through-screen>
typeset -g _axzsh_is_widechar_terminal_cache
function axzsh_is_widechar_terminal {
	if [[ -z "$_axzsh_is_widechar_terminal_cache" ]]; then
		# No cached result, call test function ...
		_axzsh_is_widechar_terminal
		_axzsh_is_widechar_terminal_cache=$?
	fi
	return $_axzsh_is_widechar_terminal_cache
}
function _axzsh_is_widechar_terminal {
	[[ -t 1 ]] || return 1
	[[ -z "$AXZSH_PLUGIN_CHECK" ]] || return 1
	axzsh_is_utf_terminal || return 1
	echo -ne "🍀\033[6n"
	read -s -d\[ garbage
	read -s -d R pos
	echo -ne "\033[1K\r"
	[[ "${pos#*;}" -eq 2 ]] || return 1
	return 0
}

# Test for "modern" terminal
function axzsh_is_modern_terminal {
	[[ "$TERM" = screen* ]] && return 0
	[[ "$TERM" = tmux* ]] && return 0
	[[ "$TERM" = xterm* ]] && return 0
	[[ "$TERM" = cygwin ]] && return 0
	return 1
}

# Test for "dumb" terminal
function axzsh_is_dumb_terminal {
	axzsh_is_modern_terminal && return 1
	[[ "$TERM" = dumb* ]] && return 0
	[[ "$TERM" = "vt52" ]] && return 0
	return 1
}

# Resize terminal window (when possible)
function axzsh_resize_terminal {
	printf '\e[8;%d;%dt' "$2" "$1"
}

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

	if [[ -z "$remote" ]]; then
		axzsh_terminal_set_window_title "$LOGNAME@$SHORT_HOST$TITLE_ADD"
	else
		axzsh_terminal_set_window_title "$1"
	fi
}

preexec_functions+=(axzsh_terminal_title_preexec)

alias axttyinfo="nocorrect zsh $AXZSH/bin/axttyinfo"

axzsh_is_dumb_terminal && return 0

# Colors

autoload -Uz colors
colors

fg[default]="\e[39m"
bg[default]="\e[49m"

# Foreground (FG) and background (BG) colors.
typeset -Ag FG BG
for color in {000..255}; do
	FG[$color]="%{[38;5;${color}m%}"
	BG[$color]="%{[48;5;${color}m%}"
done

# Text effects (FX)

typeset -Ag FX
FX=(
	reset     "%{[00m%}"
	bold      "%{[01m%}"	no-bold      "%{[22m%}"
	italic    "%{[03m%}"	no-italic    "%{[23m%}"
	underline "%{[04m%}"	no-underline "%{[24m%}"
	blink     "%{[05m%}"	no-blink     "%{[25m%}"
	reverse   "%{[07m%}"	no-reverse   "%{[27m%}"
)

ZSH_SPECTRUM_TEXT=${ZSH_SPECTRUM_TEXT:-The quick brown fox jumps over the lazy dog}

# Show all 256 foreground colors with color number
function spectrum_ls() {
	for code in {000..255}; do
		print -P -- "$code: %{$FG[$code]%}$ZSH_SPECTRUM_TEXT%{$reset_color%}"
	done
}

# Show all 256 background colors with color number
function spectrum_bls() {
	for code in {000..255}; do
		print -P -- "$code: %{$BG[$code]%}$ZSH_SPECTRUM_TEXT%{$reset_color%}"
	done
}

# NOTE for FG, BG and FX arrays, and spectrum_ls() and spectrum_bls() functions:
# Based on a script to make using 256 colors in zsh less painful, written by
# P.C. Shyamshankar <sykora@lucentbeing.com>.
# Copied from OhMyZsh https://github.com/robbyrussell/oh-my-zsh/blob/master/lib/spectrum.zsh
# which was copied from https://github.com/sykora/etc/blob/master/zsh/functions/spectrum/ :-)
