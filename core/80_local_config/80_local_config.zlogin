# AX-ZSH: Alex' Modular ZSH Configuration
# 80_local_config.zlogin: Read local configuration

if [[ -r "$HOME/.zlogin.local" ]]; then
	[[ -f "$HOME/.axzsh.debug" ]] && echo "» $HOME/.zlogin.local:"
	source "$HOME/.zlogin.local"
	[[ -f "$HOME/.axzsh.debug" ]] && echo "» $HOME/.zlogin.local (end)"
fi

if [[ -r "/var/lib/$HOST/zlogin" ]]; then
	[[ -f "$HOME/.axzsh.debug" ]] && echo "» /var/lib/$HOST/zlogin:"
	source "/var/lib/$HOST/zlogin"
	[[ -f "$HOME/.axzsh.debug" ]] && echo "» /var/lib/$HOST/zlogin (end)"
fi
