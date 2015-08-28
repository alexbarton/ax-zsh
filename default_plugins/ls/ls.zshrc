# AX-ZSH: Alex' Modular ZSH Configuration
# ls.zshrc: Setup ls(1)

# Check which ls-alike command to use
if (( $+commands[gls] )); then
	cmd="gls"	# GNU ls (on NetBSD, for example)
elif (( $+commands[colorls] )); then
	cmd="colorls"	# OpenBSD
else
	cmd="ls"
fi

if $cmd --color -d . >/dev/null 2>&1; then
	alias ls="$cmd -F --color=tty"
elif $cmd -G -d . >/dev/null 2>&1; then
	alias ls="$cmd -FG"
fi

# Use LS_COLORS for completion too, when available
if [[ -n "$LS_COLORS" ]]; then
	zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
fi
