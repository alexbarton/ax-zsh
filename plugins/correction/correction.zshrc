# AX-ZSH: Alex' Modular ZSH Configuration
# correction.zshrc: Setup correction

for cmd in \
	brew \
	ebuild \
	gist \
	man \
	mkdir \
	mv \
	mysql \
	sudo \
; do
	[[ -n $commands[$cmd] ]] \
		&& alias $cmd="nocorrect $cmd"
done

setopt correct_all
