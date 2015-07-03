# AX-ZSH: Alex' Modular ZSH Configuration
# 30_hostname.zprofile: Initialize hostname settings

# Setup "HOSTNAME" variable
[[ -z "$HOSTNAME" ]] && HOSTNAME=$( hostname )
export HOSTNAME

# Setup "SHORT_HOST" variable
[[ "$OSTYPE" = darwin* ]] \
	&& SHORT_HOST=$(scutil --get ComputerName 2>/dev/null)
[[ -z "$SHORT_HOST" ]] && SHORT_HOST=${HOST/.*/}
export SHORT_HOST
