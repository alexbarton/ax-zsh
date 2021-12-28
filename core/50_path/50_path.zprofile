# # AX-ZSH: Alex' Modular ZSH Configuration
# 50_path.zprofile: Fix PATH environment after plugins ran

# Prepend and append search paths (in a special order!)
_axzsh_setup_path
unfunction _axzsh_setup_path

typeset -Ux PATH MANPATH
