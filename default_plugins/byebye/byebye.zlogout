# AX-ZSH: Alex' Modular ZSH Configuration
# byebye.zlogout -- Say goodbye to interactive users

[[ -o interactive ]] || return
[[ -z "$AXZSH_PLUGIN_CHECK" ]] || return 92

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
