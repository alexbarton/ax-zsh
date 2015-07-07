# AX-ZSH: Alex' Modular ZSH Configuration
# 80_local_config.zshrc: Read local configuration

if [[ -r "$HOME/.zshrc.local" ]]; then
	[[ -f "$HOME/.axzsh.debug" ]] && echo "» $HOME/.zshrc.local:"
	source "$HOME/.zshrc.local"
	[[ -f "$HOME/.axzsh.debug" ]] && echo "» $HOME/.zshrc.local (end)"
fi

if [[ -r "/var/lib/$HOST/zshrc" ]]; then
	[[ -f "$HOME/.axzsh.debug" ]] && echo "» /var/lib/$HOST/zshrc:"
	source "/var/lib/$HOST/zshrc"
	[[ -f "$HOME/.axzsh.debug" ]] && echo "» /var/lib/$HOST/zshrc (end)"
fi
