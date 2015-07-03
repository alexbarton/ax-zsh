# AX-ZSH: Alex' Modular ZSH Configuration
# 80_local_config.zshrc: Read local configuration

[[ -r "/var/lib/$HOST/zshrc" ]] \
	&& source "/var/lib/$HOST/zshrc"
