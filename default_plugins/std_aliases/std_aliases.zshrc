# AX-ZSH: Alex' Modular ZSH Configuration
# std_aliases: Setup standard aliases

alias ll="ls -hl"
alias l="ll -a"
alias la="ll -A"

alias lasth='last -aw | head -n "$((LINES-1))"'
alias lastf='last -aw | grep -v "^$LOGNAME"'

alias d='dirs -v | head -10'
alias 1='cd ~1 && pwd'
alias 2='cd ~2 && pwd'
alias 3='cd ~3 && pwd'
alias 4='cd ~4 && pwd'
alias 5='cd ~5 && pwd'
alias 6='cd ~6 && pwd'
alias 7='cd ~7 && pwd'
alias 8='cd ~8 && pwd'
alias 9='cd ~9 && pwd'
alias -- -='cd -'

alias md='mkdir -p'
alias rd=rmdir
