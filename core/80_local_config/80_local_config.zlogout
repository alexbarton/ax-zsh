# AX-ZSH: Alex' Modular ZSH Configuration
# 80_local_config.zlogout: Read local configuration

[if [[ -r "$HOME/.zlogout.local" ]]; then
	[[ -f "$HOME/.axzsh.debug" ]] && echo "» $HOME/.zlogout.local:"
	source "$HOME/.zlogout.local"
	[[ -f "$HOME/.axzsh.debug" ]] && echo "» $HOME/.zlogout.local (end)"
fi

if [[ -r "/var/lib/$HOST/zlogout" ]]; then
	[[ -f "$HOME/.axzsh.debug" ]] && echo "» /var/lib/$HOST/zlogout:"
	source "/var/lib/$HOST/zlogout"
	[[ -f "$HOME/.axzsh.debug" ]] && echo "» /var/lib/$HOST/zlogout (end)"
fi
