# AX-ZSH: Alex' Modular ZSH Configuration
# spectrum.zshrc: Helper functions showing the available "color spectrum".

# This plugin is optional.
[[ -z "$AXZSH_PLUGIN_CHECK" ]] || return 92

ZSH_SPECTRUM_TEXT=${ZSH_SPECTRUM_TEXT:-The quick brown fox jumps over the lazy dog}

# Show all 256 foreground colors with color number
function spectrum_ls() {
	test "$TERM_COLORS" -gt 0 || return 1
	for code in {000..$((TERM_COLORS-1))}; do
		print -P -- "$code: $FG[$code]$ZSH_SPECTRUM_TEXT$FX[reset]"
	done
}

# Show all 256 background colors with color number
function spectrum_bls() {
	test "$TERM_COLORS" -gt 0 || return 1
	for code in {000..$((TERM_COLORS-1))}; do
		print -P -- "$code: $BG[$code]$ZSH_SPECTRUM_TEXT$FX[reset]"
	done
}

# NOTE for FG, BG and FX arrays, and spectrum_ls() and spectrum_bls() functions:
# Based on a script to make using 256 colors in zsh less painful, written by
# P.C. Shyamshankar <sykora@lucentbeing.com>.
# Copied from OhMyZsh https://github.com/robbyrussell/oh-my-zsh/blob/master/lib/spectrum.zsh
# which was copied from https://github.com/sykora/etc/blob/master/zsh/functions/spectrum/ :-)
