# AX-ZSH: Alex' Modular ZSH Configuration
# virtualenv: Activate an "virtual environment"

# This plugin is optional.
[[ -z "$AXZSH_PLUGIN_CHECK" ]] || return 92

function activate() {
	for d (
		./bin
		./env/bin
		./venv/bin
		./.venv/bin
	); do
		script="$d/activate"
		test -r "$script" || continue

		# Read in activation script fragment ...
		source "$script" && return 0

		echo "Failed to read script \"$script\"!" >&2
		return 1
	done
	echo "No virtual environment found!" >&2
	return 1
}
