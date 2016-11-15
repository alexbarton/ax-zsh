# AX-ZSH: Alex' Modular ZSH Configuration
# ssh-pageant.zshrc: Setup ssh-pageant

# Make sure that "ssh-pageant(1)" is installed.
(( $+commands[ssh-pageant] )) || return

# Start up agent, reuse existing socket.
eval $(/usr/bin/ssh-pageant -q -r -a /var/run/pageant-$LOGNAME.sock)
