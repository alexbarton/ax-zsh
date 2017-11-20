# AX-ZSH: Alex' Modular ZSH Configuration
# 90_theme.zshrc: Load AX-ZSH theme

# Don't load any "enhanced" theme on dumb terminals, but instead use a very
# simple and sane built-in prompt that should work "everywhere". And try to
# make sure that nothing else "disturbs" such terminals ...
if axzsh_is_dumb_terminal; then
	PS1="%n@%m:%3~ %# "
	unset RPS1

	# See <https://github.com/syl20bnr/spacemacs/issues/3035>
	unset zle_bracketed_paste

	return
fi

# Read in the theme configuration.
[[ -n "$AXZSH_THEME" ]] && source "$AXZSH_THEME"
