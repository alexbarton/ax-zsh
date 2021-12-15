# AX-ZSH: Alex' Modular ZSH Configuration
# editor_select.zprofile: Setup $EDITOR for the "best" available editor

if [[ -z "$EDITOR" ]]; then
	if [[ -n "$DISPLAY" ]]; then
		# X11 available, consider X11-based editors, too!
		x11_editors="gvim"
	fi

	for editor (
		code atom mate subl mvim
		$x11_editors
		vim nano joe vi
	); do
		if [[ -n "$commands[$editor]" ]]; then
			EDITOR="$commands[$editor]"
			break
		fi
	done
	unset editor x11_editors
fi

case "$EDITOR:t" in
	"code"|"atom"|"mate"|"subl")
		EDITOR="$EDITOR --wait"
		;;
	"mvim"|"gvim")
		EDITOR="$EDITOR --nofork"
		;;
esac

[[ -n "$EDITOR" ]] && export EDITOR
