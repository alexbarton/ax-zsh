# AX-ZSH: Alex' Modular ZSH Configuration
# 99_cleanup.zshrc: Don't pollute the namespace, remove variables/functions/...

[[ -o login ]] && return

source "$AXZSH/core/99_cleanup/99_cleanup.zlogin"
