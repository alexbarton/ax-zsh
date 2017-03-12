# AX-ZSH: Alex' Modular ZSH Configuration
# icalbuddy.zshrc: Show reminders using icalBuddy(1).

# Make sure that "icalBuddy(1)" is installed.
(( $+commands[icalBuddy] )) || return 1

# Check if reminders have been shown during last 60 minutes, and if so,
# don't show them now but return.
[[ -z `find ~/.last_reminder -mmin -60 2>/dev/null` ]] || return 0

tmpfile=$(mktemp ${TMPDIR:-/tmp}/icalbuddy.XXXXXX) || return 1

if axzsh_is_utf_terminal; then
	bul="•"; bul_imp="!"; sep="»"
else
	bul="*"; bul_imp="!"; sep=">"
fi

# Show reminders now.
icalBuddy -f -n -b " $bul " -ab " $bul_imp " -ps "/ $sep /" \
	-nc -npn -iep "title,due" -stda \
	tasksDueBefore:today 2>/dev/null >>"$tmpfile"
icalBuddy -f -n -b " $bul " -ab " $bul_imp " -ps "/ $sep /" \
	-nc -npn -iep "title,datetime" \
	eventsToday+1 2>/dev/null  >>"$tmpfile"

if [[ -s "$tmpfile" ]]; then
	echo; cat "$tmpfile"; echo
fi

rm -f "$tmpfile"
unset bul bul_imp sep tmpfile

# Wtite "stamp" file.
[[ -w ~/ ]] && touch ~/.last_reminder
