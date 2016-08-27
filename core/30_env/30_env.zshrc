# AX-ZSH: Alex' Modular ZSH Configuration
# 30_env.zshrc: Setup environment

# Setup TMPDIR. Try to reset TMPDIR (when it is not set but TMP is), which is
# common in tools like screen(1) because Linux removes some varibes for
# "setgit" tools (see <https://bugzilla.redhat.com/show_bug.cgi?id=129682#c1>).
# And therefore this has to be checked here, because inside of screen probably
# no login shell is started ...
[[ -z "$TMPDIR" && -n "$TMP" ]] && TMPDIR="$TMP"

# Make sure TMP and TMPDIR become exported when they are set:
[[ -n "$TMP" ]] && export TMP
[[ -n "$TMPDIR" ]] && export TMPDIR
