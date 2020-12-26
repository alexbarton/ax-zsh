# AX-ZSH: Alex' Modular ZSH Configuration
# 30_env.ax-io: Setup environment

# Make sure TMPDIR ends in a slash (like on macOS by default): this makes its
# usage a bit safer ...
case "$TMPDIR" in
	*/) ;;
	*)  TMPDIR="$TMPDIR/"
esac
export TMPDIR

# TMPDIR is the only one required to be set, but make sure that TMP, TEMP
# and TEMPDIR are set to the same sane path name when already present in the
# environment:
[[ -n "$TMP" ]] && TMP="$TMPDIR"
[[ -n "$TEMP" ]] && TEMP="$TMPDIR"
[[ -n "$TEMPDIR" ]] && TEMPDIR="$TMPDIR"
