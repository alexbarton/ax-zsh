# AX-ZSH: Alex' Modular ZSH Configuration
# 80_local_config.zprofile: Read local configuration

[[ -r "/var/lib/$HOST/zprofile" ]] \
	&& source "/var/lib/$HOST/zprofile"
