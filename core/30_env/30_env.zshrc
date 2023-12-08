# AX-ZSH: Alex' Modular ZSH Configuration
# 30_env.ax-io: Setup environment

if [[
	"$TMPDIR" = '/' ||
	-z "$TMPDIR" ||
	-z "$XDG_CACHE_HOME" ||
	-z "$XDG_RUNTIME_DIR" ||
	-z "$ZSH_CACHE_DIR"
]]; then
	# Looks like the environment wasn't set up/exported properly!
	[[ -n "$AXZSH_DEBUG" ]] && echo 'Note: Fixing up the environment!'
	. "$AXZSH/core/30_env/30_env.ax-io"
fi
