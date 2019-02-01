# AX-ZSH: Alex' Modular ZSH Configuration
# gcc.zprofile: Setup GNU Compiler Collection (GCC) environment.

# Make sure that "go(1)" is installed
(( $+commands[gcc] )) || return

GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'
export GCC_COLORS
