# AX-ZSH: Alex' Modular ZSH Configuration
# std_env: Setup standard environment variables

export CLICOLOR=${CLICOLOR:-1}
export MANWIDTH=${MANWIDTH:-80}

if [[ "$TERM_PROGRAM" != "WarpTerminal" ]]; then
	export REPORTTIME=${REPORTTIME:-5}
fi
