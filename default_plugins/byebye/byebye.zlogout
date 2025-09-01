# AX-ZSH: Alex' Modular ZSH Configuration
# byebye.zlogout -- Say goodbye to interactive users

[[ -o interactive ]] || return
[[ -z "$AXZSH_PLUGIN_CHECK" ]] || return 92

# Check for a container environment:
if [[ -e /run/.containerenv ]]; then
	# Try to get some infos about the environment ...
	unset name
	. /run/.containerenv 2>/dev/null

	# Don't show any info when ~/.hushlogin exists ...
	[[ -r ~/.hushlogin ]] && return 0

	echo "You left the ${name:-container} environment."
	return 0
fi

# Clear the console if it is a local terminal
case `tty` in
    /dev/tty[0-9]*|/dev/ttyS[0-9]*)
	[[ -x /usr/bin/clear_console ]] \
		&& /usr/bin/clear_console --quiet \
		|| clear
	;;
    *)
	# Don't show any info when ~/.hushlogin exists ...
	[[ -r ~/.hushlogin ]] && return 0

	echo "Bye, bye, $LOGNAME!"
	echo
esac
