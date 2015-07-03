# AX-ZSH: Alex' Modular ZSH Configuration
# 80_local_config.zlogin: Read local configuration

[[ -r "/var/lib/$HOST/zlogin" ]] \
	&& source "/var/lib/$HOST/zlogin"
