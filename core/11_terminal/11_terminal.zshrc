# AX-ZSH: Alex' Modular ZSH Configuration
# 11_terminal.zshrc: Initialize terminal settings

# Fix up TERM. Do this here in the zshrc stage (and not in zprofile), because
# terminal emulators often don't start a new login shell but "only" a new
# interactive shell.

[[ -n "$AXZSH_DEBUG" ]] && \
	echo "  TERM='${TERM:-(unset/empty)}' TERM_COLORS='${TERM_COLORS:-(unset/empty)}' TERM_DOWNGRADED_FROM='${TERM_DOWNGRADED_FROM:-(unset/empty)}' ..."

# Normally, TERM_INITIAL is set in the zprofile stage; but make sure that it is
# set, for example in non-login shells!
[[ -n "$TERM_INITIAL" ]] || TERM_INITIAL="$TERM"

# Try to get a value for TERM_COLORS, when it is not yet set. Note: it will be
# re-detected for the final TERM type later on below!
[[ -n "$TERM_COLORS" ]] || TERM_COLORS=$(tput colors 2>/dev/null)
initial_term_colors="$TERM_COLORS"

# VTE based terminals (like GNOME Terminal) support 256 colors, but old(er)
# versions of GNOME Terminal (at least) set TERM=xterm ...
[[ "$TERM" = "xterm" && "$VTE_VERSION" != "" ]] && TERM="xterm-256color"

# Fix TERM_COLORS according to the initial TERM setting ... This is mostly
# relevant in terminal multiplexers like screen(1) and tmux(1) which, sometimes
# by default, use their "*-256color" TERM type -- even when the initial
# terminal only supports a subset!
# Note that the final value for the TERM_COLORS variable is determined
# according to the final TERM value and overwritten later on below!
[[ $TERM_COLORS -gt 16 && "$TERM_INITIAL" = *-16color ]] && TERM_COLORS=16
[[ $TERM_COLORS -gt 8 && (
	"$TERM_INITIAL" = ansi ||
	"$TERM_INITIAL" = linux ||
	"$TERM_INITIAL" = xterm
) ]] && TERM_COLORS=8
[[ $TERM_COLORS -gt 2 && (
	"$TERM_INITIAL" = dumb ||
	"$TERM_INITIAL" = vt52 ||
	"$TERM_INITIAL" = vt100
) ]] && TERM_COLORS=2

# Check if TERM_COLORS match the TERM setting, and fix TERM if not:
[[ $TERM_COLORS -lt 16 && "$TERM" = *-16color ]] \
	&& downgrade="16color"
[[ $TERM_COLORS -lt 256 && "$TERM" = *-256color ]] \
	&& downgrade="256color"
if [[ -n "$downgrade" ]]; then
	# Save the "pre-downgrade" setting(s) ...
	[[ -z "$TERM_DOWNGRADED_FROM" ]] \
		&& TERM_DOWNGRADED_FROM="${TERM}[${initial_term_colors}]" \
		|| TERM_DOWNGRADED_FROM="${TERM}[${initial_term_colors}],${TERM_DOWNGRADED_FROM}"
	export TERM_DOWNGRADED_FROM
	# Cut off the wrong suffix! Try first to use a "-<N>color"-type,
	# and fall back to the plain type if this is not known.
	new_term="${TERM%*-$downgrade}"
	TERM="${new_term}-${TERM_COLORS}color" tput colors 1>/dev/null 2>&1 \
		&& TERM="${new_term}-${TERM_COLORS}color" || TERM="${new_term}"
	export TERM
	unset new_term
	# Adjust color definitions for ls(1):
	unset LS_COLORS
	(( $+commands[dircolors] )) && eval $(dircolors)
fi
unset downgrade initial_term_colors

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
# Compatibility with GRMLZSHRC, see <https://grml.org/zsh/grmlzshrc.html>:
alias isutfenv=axzsh_is_utf_terminal

# Get the length of a string when shown on the terminal. The return code of the
# function is the length in "cells". Note: Echoing the length to the terminal,
# which looks cleaner at first, doesn't work: this command can't be called with
# its stdin and/or stdout redirected, as it must be able to interact with the
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
	if [[ -z "$TERM" ]]; then
		# Ops, the TERM environment variable is no (longer) set?
		# This is definitely not a "modern" terminal!
		unset _axzsh_is_modern_terminal_cache
		return 1
	fi
	[[ -n "$TERM_DOWNGRADED_FROM" ]] && return 1
	[[ "$TERM_COLORS" -le 8 ]] && return 1
	[[ -n "$_axzsh_is_modern_terminal_cache" ]] \
		&& return $(test "$_axzsh_is_modern_terminal_cache" -eq 0 2>/dev/null)

	result=1
	[[ "$TERM" = cygwin ]] && result=0
	[[ "$TERM" = foot ]] && result=0
	[[ "$TERM" = ghostty ]] && result=0
	[[ "$TERM" = kitty ]] && result=0
	[[ "$TERM" = putty* ]] && result=0
	[[ "$TERM" = screen* ]] && result=0
	[[ "$TERM" = tmux* ]] && result=0
	[[ "$TERM" = xterm* ]] && result=0

	export _axzsh_is_modern_terminal_cache=$result
	return $result
}

