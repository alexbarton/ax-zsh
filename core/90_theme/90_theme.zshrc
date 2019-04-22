# AX-ZSH: Alex' Modular ZSH Configuration
# 90_theme.zshrc: Load AX-ZSH theme

# Don't load any "enhanced" theme on dumb terminals, but instead use a very
# simple and sane built-in prompt that should work "everywhere". And try to
# make sure that nothing else "disturbs" such terminals ...
if ! axzsh_is_modern_terminal; then
	if axzsh_is_dumb_terminal; then
		# Don't use any theme on dumb terminals!
		unset AXZSH_THEME

		# Set simple prompt:
		PS1="%n@%m:%3~ %# "
		unset RPS1
	else
		# Use the default theme on legacy ("not modern") terminals:
		AXZSH_THEME="$AXZSH/themes/ax.axzshtheme"
	fi

	# See <https://github.com/syl20bnr/spacemacs/issues/3035>
	unset zle_bracketed_paste
fi

# NOTE: The theme itself is read in by the ax.zsh script itself: last and into
# the global context (code for the cache file is generated as required).
