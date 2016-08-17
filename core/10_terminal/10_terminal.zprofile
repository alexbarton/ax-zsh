# AX-ZSH: Alex' Modular ZSH Configuration
# 10_terminal.zprofile: Initialize terminal settings

[[ -t 0 ]] && eval `tset -Is -m "dec-vt52:vt52"`
[[ -z "$TERM" ]] && TERM="dumb"
export TERM
