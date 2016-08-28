# AX-ZSH: Alex' Modular ZSH Configuration
# 10_terminal.zprofile: Initialize terminal settings

# Use tset(1) to validate TERM when stdin as a tty. Explicitly set SHELL to
# /bin/sh to force tset to output sh-compliant commands even when SHELL was not
# set correctly or for an other shell.
[[ -t 0 ]] && eval `SHELL=/bin/sh tset -Is -m "dec-vt52:vt52"`

# Is TERM still unset?
[[ -z "$TERM" ]] && TERM="dumb"

export TERM
