# AX-ZSH: Alex' Modular ZSH Configuration
# 80_local_config.zshrc: Read local configuration

if [[ -r "/var/lib/$HOST/zshrc" ]]; then
	[[ -f "$HOME/.axzsh.debug" ]] && echo "» /var/lib/$HOST/zshrc:"
	source "/var/lib/$HOST/zshrc"
	[[ -f "$HOME/.axzsh.debug" ]] && echo "» /var/lib/$HOST/zshrc (end)"
fi
