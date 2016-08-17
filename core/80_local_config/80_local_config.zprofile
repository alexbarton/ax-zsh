# AX-ZSH: Alex' Modular ZSH Configuration
# 80_local_config.zprofile: Read local configuration

if [[ -r "$HOME/.zprofile.local" ]]; then
	[[ -f "$HOME/.axzsh.debug" ]] && echo "» $HOME/.zprofile.local:"
	source "$HOME/.zprofile.local"
	[[ -f "$HOME/.axzsh.debug" ]] && echo "» $HOME/.zprofile.local (end)"
fi

if [[ -r "/var/lib/$HOST/zprofile" ]]; then
	[[ -f "$HOME/.axzsh.debug" ]] && echo "» /var/lib/$HOST/zprofile:"
	source "/var/lib/$HOST/zprofile"
	[[ -f "$HOME/.axzsh.debug" ]] && echo "» /var/lib/$HOST/zprofile (end)"
elif [[ -r "/var/lib/$HOST/profile" ]]; then
	[[ -f "$HOME/.axzsh.debug" ]] && echo "» /var/lib/$HOST/profile:"
	source "/var/lib/$HOST/profile"
	[[ -f "$HOME/.axzsh.debug" ]] && echo "» /var/lib/$HOST/profile (end)"
fi
