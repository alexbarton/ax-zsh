# AX-ZSH: Alex' Modular ZSH Configuration
# 05_fpath.zshrc: Setup AX-ZSH "fpath"

typeset -xTU AXZSH_FPATH axzsh_fpath

[[ -n "$AXZSH_FPATH" ]] && fpath=($axzsh_fpath $fpath)
