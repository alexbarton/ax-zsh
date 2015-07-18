# AX-ZSH: Alex' Modular ZSH Configuration
# std_env: Setup standard environment variables

export MANWIDTH="80"

(( $+commands[less] )) && export LESS="-FmRX"
