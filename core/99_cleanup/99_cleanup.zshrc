# AX-ZSH: Alex' Modular ZSH Configuration
# 99_cleanup.zshrc: Don't pollute the namespace, remove variables/functions/...

[[ -o login ]] && return
[[ "$AXZSH_ZPROFILE_READ" = "2" ]] && return

source "$AXZSH/core/99_cleanup/99_cleanup.zlogin"
