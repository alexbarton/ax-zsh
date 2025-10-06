# # AX-ZSH: Alex' Modular ZSH Configuration
# 50_path.zprofile: Fix PATH environment after plugins ran

# Prepend and append search paths (in a special order!)
_axzsh_setup_path
unfunction _axzsh_setup_path
typeset -Ux PATH

# Set default MANPATH
MANPATH="$(manpath -q)" 2>/dev/null
if [[ $? -ne 0 ]]; then
	for d (
		~/share/man
		~/man
		/opt/*/share/man(NOn)
		/opt/*/man(NOn)
		/usr/share/man
		/usr/local/share/man
	); do
		[[ -d "$d" ]] && manpath+=("$d")
	done
fi
typeset -Ux MANPATH
