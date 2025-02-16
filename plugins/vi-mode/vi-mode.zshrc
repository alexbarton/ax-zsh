# AX-ZSH: Alex' Modular ZSH Configuration
# vi-mode.zshrc: Setup "VI mode" in ZSH

# This plugin is optional.
[[ -z "$AXZSH_PLUGIN_CHECK" ]] || return 92

bindkey -v
export KEYTIMEOUT=25

# Insert mode

bindkey -M viins '^[[H' beginning-of-line
bindkey -M viins '^A' beginning-of-line

bindkey -M viins '^[[F' end-of-line
bindkey -M viins '^E' end-of-line

bindkey -M viins '^U' backward-kill-line
bindkey -M viins '^K' kill-line

bindkey -M viins '^[.' insert-last-word

# Normal mode (command mode)

bindkey -M vicmd 'j' history-search-forward
bindkey -M vicmd 'k' history-search-backward

# VI Mode Environment

# Change cursor shape for different vi modes.
function zle-keymap-select {
	case "${KEYMAP}" in
	'main' | 'viins')
		# Use '|' style cursor in main and insert mode:
		echo -ne '\e[5 q'
		;;
	*)
		# Use the default (block) cursor otherwise ...
		echo -ne '\e[1 q'
		;;
	esac
}
zle -N zle-keymap-select

# Enforce insert mode on each new command line, which in turn calls the
# zle-keymap-select() function and therefore correctly initialises the curser.
function zle-line-init() {
	zle -K viins
}
zle -N zle-line-init

# Reset the cursor to the default (block) mode before calling commands.
function __vi_mode_cursor_block() {
	echo -ne '\e[1 q'
}
preexec_functions+=(__vi_mode_cursor_block)
