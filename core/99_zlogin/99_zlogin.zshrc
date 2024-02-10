# AX-ZSH: Alex' Modular ZSH Configuration
# 99_zlogin.zshrc: Make sure zlogin files are read

[[ "$AXZSH_ZPROFILE_READ" = "2" ]] || return

# AXZSH_ZPROFILE_READ is set to 2 when the "ax-io" and "zprofile" were caught
# up because this is not a login shell and the environment was missing. In this
# case the "zlogin" stage will be missing in the end as well and therefore we
# run the "zlogin" stage manually, too.
[[ -n "$AXZSH_DEBUG" ]] && echo "» 99_zlogin.zshrc:"

axzsh_handle_stage "99_zlogin.zshrc" "zlogin"
AXZSH_ZLOGIN_READ=2

[[ -n "$AXZSH_DEBUG" ]] && echo "» 99_zlogin.zshrc (end)"
