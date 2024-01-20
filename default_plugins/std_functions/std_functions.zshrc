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
	if [[ $# -eq 0 ]]; then
		cd "$(mktemp -d)"
		pwd
	else
		mkdir -p "$@" && cd "${@:$#}"
	fi
}

function untake() {
	pwd="${PWD}/"
	subdir="${pwd##$TMPDIR}"
	if [[ "${PWD%tmp.*}" = "${TMPDIR}" && -n "$subdir" ]]; then
		tmp_d="${TMPDIR}${subdir%%/*}"
		echo "$tmp_d"
		cd
		rm -fr "$@" "${tmp_d}"
	else
		echo 'Sorry, not a temporarily taken directory!' >&2
		return 1
	fi
}

function zsh_stats() {
	fc -l 1 \
	| awk '{CMD[$2]++;count++;}END { for (a in CMD)print CMD[a] " " CMD[a]/count*100 "% " a;}' \
	| grep -v "./" | column -c3 -s " " -t | sort -nr | nl -w 3 -s ": " | head -n20
}
