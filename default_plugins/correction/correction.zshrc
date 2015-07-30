# AX-ZSH: Alex' Modular ZSH Configuration
# correction.zshrc: Setup correction

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
	pkg_add
	sudo
); do
	[[ -n $commands[$cmd] ]] \
		&& alias $cmd="nocorrect $cmd"
done

setopt correct_all
