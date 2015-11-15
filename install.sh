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
		rm -f "$1.bak" || abort
		mv -v "$1" "$1.bak" || abort
	fi
	rm -f "$1" || abort
}

abort() {
	ax_msg 2 "Failed to setup AX-ZSH!"
	exit 1
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
	mkdir -p "$AXZSH" || abort

	ax_msg - "Copying binaries and scripts ..."
	cp -pRv "$S/ax.zsh"* "$AXZSH/" || abort
	mkdir -p "$AXZSH/bin" || abort
	cp -pRv "$S/bin/"* "$AXZSH/bin/" || abort

	for f in AUTHORS LICENSE.md README.md; do
		cp -pRv "$S/$f" "$AXZSH/" || abort
	done

	ax_msg - "Copying plugins ..."
	for plugin_type in core default_plugins plugins; do
		mkdir -p "$AXZSH/$plugin_type" || abort
		for p in "$S/$plugin_type/"*; do
			echo "$p -> $AXZSH/$p"
			rm -fr "${AXZSH:?}/$p" || abort
			cp -pR "$S/$p" "$AXZSH/$p" || abort
		done
	done

	ax_msg - "Copying themes ..."
	mkdir -p "$AXZSH/themes" || abort
	for p in "$S/themes/"*; do
		echo "$p -> $AXZSH/$p"
		rm -fr "${AXZSH:?}/$p" || abort
		cp -pR "$S/$p" "$AXZSH/$p" || abort
	done
fi

mkdir -p "$AXZSH/custom_plugins" || abort
mkdir -p "$AXZSH/custom_themes" || abort

ax_msg - "Linking ZSH startup files ..."

for f in ~/.zlogin ~/.zlogout ~/.zprofile ~/.zshrc; do
	safe_rm "$f" || abort
	ln -sv "$AXZSH/ax.zsh" "$f" || abort
done

if [ ! -d "$AXZSH/active_plugins" ]; then
	ax_msg - "Initializing plugin directory \"$AXZSH/active_plugins\" ..."
	which zsh >/dev/null 2>&1
	if [ $? -eq 0 ]; then
		zsh "$AXZSH/bin/axzshctl" reset-plugins || abort
	else
		ax_msg 1 "Oops, \"zsh\" not found!?"
	fi
else
	ax_msg - "Plugin directory \"$AXZSH/active_plugins\" already exists. Ok."
fi

ax_msg 0 "AX-ZSH setup successfully."
