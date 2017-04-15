# AX-ZSH: Alex' Modular ZSH Configuration
# 30_hostname.zprofile: Initialize hostname settings

# Setup "HOSTNAME" variable
[[ -z "$HOSTNAME" ]] && HOSTNAME=$( hostname )
export HOSTNAME

# Setup "SHORT_HOST" variable
if (( $+commands[scutil] )); then
	SHORT_HOST=$(scutil --get ComputerName 2>/dev/null)
elif (( $+commands[hostnamectl] )); then
	SHORT_HOST=$(hostnamectl --pretty 2>/dev/null)
	[[ "$SHORT_HOST" =~ : ]] && unset SHORT_HOST
fi
[[ -z "$SHORT_HOST" ]] && SHORT_HOST=${HOST/.*/}
export SHORT_HOST
