# AX-ZSH: Alex' Modular ZSH Configuration
# 01_zprofile.zshrc: Make sure zpfofile files are read

[[ -z "$AXZSH_ZPROFILE_READ" ]] || return

# No "ax-io" and "zprofile" files have been read in already, looks like this is
# a non-login shell instance and not a (direct) child of a AX-ZSH enabled login
# shell! So we have to make sure everything is set up properly by reading in
# the "ax-io" and "zprofile" stages first!

[[ -n "$AXZSH_DEBUG" ]] && echo "» 01_zprofile.zsh:"

# Reset some environment variables, that could contain "garbage" ...
unset PS1

axzsh_handle_stage "01_zprofile.zsh" "ax-io"
axzsh_handle_stage "01_zprofile.zsh" "zprofile"
AXZSH_ZPROFILE_READ=2

[[ -n "$AXZSH_DEBUG" ]] && echo "» 01_zprofile.zsh (end)"
