# AX-ZSH: Alex' Modular ZSH Configuration
# venv.zshrc: Support Python "venv" virtual environments

[[ -z "$AXZSH_PLUGIN_CHECK" ]] || return 92

function activate() {
	for p (.venv/bin bin); do
		activate="$PWD/$p/activate"
		if [[ -r "$activate" ]]; then
			source "$activate"
			return 0
		fi
	done
	echo "No virtual environment found in \"$PWD\"!"
	return 1
}
