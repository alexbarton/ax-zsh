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

[ -n "$AXZSH" ] || AXZSH="$HOME/.axzsh"
export AXZSH

echo "* Installing AX-ZSH into \"$AXZSH\" ..."

safe_rm "$AXZSH" || exit 1
ln -sv "$PWD" "$AXZSH" || exit 1

for f in ~/.zlogin ~/.zlogout ~/.zprofile ~/.zshrc; do
	safe_rm "$f" || exit 1
	ln -sv "$AXZSH/ax.zsh" "$f" || exit 1
done

if [ ! -d "$AXZSH/active_plugins" ]; then
	echo "* Initializing plugin directory \"$AXZSH/active_plugins\" ..."
	zsh "$AXZSH/bin/axzshctl" reset-plugins
else
	echo "* Plugin directory \"$AXZSH/active_plugins\" already exists. Ok."
fi
