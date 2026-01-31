# AX-ZSH: Alex' Modular ZSH Configuration
# iterm2.zshrc: iTerm2 Shell Integration

[[ -z "$AXZSH_PLUGIN_CHECK" ]] || return 92

# Check prerequisites ...
axzsh_is_modern_terminal || return 91
[[ -o interactive ]] || return 91
[[ -z "$ITERM_SHELL_INTEGRATION_INSTALLED" ]] || return 91
[[ -z "$NVIM" ]] || return 91
[[ -z "$VIM_TERMINAL" ]] || return 91
[[ "${ITERM_ENABLE_SHELL_INTEGRATION_WITH_TMUX-}$TERM" =~ "^screen" ]] && return 91
[[ "${ITERM_ENABLE_SHELL_INTEGRATION_WITH_TMUX-}$TERM" =~ "^tmux" ]] && return 91

# Add iTerm2 commands to PATH, when available.
[[ -d ~/.iterm2 ]] && path+=(~/.iterm2)

# Try to source user-local shell integration installed by iTerm2 itself,
# and only fall back to the implementation here when not found.
[[ -e "$HOME/.iterm2_shell_integration.zsh" ]] && source "$HOME/.iterm2_shell_integration.zsh"

# ax-zsh specific iTerm2 functions
iterm2_clear_captured_output() {
	printf "\e]1337;ClearCapturedOutput\e\\"
}

[[ -z "$ITERM_SHELL_INTEGRATION_INSTALLED" ]] || return 0

ITERM_SHELL_INTEGRATION_INSTALLED="Yes"
ITERM2_SHOULD_DECORATE_PROMPT="1"

if [[ -n "$TMUX" ]]; then
	# Pass escape sequences through in tmux(1), see
	# <https://gist.github.com/antifuchs/c8eca4bcb9d09a7bbbcd>.
	TMUX_PREFIX='\ePtmux;\e'
	TMUX_POSTFIX='\e\\'
else
	unset TMUX_PREFIX TMUX_POSTFIX
fi

# Indicates start of command output. Runs just before command executes.
iterm2_before_cmd_executes() {
	if [[ "$TERM_PROGRAM" = "iTerm.app" ]]; then
		printf "${TMUX_PREFIX}\033]133;C;\r\007${TMUX_POSTFIX}"
	else
		printf "${TMUX_PREFIX}\033]133;C;\007${TMUX_POSTFIX}"
	fi
}

iterm2_set_user_var() {
	printf "${TMUX_PREFIX}\033]1337;SetUserVar=%s=%s\007${TMUX_POSTFIX}" "$1" "$(printf "%s" "$2" | base64 | tr -d '\n')"
}

# Users can write their own version of this method. It should call
# iterm2_set_user_var but not produce any other output.
# e.g., iterm2_set_user_var currentDirectory $PWD
# Accessible in iTerm2 (in a badge now, elsewhere in the future) as
# \(user.currentDirectory).
if ! whence iterm2_print_user_vars >/dev/null; then
	iterm2_print_user_vars() {
		:
	}
fi

iterm2_print_state_data() {
	printf "${TMUX_PREFIX}\033]1337;RemoteHost=%s@%s\007${TMUX_POSTFIX}" "$USER" "$HOST"
	printf "${TMUX_PREFIX}\033]1337;CurrentDir=%s\007${TMUX_POSTFIX}" "$PWD"
	iterm2_print_user_vars
}

# Report return code of command; runs after command finishes but before prompt
iterm2_after_cmd_executes() {
	printf "${TMUX_PREFIX}\033]133;D;%s\007${TMUX_POSTFIX}" "$STATUS"
	iterm2_print_state_data
}

# Mark start of prompt
iterm2_prompt_mark() {
	printf "${TMUX_PREFIX}\033]133;A\007${TMUX_POSTFIX}"
}

# Mark end of prompt
iterm2_prompt_end() {
	printf "${TMUX_PREFIX}\033]133;B\007${TMUX_POSTFIX}"
}

