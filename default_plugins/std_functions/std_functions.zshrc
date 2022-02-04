# AX-ZSH: Alex' Modular ZSH Configuration
# std_functions: Setup standard ("common") functions

function open_command() {
	case $OSTYPE in
		darwin*)
			open "$@" || return 1
			;;
		cygwin*)
			cygstart "$@" || return 1
			;;
		linux*)
			if [[ -n "$DISPLAY" ]]; then
				# X11
				nohup xdg-open "$@" &>/dev/null || return 1
			else
				xdg-open "$@" || return 1
			fi
			;;
		*)
			return 2
	esac
	return 0
}

function take() {
	mkdir -p "$@" && cd "${@:$#}"
}

function zsh_stats() {
	fc -l 1 \
	| awk '{CMD[$2]++;count++;}END { for (a in CMD)print CMD[a] " " CMD[a]/count*100 "% " a;}' \
	| grep -v "./" | column -c3 -s " " -t | sort -nr | nl -w 3 -s ": " | head -n20
}
