# AX-ZSH: Alex' Modular ZSH Configuration
# 80_local_config.zlogout: Read local configuration

[[ -r "/var/lib/$HOST/zlogout" ]] \
	&& source "/var/lib/$HOST/zlogout"
