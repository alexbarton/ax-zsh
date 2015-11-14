# AX-ZSH: Alex' Modular ZSH Configuration
# editor_select.zprofile: Setup $EDITOR for the "best" available editor

if [[ -z "$EDITOR" ]]; then
	for editor in atom mate subl vim nano joe vi; do
		if [ -n "$commands[$editor]" ]; then
			EDITOR="$commands[$editor]"
			break
		fi
	done
	unset editor
fi

case "$EDITOR:t" in
	"atom"|"mate"|"subl")
		EDITOR="$EDITOR --wait"
		;;
esac

if [ -n "$EDITOR" ]; then
	export EDITOR
	alias zshenv="$EDITOR ~/.zshenv"
fi
