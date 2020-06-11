# AX-ZSH: Alex' Modular ZSH Configuration
# remind.zshrc: Show reminders of remind(1).

# Make sure that "remind(1)" is installed.
(( $+commands[remind] )) || return 1

# Don't run this plugin on "check-plugins"!
[[ -z "$AXZSH_PLUGIN_CHECK" ]] || return 0

# Some handy alias.
alias remindcal='remind -ccu+3 -m -w$COLUMNS,4,0 $HOME/.remind'

# Don't show reminders when ~/.hushlogin exists ...
[[ -r ~/.hushlogin ]] && return 0

# Is there a file with reminders?
[[ -r ~/.remind ]] || return 0

# Check if reminders have been shown during last 60 minutes, and if so,
# don't show them now but return.
[[ -z `find ~/.last_reminder -mmin -60 2>/dev/null` ]] || return 0

# Show reminders now.
remind -h -g -t5 ~/.remind && echo

# Wtite "stamp" file.
[[ -w ~/ ]] && touch ~/.last_reminder
