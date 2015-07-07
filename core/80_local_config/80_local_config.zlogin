# AX-ZSH: Alex' Modular ZSH Configuration
# 80_local_config.zlogin: Read local configuration

if [[ -r "/var/lib/$HOST/zlogin" ]]; then
	[[ -f "$HOME/.axzsh.debug" ]] && echo "» /var/lib/$HOST/zlogin:"
	source "/var/lib/$HOST/zlogin"
	[[ -f "$HOME/.axzsh.debug" ]] && echo "» /var/lib/$HOST/zlogin (end)"
fi
