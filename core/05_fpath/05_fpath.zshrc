# AX-ZSH: Alex' Modular ZSH Configuration
# 05_fpath.zshrc: Setup AX-ZSH "fpath"

typeset -xTU AXZSH_FPATH axzsh_fpath 2>/dev/null

# Search for additional ZSH function paths: lower priority than plugins
for dir (
	/usr/local/share/zsh/site-functions(N)
	/usr/share/zsh/site-functions(N)
); do
		[[ -d "$dir" ]] && axzsh_fpath=($axzsh_fpath "$dir")
done

# Add current "fpath" to axzsh_fpath
axzsh_fpath=($axzsh_fpath $fpath)

# Search for additional ZSH function paths: higher priority than plugins
for dir (
	$HOME/.config/zsh/functions(N)
	$HOME/.zsh/functions(N)
); do
	[[ -d "$dir" ]] && axzsh_fpath=("$dir" $axzsh_fpath)
done

# Set ZSH "fpath" from axzsh_fpath (which is exported to subshells)
fpath=($axzsh_fpath)