# Test for "dumb" terminal
function axzsh_is_dumb_terminal {
	[[ -z "$TERM" ]] && return 0
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

# Update terminal titles before echoing the shell prompt
function axzsh_terminal_title_precmd {
	axzsh_is_modern_terminal || return
	axzsh_terminal_set_window_title ''
	if [[ "$TERM_PROGRAM" == "Apple_Terminal" && "$TERM" != "screen"* ]]; then
		axzsh_terminal_set_icon_title "$LOGNAME@$SHORT_HOST"
		# Update CWD in Terminal.app
		local url=$(echo "file://$HOST$PWD" | sed -e 's| |%20|g')
		printf '\e]7;%s\a' "$url"
	else
		axzsh_terminal_set_icon_title "$LOGNAME@$SHORT_HOST:$PWD"
	fi
}

precmd_functions+=(axzsh_terminal_title_precmd)

# Reset the terminal to "sane defaults" before executing a command
function axzsh_terminal_reset_prexec {
	# Reset colors. Some prompt commands fail to do this on their own on
	# some terminals ... so let's play it safe!
	print -Pn -- "$FX[reset]"
}

# Update terminal titles before executing a command
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

preexec_functions+=(axzsh_terminal_reset_prexec axzsh_terminal_title_preexec)

alias axttyinfo="zsh \"\$AXZSH/bin/axttyinfo\""

# "Dumb" terminals most likely have no color or style support. So stop here!
if axzsh_is_dumb_terminal; then
	# But clean up a bit!
	unset CLICOLOR TERM_COLORS
	return 0
fi

# Colors
# See <https://en.wikipedia.org/wiki/ANSI_escape_code#Colors>, for example.

autoload -Uz colors
colors

if axzsh_is_modern_terminal; then
	fg[default]="\e[39m"
	bg[default]="\e[49m"
else
	fg[default]="\e[37m"
	bg[default]="\e[47m"
fi

# Try to detect the number of supported colors and store it in TERM_COLORS:
# first by querying the "termcap" database, and if this does not work, some
# hardcoded defaults.
TERM_COLORS=$(tput colors 2>/dev/null)
if [[ -z "$TERM_COLORS" ]]; then
	case "$TERM" in
		*-256color|xterm-ghostty|xterm-kitty)
			TERM_COLORS=256 ;;
		linux)
			TERM_COLORS=8 ;;
		*)
			# Assume 16 colors by default ...
			TERM_COLORS=16
	esac
fi
export TERM_COLORS

# Set "CLICOLOR" when there are at least 4 colors available. And try to set
# CLICOLOR to a sane value, too:
if [[ "${TERM_COLORS:-0}" -ge 4 ]]; then
	# At least 4 colors ...
	export CLICOLOR=1
	if [[ "${TERM_COLORS:-0}" -lt 256 ]]; then
		COLORTERM="yes"
	else
		[[ -z "$COLORTERM" || "$COLORTERM" = "no" ]] && COLORTERM="yes"
	fi
	export COLORTERM
else
	# Less than 4 colors ("no colors"):
	unset CLICOLOR
	unset COLORTERM
fi

# Foreground (FG) and background (BG) colors.
typeset -Ag FG BG
if [[ $TERM_COLORS -gt 16 ]]; then
	for color in {000..$((TERM_COLORS-1))}; do
		FG[$color]="%{\e[38;5;${color}m%}"
		BG[$color]="%{\e[48;5;${color}m%}"
	done
elif [[ $TERM_COLORS -gt 0 ]]; then
	typeset -i c
	for color in {000..$((TERM_COLORS-1))}; do
		c=$color
		if [[ $c -ge 8 ]]; then
			c=$c-8
			p="1;"
		fi
		FG[$color]="%{\e[${p}3${c}m%}"
		BG[$color]="%{\e[${p}4${c}m%}"
	done
	unset c p
fi

# Text effects (FX)
# See <https://en.wikipedia.org/wiki/ANSI_escape_code#SGR_parameters>, for example.

typeset -Ag FX
FX=(
	reset     "%{\e[0m%}"
	bold      "%{\e[1m%}"	no-bold      "%{\e[22m%}"
	dim       "%{\e[2m%}"	no-dim       "%{\e[22m%}"
	italic    "%{\e[3m%}"	no-italic    "%{\e[23m%}"
	underline "%{\e[4m%}"	no-underline "%{\e[24m%}"
	blink     "%{\e[5m%}"	no-blink     "%{\e[25m%}"
	reverse   "%{\e[7m%}"	no-reverse   "%{\e[27m%}"
)

# NOTE for FG, BG and FX arrays, and spectrum_ls() and spectrum_bls() functions:
# Based on a script to make using 256 colors in zsh less painful, written by
# P.C. Shyamshankar <sykora@lucentbeing.com>.
# Copied from OhMyZsh https://github.com/robbyrussell/oh-my-zsh/blob/master/lib/spectrum.zsh
# which was copied from https://github.com/sykora/etc/blob/master/zsh/functions/spectrum/ :-)
