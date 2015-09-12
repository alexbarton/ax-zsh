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
		echo "$@"
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

S=$(dirname "$0")

if [ "$S" = "$AXZSH" -o "$PWD" = "$AXZSH" ]; then
	ax_msg 1 "Initializing \"$AXZSH\":"
else
	ax_msg 1 "Install AX-ZSH into \"$AXZSH\":"

	[ -L "$AXZSH" ] && rm -f "$AXZSH"
	mkdir -p "$AXZSH" || exit 1

	ax_msg - "Copying binaries and scripts ..."
	cp -pRv "$S/ax.zsh"* "$AXZSH/" || exit 1
	mkdir -p "$AXZSH/bin" || exit 1
	cp -pRv "$S/bin/"* "$AXZSH/bin/" || exit 1

	for f in AUTHORS LICENSE.md README.md; do
		cp -pRv "$S/$f" "$AXZSH/" || exit 1
	done

	ax_msg - "Copying plugins ..."
	for plugin_type in core default_plugins plugins; do
		mkdir -p "$AXZSH/$plugin_type" || exit 1
		for p in "$S/$plugin_type/"*; do
			echo "$p -> $AXZSH/$p"
			rm -fr "${AXZSH:?}/$p" || exit 1
			cp -pR "$S/$p" "$AXZSH/$p" || exit 1
		done
	done
fi

ax_msg - "Linking ZSH startup files ..."

for f in ~/.zlogin ~/.zlogout ~/.zprofile ~/.zshrc; do
	safe_rm "$f" || exit 1
	ln -sv "$AXZSH/ax.zsh" "$f" || exit 1
done

if [ ! -d "$AXZSH/active_plugins" ]; then
	ax_msg - "Initializing plugin directory \"$AXZSH/active_plugins\" ..."
	type zsh >/dev/null 2>&1
	if [ $? -eq 0 ]; then
		zsh "$AXZSH/bin/axzshctl" reset-plugins
		exit $?
	else
		ax_msg 2 "Oops, \"zsh\" not found!?"
		exit 1
	fi
else
	ax_msg - "Plugin directory \"$AXZSH/active_plugins\" already exists. Ok."
fi
