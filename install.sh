#!/bin/sh
#
# AX-ZSH: Alex' Modular ZSH Configuration
# Copyright (c) 2015 Alexander Barton <alex@barton.de>
#

# Include "ax-common.sh":
for dir in "$HOME/lib" "$HOME/.ax" /usr/local /opt/ax /usr; do
	[ -z "$ax_common_sourced" ] || break
	ax_common="${dir}/lib/ax/ax-common.sh"
	[ -r "$ax_common" ] && . "$ax_common"
done
if [ -z "$ax_common_sourced" ]; then
	ax_msg() {
		shift
		echo "1" "$@"
	}
fi
unset dir ax_common ax_common_sourced

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

ax_msg - "Installing AX-ZSH into \"$AXZSH\" ..."

safe_rm "$AXZSH" || exit 1
ln -sv "$PWD" "$AXZSH" || exit 1

for f in ~/.zlogin ~/.zlogout ~/.zprofile ~/.zshrc; do
	safe_rm "$f" || exit 1
	ln -sv "$AXZSH/ax.zsh" "$f" || exit 1
done

if [ ! -d "$AXZSH/active_plugins" ]; then
	ax_msg - "Initializing plugin directory \"$AXZSH/active_plugins\" ..."
	zsh "$AXZSH/bin/axzshctl" reset-plugins
else
	ax_msg - "Plugin directory \"$AXZSH/active_plugins\" already exists. Ok."
fi
