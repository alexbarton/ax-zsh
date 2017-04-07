# AX-ZSH: Alex' Modular ZSH Configuration
# 80_local_config.zshrc: Read local configuration

if [[ -r "$HOME/.zshrc.local" ]]; then
	[[ -n "$AXZSH_DEBUG" ]] && echo "» $HOME/.zshrc.local:"
	source "$HOME/.zshrc.local"
	[[ -n "$AXZSH_DEBUG" ]] && echo "» $HOME/.zshrc.local (end)"
fi

if [[ -r "/var/lib/$HOST/zshrc" ]]; then
	[[ -n "$AXZSH_DEBUG" ]] && echo "» /var/lib/$HOST/zshrc:"
	source "/var/lib/$HOST/zshrc"
	[[ -n "$AXZSH_DEBUG" ]] && echo "» /var/lib/$HOST/zshrc (end)"
fi
