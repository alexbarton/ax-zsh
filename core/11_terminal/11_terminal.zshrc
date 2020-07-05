# AX-ZSH: Alex' Modular ZSH Configuration
# 11_terminal.zshrc: Initialize terminal settings

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

# Get the length of a string when shown on the terminal. The return code of the
# function is the length in "cells". Note: Echo'ing the length to the terminal,
# which looks cleaner at first, doesn't work: this command can't be called with
# its stdin and/or stdout redirected, as it it must be able to interact with the
# terminal (write to and read from it).
function axzsh_get_displayed_length {
	echo -ne "$*\033[6n"
	read -s -d\[ garbage
	read -s -d R pos
	echo -ne "\033[1K\r"
	return $((${pos#*;} - 1))
}

# Check if terminal correctly handles "wide" characters, which means, displays
# them with the correct width (>1).
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
	axzsh_get_displayed_length "🍀"
	[[ $? -eq 2 ]] && return 0 || return 1
}

# Test for "modern" terminal
function axzsh_is_modern_terminal {
	[[ "$TERM" = cygwin ]] && return 0
	[[ "$TERM" = putty* ]] && return 0
	[[ "$TERM" = screen* ]] && return 0
	[[ "$TERM" = tmux* ]] && return 0
	[[ "$TERM" = xterm* ]] && return 0
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
	axzsh_terminal_set_window_title ''
	if [[ "$TERM_PROGRAM" == "Apple_Terminal" && "$TERM" != "screen"* ]]; then
		axzsh_terminal_set_icon_title "$LOGNAME@$SHORT_HOST"
		# Update CWD in Terminal.app
		local url=$(echo "file://$HOSTNAME$PWD" | sed -e 's| |%20|g')
		printf '\e]7;%s\a' "$url"
	else
		axzsh_terminal_set_icon_title "$LOGNAME@$SHORT_HOST:$PWD"
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

	if [[ -n "$cmd" ]]; then
		# Add the command to the title
		TITLE_ADD=" – $cmd"
	fi

	if [[ -z "$remote" ]]; then
		axzsh_terminal_set_icon_title "$LOGNAME@$SHORT_HOST$TITLE_ADD"
	else
		axzsh_terminal_set_icon_title "$1"
	fi
}

preexec_functions+=(axzsh_terminal_title_preexec)

alias axttyinfo="zsh \"\$AXZSH/bin/axttyinfo\""

axzsh_is_dumb_terminal && return 0

# Colors
# See <https://en.wikipedia.org/wiki/ANSI_escape_code#Colors>, for exmaple.

autoload -Uz colors
colors

if axzsh_is_modern_terminal; then
	fg[default]="\e[39m"
	bg[default]="\e[49m"
else
	fg[default]="\e[37m"
	bg[default]="\e[47m"
fi

# Foreground (FG) and background (BG) colors.
typeset -Ag FG BG
case "$TERM" in
	*-256color)
		TERM_COLORS=255
		for color in {000..$TERM_COLORS}; do
			FG[$color]="%{\e[38;5;${color}m%}"
			BG[$color]="%{\e[48;5;${color}m%}"
		done
		;;
	*)
		TERM_COLORS=15
		typeset -i c
		for color in {000..$TERM_COLORS}; do
			c=$color
			if [[ $c -ge 8 ]]; then
				c=$c-8
				p="1;"
			fi
			FG[$color]="%{\e[${p}3${c}m%}"
			BG[$color]="%{\e[${p}4${c}m%}"
		done
		unset c p
esac
export TERM_COLORS

# Text effects (FX)
# See <https://en.wikipedia.org/wiki/ANSI_escape_code#SGR_parameters>, for example.

typeset -Ag FX
FX=(
	reset     "%{\e[0m%}"
	bold      "%{\e[1m%}"	no-bold      "%{\e[22m%}"
	italic    "%{\e[3m%}"	no-italic    "%{\e[23m%}"
	underline "%{\e[4m%}"	no-underline "%{\e[24m%}"
	blink     "%{\e[5m%}"	no-blink     "%{\e[25m%}"
	reverse   "%{\e[7m%}"	no-reverse   "%{\e[27m%}"
)

ZSH_SPECTRUM_TEXT=${ZSH_SPECTRUM_TEXT:-The quick brown fox jumps over the lazy dog}

# Show all 256 foreground colors with color number
function spectrum_ls() {
	for code in {000..$TERM_COLORS}; do
		print -P -- "$code: $FG[$code]$ZSH_SPECTRUM_TEXT$FX[reset]"
	done
}

# Show all 256 background colors with color number
function spectrum_bls() {
	for code in {000..$TERM_COLORS}; do
		print -P -- "$code: $BG[$code]$ZSH_SPECTRUM_TEXT$FX[reset]"
	done
}

# NOTE for FG, BG and FX arrays, and spectrum_ls() and spectrum_bls() functions:
# Based on a script to make using 256 colors in zsh less painful, written by
# P.C. Shyamshankar <sykora@lucentbeing.com>.
# Copied from OhMyZsh https://github.com/robbyrussell/oh-my-zsh/blob/master/lib/spectrum.zsh
# which was copied from https://github.com/sykora/etc/blob/master/zsh/functions/spectrum/ :-)
