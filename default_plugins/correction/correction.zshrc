# AX-ZSH: Alex' Modular ZSH Configuration
# correction.zshrc: Setup correction

# Always-available commands, for example shell bultin. No need to check for
# existence, always define "nocorrect alias".
for cmd (
	alias
	command
	echo
	print
	printf
	type
	which
); do
	alias $cmd="nocorrect $cmd"
done

# Optional commands, check for existence first before creating the alias!
for cmd (
	apt
	aptitude
	brew
	ebuild
	gist
	man
	mkdir
	mv
	mysql
	pgrep
	pkg_add
	pkill
	sudo
); do
	[[ -n $commands[$cmd] ]] \
		&& alias $cmd="nocorrect $cmd"
done

setopt correct_all

SPROMPT="$ZSH_NAME: Correct \"$fg[yellow]%R$reset_color\" to \"$fg[green]%r$reset_color\" [$fg_bold[white]nyae$reset_color]? "

unset cmd
