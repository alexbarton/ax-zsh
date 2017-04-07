# AX-ZSH: Alex' Modular ZSH Configuration
# 80_local_config.zlogin: Read local configuration

if [[ -r "$HOME/.zlogin.local" ]]; then
	[[ -n "$AXZSH_DEBUG" ]] && echo "» $HOME/.zlogin.local:"
	source "$HOME/.zlogin.local"
	[[ -n "$AXZSH_DEBUG" ]] && echo "» $HOME/.zlogin.local (end)"
fi

if [[ -r "/var/lib/$HOST/zlogin" ]]; then
	[[ -n "$AXZSH_DEBUG" ]] && echo "» /var/lib/$HOST/zlogin:"
	source "/var/lib/$HOST/zlogin"
	[[ -n "$AXZSH_DEBUG" ]] && echo "» /var/lib/$HOST/zlogin (end)"
fi
