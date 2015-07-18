# AX-ZSH: Alex' Modular ZSH Configuration
# virtualenvwrapper: Initialize Python "virtualenvwrapper"

for script (
	/usr/local/bin/virtualenvwrapper.sh
	/usr/bin/virtualenvwrapper.sh
	/etc/bash_completion.d/virtualenvwrapper
); do
	if [[ -r "$script" ]]; then
		# Found virtualenvwrapper
		[[ -z "$PROJECT_HOME" && -r "$LOCAL_HOME/Develop" ]] \
			&& PROJECT_HOME="$LOCAL_HOME/Develop"
		[[ -z "$WORKON_HOME" ]] \
			&& WORKON_HOME="$XDG_CACHE_HOME/virtualenvs"

		source "$script"

		# pip
		export PIP_REQUIRE_VIRTUALENV="true"

		break
	fi
done
unset script
