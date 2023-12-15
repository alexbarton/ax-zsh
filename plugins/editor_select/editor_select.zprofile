# AX-ZSH: Alex' Modular ZSH Configuration
# editor_select.zprofile: Setup $EDITOR for the "best" available editor

if [[ -n "$EDITOR" && ! -x "$EDITOR" && -z "$commands[$EDITOR]" ]]; then
	# Oops, current $EDITOR seems to be invalid! Start over!
	unset EDITOR
fi

if [[ -z "$EDITOR" ]]; then
	# Check user preferences first!
	if [[ -r ~/.selected_editor ]]; then
		. ~/.selected_editor
		if [[ -x "$SELECTED_EDITOR" || -n "$commands[$SELECTED_EDITOR]" ]]; then
			EDITOR="$SELECTED_EDITOR"
		fi
		unset SELECTED_EDITOR
	fi
fi

if [[ -z "$EDITOR" ]]; then
	# Auto-detect a "good" editor ...
	if [[ -n "$DISPLAY" ]]; then
		# X11 available, consider X11-based editors, too!
		x11_editors="gvim"
	fi

	for editor (
		sensible-editor
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
