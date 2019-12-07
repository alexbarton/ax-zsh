# AX-ZSH: Alex' Modular ZSH Configuration
# docker.zprofile: Setup "docker" with "docker-machine"

# Make sure that "docker-machine" is installed
(( $+commands[docker-machine] )) || return

# Setup environment
if ! eval "$(docker-machine env default 2>/dev/null)"; then
	# Clean environment on error
	eval "$(docker-machine env -u)"
fi
