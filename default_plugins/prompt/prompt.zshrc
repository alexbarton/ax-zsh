# AX-ZSH: Alex' Modular ZSH Configuration
# prompt.zlogin: Setup default prompts

[[ -r "$AXZSH/active_theme" ]] \
	&& source "$AXZSH/active_theme" \
	|| source "$AXZSH/themes/ax.axzshtheme"
