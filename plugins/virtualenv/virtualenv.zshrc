# AX-ZSH: Alex' Modular ZSH Configuration
# virtualenv: Activate an "virtual environment"

# This plugin is optional.
[[ -z "$AXZSH_PLUGIN_CHECK" ]] || return 92

function activate() {
	local d r

	# Make sure no "virtual environment" is already active!
	if [[ -n "$VIRTUAL_ENV" ]]; then
		echo "Oops, looks like a virtual environment is already active!" >&2
		return 1
	fi

	if [[ -r Pipfile ]]; then
		pipenv run "$SHELL"; r=$?
		return $r
	fi
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

if [[ -n "$PIPENV_ACTIVE" ]]; then
	alias deactivate=exit
fi
