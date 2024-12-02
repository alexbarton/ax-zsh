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

# Default secondary, select and execution trace prompts. Note: Can become
# overwritten by the theme later on.
PS2="%_$fg_no_bold[yellow]»$reset_color "
PS3="$fg_no_bold[yellow]?$reset_color "
PS4="$fg_no_bold[yellow]->$reset_color "

# The PS3 and PS4 prompts are compatible with sh(1) and bash(1), too, and
# "unlikely" to get overwritten by themes. So let's export them to be useful
# in sub-shells as well!
# NOTE: PS1 is set by themes, and PS2 is set to a ZSH-specific setting here in
# this file. So we DO NOT export those!
export PS3 PS4

# NOTE: The theme itself is read in by the ax.zsh script itself: last and into
# the global context (code for the cache file is generated as required).
