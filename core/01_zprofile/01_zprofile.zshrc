# AX-ZSH: Alex' Modular ZSH Configuration
# 01_zprofile.zshrc: Make sure zprofile files are read

[[ -z "$AXZSH_ZPROFILE_READ" ]] || return

# No "zprofile" (and "ax-io") stage files have been read in already, so looks
# like this is a non-login shell instance but not a (direct) child of an AX-ZSH
# enabled login shell! This can happen in graphical terminals not starting a
# login shell, for example. So most probably some environment configuration is
# missing and we have to make sure everything is set up properly by reading in
# the "ax-io" and "zprofile" stages before continuing!
[[ -n "$AXZSH_DEBUG" ]] && echo "» 01_zprofile.zshrc:"

# Reset some environment variables, that could contain "garbage" ...
unset PS1

axzsh_handle_stage "01_zprofile.zshrc" "ax-io"
axzsh_handle_stage "01_zprofile.zshrc" "zprofile"
AXZSH_ZPROFILE_READ=2

[[ -n "$AXZSH_DEBUG" ]] && echo "» 01_zprofile.zshrc (end)"
