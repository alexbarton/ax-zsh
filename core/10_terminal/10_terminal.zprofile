# AX-ZSH: Alex' Modular ZSH Configuration
# 10_terminal.zprofile: Initialize terminal settings

[[ -t 0 ]] && eval `tset -s`
[[ -z "$TERM" ]] && TERM="dumb"
export TERM
