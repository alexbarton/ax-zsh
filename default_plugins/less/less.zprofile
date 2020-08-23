# AX-ZSH: Alex' Modular ZSH Configuration
# less.zprofile: Setup less

# Make sure that "less(1)" is installed
(( $+commands[less] )) || return

export PAGER="$commands[less]"
export LESS="-FmRX"

# Support colors in less
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

if (( $+commands[lesspipe] )); then
	eval "$(lesspipe)"
elif (( $+commands[lesspipe.sh] )); then
	# Silence lesspipe(1), see <https://github.com/wofr06/lesspipe/issues/21>
	export LESSQUIET=1
	eval "$(lesspipe.sh)"
fi
