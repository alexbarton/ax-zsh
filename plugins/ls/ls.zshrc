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
	return 0
fi
if $cmd -G -d . >/dev/null 2>&1; then
	alias ls="$cmd -FG"
	return 0
fi
