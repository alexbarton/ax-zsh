# AX-ZSH: Alex' Modular ZSH Configuration
# vi-mode.zshrc: Setup "VI mode" in ZSH

# This plugin is optional.
[[ -z "$AXZSH_PLUGIN_CHECK" ]] || return 92

bindkey -v
export KEYTIMEOUT=25

# All modes

function _bindkey_all {
	for mode (viins vicmd); do
		bindkey -M ${mode} "$@"
	done
}

_bindkey_all '^[[H' beginning-of-line		# POS1
_bindkey_all '^[[1~' beginning-of-line
_bindkey_all '^[[F' end-of-line			# END
_bindkey_all '^[[4~' end-of-line
_bindkey_all '^[[3~' delete-char		# DEL

_bindkey_all '^G' send-break

_bindkey_all "^X'" quote-line
_bindkey_all '^X"' quote-region
_bindkey_all '^X1' after-first-word
_bindkey_all '^X=' what-cursor-position

_bindkey_all '^X^B' vi-match-bracket
_bindkey_all '^X^E' edit-command-line
_bindkey_all '^X^F' vi-find-next-char
_bindkey_all '^X^J' vi-join
_bindkey_all '^X^K' kill-buffer
_bindkey_all '^X^U' undo

_bindkey_all '^[^[' sudo-command-line

unfunction _bindkey_all

# Insert mode

bindkey -M viins '^A' beginning-of-line
bindkey -M viins '^E' end-of-line

bindkey -M viins '^U' backward-kill-line
bindkey -M viins '^K' kill-line

bindkey -M viins '^[.' insert-last-word

# Visual mode

bindkey -M visual '"' quote-region

# Normal mode (command mode)

bindkey -M vicmd 'j' history-search-forward
bindkey -M vicmd 'k' history-search-backward

# VI Mode Environment

# Change cursor shape for different vi modes.
function zle-line-init zle-keymap-select {
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
zle -N zle-line-init

# Reset the cursor to the default (block) mode before calling commands.
function __vi_mode_cursor_block {
	echo -ne '\e[1 q'
}
preexec_functions+=(__vi_mode_cursor_block)
