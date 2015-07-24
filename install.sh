#!/bin/sh
#
# AX-ZSH: Alex' Modular ZSH Configuration
# Copyright (c) 2015 Alexander Barton <alex@barton.de>
#

safe_rm() {
	if [ -f "$1" -a ! -L "$1" ]; then
		rm -f "$1.bak" || exit 1
		mv -v "$1" "$1.bak" || exit 1
	fi
	rm -f "$1" || exit 1
}

umask 027

safe_rm ~/.axzsh || exit 1
ln -sv "$PWD" ~/.axzsh || exit 1

for f in ~/.zlogin ~/.zlogout ~/.zprofile ~/.zshrc; do
	safe_rm "$f" || exit 1
	ln -sv ~/.axzsh/ax.zsh "$f" || exit 1
done
