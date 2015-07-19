# AX-ZSH: Alex' Modular ZSH Configuration
# 05_fpath.zshrc: Setup AX-ZSH "fpath"

typeset -xTU AXZSH_FPATH axzsh_fpath 2>/dev/null

[[ -n "$AXZSH_FPATH" ]] && fpath=($axzsh_fpath $fpath)
