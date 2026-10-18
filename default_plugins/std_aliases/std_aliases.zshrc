# AX-ZSH: Alex' Modular ZSH Configuration
# std_aliases: Setup standard aliases

alias ll="ls -hl"
alias l="ls -ahl"
alias la="ls -Ahl"
alias lx="ls -A"

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

alias cp="cp -i"
alias mv="mv -i"
alias rm="rm -I"

alias md='mkdir -p'
alias rd=rmdir

alias dud='du -d 1 -h'
alias ff='find . -type f -iname'

# Global aliases

alias -g CA="2>&1 | cat -A"
alias -g G="| grep -i"
alias -g H="| head"
alias -g L="| less"
alias -g LL="2>&1 | less"
alias -g NE="2>/dev/null"
alias -g NUL=">/dev/null 2>&1"
alias -g 1NUL="1>/dev/null"
alias -g 2NUL="2>/dev/null"
alias -g T="| tail"
alias -g WL="| wc -l"
alias -g X="| xargs"

# Suffix aliases

alias -s {asc,c,cc,cfg,conf,cpp,css,cxx,h,hh,html,ini,json,md,me,php,rc,txt,yml,yaml}="$EDITOR"
