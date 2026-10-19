# AX-ZSH: Alex' Modular ZSH Configuration
# 30_hostname.zprofile: Initialize hostname settings

# Setup legacy "HOSTNAME" variable (use "HOST"!)
[[ -z "$HOSTNAME" ]] && HOSTNAME="$HOST"
export HOSTNAME

# Setup "SHORT_HOST" variable
if (( $+commands[scutil] )); then
	SHORT_HOST=$(scutil --get ComputerName 2>/dev/null)
elif [[ -r /etc/machine-info ]]; then
	# Read the "pretty hostname" of systemd-hostnamed(8) directly, which is
	# way faster than calling "hostnamectl --pretty" (D-Bus round trip):
	SHORT_HOST=${(Q)${${(M)${(f)"$(</etc/machine-info)"}:#PRETTY_HOSTNAME=*}[1]}#PRETTY_HOSTNAME=}
	[[ "$SHORT_HOST" =~ : ]] && unset SHORT_HOST
fi
[[ -z "$SHORT_HOST" ]] && SHORT_HOST=${HOST/.*/}
export SHORT_HOST
