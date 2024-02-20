# AX-ZSH: Alex' Modular ZSH Configuration
# browser_select.zprofile: Setup $BROWSER for the "best" available WWW browser

# Don't run this plugin on "check-plugins"!
[[ -z "$AXZSH_PLUGIN_CHECK" ]] || return 92

if [[ -z "$BROWSER" ]]; then
	if [[ "$OSTYPE" != "linux-gnu" ]]; then
		# Check for open(1) on Non-Linux systems. On (Debian-) Linux, the open(1)
		# command would recursively call $BROWSER (=itself) ...
		open_browsers="open"
	fi
	if [[ -n "$DISPLAY" ]]; then
		# X11 available, consider X11-based browsers, too!
		x11_browsers="firefox chrome"
	fi

	# Note: We can't use xdg-open(1) here, as xdg-open itself tries to use
	# $BROWSER, and this would result in an endless loop!
	for browser (
		$open_browsers
		$x11_browsers
		elinks w3m links2 links lynx
	); do
		if [[ -n "$commands[$browser]" ]]; then
			BROWSER="$commands[$browser]"
			break
		fi
	done
	unset browser open_browser x11_browsers
fi

[[ -n "$BROWSER" ]] && export BROWSER
