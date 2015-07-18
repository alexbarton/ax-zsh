# AX-ZSH: Alex' Modular ZSH Configuration
# std_aliases: Setup standard aliases

alias ".."="cd .."

alias "ll"="ls -hl"
alias "l"="ll -a"

alias lasth='last | head -n "$((LINES-1))"'
alias lastf='last | grep -v "^$LOGNAME"'
