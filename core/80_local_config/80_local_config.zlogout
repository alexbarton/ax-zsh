# AX-ZSH: Alex' Modular ZSH Configuration
# 80_local_config.zlogout: Read local configuration

if [[ -r "$HOME/.zlogout.local" ]]; then
	[[ -n "$AXZSH_DEBUG" ]] && echo "» $HOME/.zlogout.local:"
	source "$HOME/.zlogout.local"
	[[ -n "$AXZSH_DEBUG" ]] && echo "» $HOME/.zlogout.local (end)"
fi

if [[ -r "/var/lib/$HOST/zlogout" ]]; then
	[[ -n "$AXZSH_DEBUG" ]] && echo "» /var/lib/$HOST/zlogout:"
	source "/var/lib/$HOST/zlogout"
	[[ -n "$AXZSH_DEBUG" ]] && echo "» /var/lib/$HOST/zlogout (end)"
fi
