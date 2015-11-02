# AX-ZSH: Alex' Modular ZSH Configuration
# theme.zshrc: Setup AX-ZSH theme

[[ -r "$AXZSH/active_theme" ]] \
	&& AXZSH_THEME="$AXZSH/active_theme" \
	|| AXZSH_THEME="$AXZSH/themes/ax.axzshtheme"
