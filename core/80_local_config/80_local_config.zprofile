# AX-ZSH: Alex' Modular ZSH Configuration
# 80_local_config.zprofile: Read local configuration

if [[ -r "/var/lib/$HOST/zprofile" ]]; then
	[[ -f "$HOME/.axzsh.debug" ]] && echo "» /var/lib/$HOST/zprofile:"
	source "/var/lib/$HOST/zprofile"
	[[ -f "$HOME/.axzsh.debug" ]] && echo "» /var/lib/$HOST/zprofile (end)"
fi