# There are three possible paths in life.
#
# 1) A command is entered at the prompt and you press return.
#    The following steps happen:
#    * iterm2_preexec is invoked
#      * PS1 is set to ITERM2_PRECMD_PS1
#      * ITERM2_SHOULD_DECORATE_PROMPT is set to 1
#    * The command executes (possibly reading or modifying PS1)
#    * iterm2_precmd is invoked
#      * ITERM2_PRECMD_PS1 is set to PS1 (as modified by command execution)
#      * PS1 gets our escape sequences added to it
#    * zsh displays your prompt
#    * You start entering a command
#
# 2) You press ^C while entering a command at the prompt.
#    The following steps happen:
#    * (iterm2_preexec is NOT invoked)
#    * iterm2_precmd is invoked
#      * iterm2_before_cmd_executes is called since we detected that iterm2_preexec was not run
#      * (ITERM2_PRECMD_PS1 and PS1 are not messed with, since PS1 already has our escape
#        sequences and ITERM2_PRECMD_PS1 already has PS1's original value)
#    * zsh displays your prompt
#    * You start entering a command
#
# 3) A new shell is born.
#    * PS1 has some initial value, either zsh's default or a value set before this script is sourced.
#    * iterm2_precmd is invoked
#      * ITERM2_SHOULD_DECORATE_PROMPT is initialized to 1
#      * ITERM2_PRECMD_PS1 is set to the initial value of PS1
#      * PS1 gets our escape sequences added to it
#    * Your prompt is shown and you may begin entering a command.
#
# Invariants:
# * ITERM2_SHOULD_DECORATE_PROMPT is 1 during and just after command execution, and "" while the prompt is
#   shown and until you enter a command and press return.
# * PS1 does not have our escape sequences during command execution
# * After the command executes but before a new one begins, PS1 has escape sequences and
#   ITERM2_PRECMD_PS1 has PS1's original value.
iterm2_decorate_prompt() {
	# This should be a raw PS1 without iTerm2's stuff. It could be changed during command
	# execution.
	ITERM2_PRECMD_PS1="$PS1"
	ITERM2_SHOULD_DECORATE_PROMPT=""

	# Add our escape sequences just before the prompt is shown.
	# Use ITERM2_SQUELCH_MARK for people who can't modify PS1 directly, like powerlevel9k users.
	# This is gross but I had a heck of a time writing a correct if statement for zsh 5.0.2.
	local PREFIX=""
	if [[ $PS1 == *"$(iterm2_prompt_mark)"* ]]; then
		PREFIX=""
	elif [[ "${ITERM2_SQUELCH_MARK-}" != "" ]]; then
		PREFIX=""
	else
		PREFIX="%{$(iterm2_prompt_mark)%}"
	fi
	PS1="$PREFIX$PS1%{$(iterm2_prompt_end)%}"
	ITERM2_DECORATED_PS1="$PS1"
}

iterm2_precmd() {
	local STATUS="$?"
	if [[ -z "${ITERM2_SHOULD_DECORATE_PROMPT-}" ]]; then
		# You pressed ^C while entering a command (iterm2_preexec did not run)
		iterm2_before_cmd_executes
		if [[ "$PS1" != "${ITERM2_DECORATED_PS1-}" ]]; then
			# PS1 changed, perhaps in another precmd. See issue 9938.
			ITERM2_SHOULD_DECORATE_PROMPT="1"
		fi
	fi

	iterm2_after_cmd_executes "$STATUS"

	if [[ -n "$ITERM2_SHOULD_DECORATE_PROMPT" ]]; then
		iterm2_decorate_prompt
	fi
}

# This is not run if you press ^C while entering a command.
iterm2_preexec() {
	# Set PS1 back to its raw value prior to executing the command.
	PS1="$ITERM2_PRECMD_PS1"
	ITERM2_SHOULD_DECORATE_PROMPT="1"
	iterm2_before_cmd_executes
}

precmd_functions+=(iterm2_precmd)
preexec_functions+=(iterm2_preexec)

iterm2_print_state_data
printf "${TMUX_PREFIX}\033]1337;ShellIntegrationVersion=14;shell=zsh\007${TMUX_POSTFIX}"
